package math.backend.repository;

import math.backend.model.Quiz;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.time.LocalDate;
import java.util.Optional;

public interface QuizRepository extends JpaRepository<Quiz, Long> {
    @Query("SELECT q FROM Quiz q LEFT JOIN FETCH q.questions WHERE q.quizDate = :date AND q.schoolLevel = :schoolLevel")
    Optional<Quiz> findByQuizDateAndSchoolLevel(@Param("date") LocalDate date, @Param("schoolLevel") String schoolLevel);
}