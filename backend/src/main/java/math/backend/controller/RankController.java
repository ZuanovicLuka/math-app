package math.backend.controller;

import math.backend.config.JwtService;
import math.backend.dto.UserRankingDTO;
import math.backend.model.User;
import math.backend.model.UserQuiz;
import math.backend.repository.UserQuizRepository;
import math.backend.service.UserService;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@RestController
@RequestMapping("/api/rank")
public class RankController {
    private final UserQuizRepository userQuizRepository;
    private final UserService userService;
    private final JwtService jwtService;

    public RankController(UserQuizRepository userQuizRepository, UserService userService, JwtService jwtService) {
        this.userQuizRepository = userQuizRepository;
        this.userService = userService;
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

    @GetMapping("/top-users")
    public ResponseEntity<?> getTopUsersByDateAndSchoolLevel(
            @RequestHeader("Authorization") String authHeader,
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate date) {

        try {
            User user = getUserFromToken(authHeader);

            Pageable topFifty = PageRequest.of(0, 20);
            List<UserQuiz> topQuizzes = userQuizRepository
                    .findByQuiz_QuizDateAndQuiz_SchoolLevelAndEndTimeIsNotNullOrderByScoreDescTimeTakenSecondsAsc(
                            date, user.getSchoolLevel(), topFifty);

            List<UserRankingDTO> result = new ArrayList<>();
            int currentPosition = 1;
            int previousScore = -1;
            int previousTimeTaken = -1;
            int sameScoreCount = 0;

            for (int i = 0; i < topQuizzes.size(); i++) {
                UserQuiz userQuiz = topQuizzes.get(i);
                User quizUser = userQuiz.getUser();

                // ako vise user-a ima isti score i isto vrijeme njihova pozicija je ista u tih top 20
                if (i > 0 && userQuiz.getScore() == previousScore &&
                        userQuiz.getTimeTakenSeconds() == previousTimeTaken) {
                    sameScoreCount++;
                } else {
                    currentPosition += sameScoreCount;
                    sameScoreCount = 0;
                    currentPosition = i + 1;
                }

                UserRankingDTO dto = new UserRankingDTO(
                        currentPosition,
                        quizUser.getUserId(),
                        quizUser.getUsername(),
                        quizUser.getFirstName(),
                        quizUser.getLastName(),
                        quizUser.getProfilePicture(),
                        userQuiz.getScore(),
                        userQuiz.getTimeTakenSeconds(),
                        userQuiz.getEndTime()
                );

                result.add(dto);

                previousScore = userQuiz.getScore();
                previousTimeTaken = userQuiz.getTimeTakenSeconds();
            }

            return ResponseEntity.ok()
                    .contentType(MediaType.APPLICATION_JSON)
                    .body(Map.of(
                            "status", "success",
                            "data", result,
                            "message", "Success"
                    ));

        } catch (Exception e) {
            return ResponseEntity.status(401)
                    .contentType(MediaType.APPLICATION_JSON)
                    .body(Map.of(
                            "status", "error",
                            "message", e.getMessage()
                    ));
        }
    }

    @GetMapping("/user-rank")
    public ResponseEntity<?> getUserRank(
            @RequestHeader("Authorization") String authHeader,
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate date) {

        try {
            User user = getUserFromToken(authHeader);

            // Pronađi korisnikov kviz za taj datum
            Optional<UserQuiz> userQuizOpt = userQuizRepository.findTodayQuizByUser(user, date);
            if (userQuizOpt.isEmpty() || userQuizOpt.get().getEndTime() == null) {
                return ResponseEntity.ok()
                        .contentType(MediaType.APPLICATION_JSON)
                        .body(Map.of(
                                "status", "success",
                                "data", null,
                                "message", "User hasn't completed the quiz for this date"
                        ));
            }

            UserQuiz userQuiz = userQuizOpt.get();

            // Izračunaj rang korisnika
            long rank = userQuizRepository.findUserRank(
                    date,
                    user.getSchoolLevel(),
                    userQuiz.getScore(),
                    userQuiz.getTimeTakenSeconds());

            // Kreiraj DTO
            UserRankingDTO result = new UserRankingDTO(
                    (int) rank,
                    user.getUserId(),
                    user.getUsername(),
                    user.getFirstName(),
                    user.getLastName(),
                    user.getProfilePicture(),
                    userQuiz.getScore(),
                    userQuiz.getTimeTakenSeconds(),
                    userQuiz.getEndTime()
            );

            return ResponseEntity.ok()
                    .contentType(MediaType.APPLICATION_JSON)
                    .body(Map.of(
                            "status", "success",
                            "data", result,
                            "message", "Success"
                    ));

        } catch (Exception e) {
            return ResponseEntity.status(401)
                    .contentType(MediaType.APPLICATION_JSON)
                    .body(Map.of(
                            "status", "error",
                            "message", e.getMessage()
                    ));
        }
    }
}