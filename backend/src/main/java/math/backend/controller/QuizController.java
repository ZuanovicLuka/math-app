package math.backend.controller;

import math.backend.config.JwtService;
import math.backend.dto.QuizDTO;
import math.backend.dto.QuizFinishRequestDTO;
import math.backend.guizGenerator.DailyQuizGenerator;
import math.backend.model.Quiz;
import math.backend.model.User;
import math.backend.model.UserQuiz;
import math.backend.repository.QuizRepository;
import math.backend.repository.UserQuizRepository;
import math.backend.service.QuizService;
import math.backend.service.UserService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.time.Duration;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.Map;

@RestController
@RequestMapping("/api/quizzes")
public class QuizController {
    private final QuizService quizService;
    private final UserService userService;
    private final QuizRepository quizRepository;
    private final UserQuizRepository userQuizRepository;
    private final DailyQuizGenerator dailyQuizGenerator;
    private final JwtService jwtService;

    public QuizController(QuizService quizService, UserService userService, QuizRepository quizRepository, UserQuizRepository userQuizRepository, DailyQuizGenerator dailyQuizGenerator, JwtService jwtService) {
        this.quizService = quizService;
        this.userService = userService;
        this.quizRepository = quizRepository;
        this.userQuizRepository = userQuizRepository;
        this.dailyQuizGenerator = dailyQuizGenerator;
        this.jwtService = jwtService;
    }

    private User getUserFromToken(String authHeader) {
        if (authHeader == null || !authHeader.startsWith("Bearer ")) {
            throw new RuntimeException("Neispravan autorizacijski header");
        }

        String token = authHeader.substring(7);
        String userId = jwtService.extractUserId(token);
        return userService.findById(Long.parseLong(userId))
                .orElseThrow(() -> new RuntimeException("Korisnik nije pronađen za ID: " + userId));
    }

    @GetMapping("/daily")
    public ResponseEntity<?> getDailyQuizAndStart(@RequestHeader("Authorization") String authHeader) {
        try {
            User user = getUserFromToken(authHeader);

            if (quizService.hasUserCompletedQuizToday(user)) {
                return ResponseEntity.badRequest().body(Map.of(
                        "status", "error",
                        "message", "Već ste završili današnji kviz"
                ));
            }

            QuizDTO quizDTO = quizService.getDailyQuizDTO(user.getSchoolLevel(), user.getGrade());

            if (!quizService.hasUserStartedQuizToday(user)) {
                // Ovdje možete dodati logiku za početak kviza ako je potrebno
                // Možda ćete morati prvo dohvatiti Quiz entity
                Quiz quiz = quizRepository.findById(quizDTO.getQuizId())
                        .orElseThrow(() -> new RuntimeException("Kviz nije pronađen"));
                quizService.startQuiz(user, quiz);
            }

            return ResponseEntity.ok(Map.of(
                    "status", "uspjeh",
                    "quiz", quizDTO // Vraćamo cijeli DTO objekt
            ));

        } catch (Exception e) {
            return ResponseEntity.status(401).body(Map.of(
                    "status", "error",
                    "message", e.getMessage()
            ));
        }
    }

    // ovaj ne radi nista osim sto vraca samo danasnji kviz
    @GetMapping("/get-daily-quiz")
    public ResponseEntity<?> getDailyQuiz(@RequestHeader("Authorization") String authHeader) {
        try {
            User user = getUserFromToken(authHeader);

            QuizDTO quizDTO = quizService.getDailyQuizDTO(user.getSchoolLevel(), user.getGrade());

            return ResponseEntity.ok(Map.of(
                    "status", "uspjeh",
                    "quiz", quizDTO // Vraćamo cijeli DTO objekt
            ));

        } catch (Exception e) {
            return ResponseEntity.status(401).body(Map.of(
                    "status", "error",
                    "message", e.getMessage()
            ));
        }
    }

    @PostMapping("/finish")
    public ResponseEntity<?> finishDailyQuiz(
            @RequestHeader("Authorization") String authHeader,
            @RequestBody QuizFinishRequestDTO request) {  // Novi DTO za request body

        try {
            User user = getUserFromToken(authHeader);

            // Provjera datuma
            if (!request.getQuizDate().equals(LocalDate.now())) {
                return ResponseEntity.badRequest().body(Map.of(
                        "status", "error",
                        "message", "Možete završiti samo današnji kviz"
                ));
            }

            Quiz quiz = quizService.getDailyQuiz(user.getSchoolLevel(), user.getGrade())
                    .orElseThrow(() -> new RuntimeException("Današnji kviz nije pronađen"));

            UserQuiz startedQuiz = userQuizRepository.findByUserAndQuiz(user, quiz)
                    .orElseThrow(() -> new RuntimeException("Niste započeli današnji kviz"));

            LocalDateTime endTime = LocalDateTime.now();
            long timeTakenSeconds = Duration.between(startedQuiz.getStartTime(), endTime).getSeconds();

            // maksimalno dozvoljeno vrijeme u sekundama (20 minuta)
            final long MAX_QUIZ_TIME_SECONDS = 20 * 60;

            // ako je korisnik premašio vrijeme, postavimo na maksimalno dozvoljeno
            if (timeTakenSeconds > MAX_QUIZ_TIME_SECONDS) {
                timeTakenSeconds = MAX_QUIZ_TIME_SECONDS;
                endTime = startedQuiz.getStartTime().plusSeconds(MAX_QUIZ_TIME_SECONDS);
            }

            UserQuiz completedQuiz = quizService.finishQuiz(
                    user,
                    quiz,
                    request.getAnswers(),
                    (int) timeTakenSeconds,
                    endTime
            );

            return ResponseEntity.ok(Map.of(
                    "score", completedQuiz.getScore(),
                    "timeTakenSeconds", completedQuiz.getTimeTakenSeconds()));

        } catch (Exception e) {
            return ResponseEntity.status(400).body(Map.of(
                    "status", "error",
                    "message", e.getMessage()
            ));
        }
    }

    // vraća odgovor o tome je li zapoceo i je li zavrsio kviz
    @GetMapping("/status")
    public ResponseEntity<?> getQuizStatus(@RequestHeader("Authorization") String authHeader) {
        try {
            User user = getUserFromToken(authHeader);
            boolean completed = quizService.hasUserCompletedQuizToday(user);
            boolean started = quizService.hasUserStartedQuizToday(user);

            return ResponseEntity.ok(Map.of(
                    "started", started,
                    "completed", completed
            ));

        } catch (Exception e) {
            return ResponseEntity.status(401).body(Map.of(
                    "status", "error",
                    "message", e.getMessage()
            ));
        }
    }

    @GetMapping("/result-by-date")
    public ResponseEntity<?> getQuizResultByDate(
            @RequestHeader("Authorization") String authHeader,
            @RequestParam LocalDate date) {

        try {
            User user = getUserFromToken(authHeader);

            Quiz quiz = quizRepository.findByQuizDateAndSchoolLevelAndGrade(date, user.getSchoolLevel(), user.getGrade())
                    .orElseThrow(() -> new RuntimeException("Kviz nije pronađen za traženi datum"));

            UserQuiz userQuiz = userQuizRepository.findByUserAndQuiz(user, quiz)
                    .orElseThrow(() -> new RuntimeException("Niste rješavali kviz za traženi datum"));

            return ResponseEntity.ok(Map.of(
                    "status", "success",
                    "score", userQuiz.getScore(),
                    "timeTakenSeconds", userQuiz.getTimeTakenSeconds(),
                    "userAnswers", userQuiz.getAnswers(),
                    "date", date
            ));

        } catch (Exception e) {
            return ResponseEntity.status(400).body(Map.of(
                    "status", "error",
                    "message", e.getMessage()
            ));
        }
    }

    // ovo je api za generiranje svih kvizova od jednom
    @PostMapping("/generate-daily-quizzes")
    public ResponseEntity<?> manuallyGenerateDailyQuizzes() {
        dailyQuizGenerator.generateDailyQuizzes();
        return ResponseEntity.ok(Map.of("status", "Dnevni kvizovi generirani ručno"));
    }
}