package math.backend.service;

import math.backend.dto.QuestionDTO;
import math.backend.dto.QuizDTO;
import math.backend.model.Quiz;
import math.backend.model.QuizQuestion;
import math.backend.model.User;
import math.backend.model.UserQuiz;
import math.backend.repository.QuizRepository;
import math.backend.repository.UserQuizRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
public class QuizService {
    private final QuizRepository quizRepository;
    private final UserQuizRepository userQuizRepository;

    public QuizService(QuizRepository quizRepository, UserQuizRepository userQuizRepository) {
        this.quizRepository = quizRepository;
        this.userQuizRepository = userQuizRepository;
    }

    public Optional<Quiz> getDailyQuiz(String schoolLevel) {
        return quizRepository.findByQuizDateAndSchoolLevel(LocalDate.now(), schoolLevel);
    }

    // ovo transactional samo označava da se sve što se radi u tijelu smatra jednom aktivnosti
    // odnosno ako je uspješno obavit će se sve u tijelu, a ako dođe do greške neće se ništa obaviti
    @Transactional
    public UserQuiz startQuiz(User user, Quiz quiz) {
        Optional<UserQuiz> existing = userQuizRepository.findByUserAndQuiz(user, quiz);
        if (existing.isPresent()) {
            return existing.get();
        }

        UserQuiz userQuiz = new UserQuiz();
        userQuiz.setUser(user);
        userQuiz.setQuiz(quiz);
        userQuiz.setStartTime(LocalDateTime.now());
        return userQuizRepository.save(userQuiz);
    }

    @Transactional
    public UserQuiz finishQuiz(User user, Quiz quiz, String answers,
                               int timeTakenSeconds, LocalDateTime endTime) {

        UserQuiz userQuiz = userQuizRepository.findByUserAndQuiz(user, quiz)
                .orElseThrow(() -> new IllegalArgumentException("Kviz nije započet"));

        int score = calculateScore(quiz, answers);

        userQuiz.setEndTime(endTime);
        userQuiz.setAnswers(answers);
        userQuiz.setScore(score);
        userQuiz.setTimeTakenSeconds(timeTakenSeconds);

        return userQuizRepository.save(userQuiz);
    }

    private int calculateScore(Quiz quiz, String answers) {
        int score = 0;
        List<QuizQuestion> questions = quiz.getQuestions();

        // Pretvori string odgovora u listu integera
        String[] answersArray = answers.split(",");
        List<Integer> answersList = new ArrayList<>();

        for (String answer : answersArray) {
            try {
                answersList.add(Integer.parseInt(answer.trim()));
            } catch (NumberFormatException e) {
                // Ako odgovor nije broj, dodajemo -1 što će sigurno biti netočno
                answersList.add(-1);
            }
        }

        // Provjeri odgovore
        for (int i = 0; i < questions.size() && i < answersList.size(); i++) {
            if (answersList.get(i) == questions.get(i).getCorrectAnswerIndex()) {
                score++;
            }
        }
        return score;
    }

    public boolean hasUserCompletedQuizToday(User user) {
        return userQuizRepository.findTodayQuizByUser(user, LocalDate.now())
                .map(uq -> uq.getEndTime() != null)
                .orElse(false);
    }

    public boolean hasUserStartedQuizToday(User user) {
        return userQuizRepository.findTodayQuizByUser(user, LocalDate.now()).isPresent();
    }

    public QuizDTO getDailyQuizDTO(String schoolLevel) {
        Quiz quiz = quizRepository.findByQuizDateAndSchoolLevel(LocalDate.now(), schoolLevel)
                .orElseThrow(() -> new RuntimeException("Nema kviza za danas"));

        return mapQuizToDTO(quiz);
    }

    private QuizDTO mapQuizToDTO(Quiz quiz) {
        QuizDTO dto = new QuizDTO();
        dto.setQuizId(quiz.getQuizId());
        dto.setQuizDate(quiz.getQuizDate());
        dto.setSchoolLevel(quiz.getSchoolLevel());

        List<QuestionDTO> questionDTOs = quiz.getQuestions().stream()
                .map(q -> new QuestionDTO(
                        q.getText(),
                        q.getOptions().split(","),
                        q.getCorrectAnswerIndex()))
                .collect(Collectors.toList());

        dto.setQuestions(questionDTOs);
        return dto;
    }
}