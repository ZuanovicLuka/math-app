package math.backend.repository;

import math.backend.model.Quiz;
import math.backend.model.User;
import math.backend.model.UserQuiz;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.data.domain.Pageable;
import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

public interface UserQuizRepository extends JpaRepository<UserQuiz, Long> {
    Optional<UserQuiz> findByUserAndQuiz(User user, Quiz quiz);

    @Query("SELECT uq FROM UserQuiz uq WHERE uq.user = :user AND DATE(uq.startTime) = :date")
    Optional<UserQuiz> findTodayQuizByUser(@Param("user") User user, @Param("date") LocalDate date);

    List<UserQuiz> findByQuiz_QuizDateAndQuiz_SchoolLevelAndEndTimeIsNotNullOrderByScoreDescTimeTakenSecondsAsc(
        LocalDate quizDate,
        String schoolLevel,
        Pageable pageable
    );

    @Query("SELECT COUNT(uq) + 1 FROM UserQuiz uq " +
            "WHERE uq.quiz.quizDate = :date AND uq.quiz.schoolLevel = :schoolLevel AND uq.endTime IS NOT NULL " +
            "AND (uq.score > :score OR (uq.score = :score AND uq.timeTakenSeconds < :timeTakenSeconds))")
    long findUserRank(
            @Param("date") LocalDate date,
            @Param("schoolLevel") String schoolLevel,
            @Param("score") int score,
            @Param("timeTakenSeconds") int timeTakenSeconds);
}