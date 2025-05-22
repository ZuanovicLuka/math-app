package math.backend.repository;

import math.backend.model.Quiz;
import math.backend.model.User;
import math.backend.model.UserQuiz;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import java.time.LocalDate;
import java.util.Optional;

public interface UserQuizRepository extends JpaRepository<UserQuiz, Long> {
    Optional<UserQuiz> findByUserAndQuiz(User user, Quiz quiz);

    @Query("SELECT uq FROM UserQuiz uq WHERE uq.user = :user AND DATE(uq.startTime) = :date")
    Optional<UserQuiz> findTodayQuizByUser(@Param("user") User user, @Param("date") LocalDate date);

    boolean existsByUserAndQuiz(User user, Quiz quiz);
}