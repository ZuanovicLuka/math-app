package math.backend.dto;

import java.time.LocalDate;
import java.util.List;

public class QuizDTO {
    private Long quizId;
    private LocalDate quizDate;
    private String schoolLevel;
    private List<QuestionDTO> questions;

    // Konstruktori
    public QuizDTO() {
    }

    public QuizDTO(Long quizId, LocalDate quizDate, String schoolLevel, List<QuestionDTO> questions) {
        this.quizId = quizId;
        this.quizDate = quizDate;
        this.schoolLevel = schoolLevel;
        this.questions = questions;
    }

    // Getteri i setteri
    public Long getQuizId() {
        return quizId;
    }

    public void setQuizId(Long quizId) {
        this.quizId = quizId;
    }

    public LocalDate getQuizDate() {
        return quizDate;
    }

    public void setQuizDate(LocalDate quizDate) {
        this.quizDate = quizDate;
    }

    public String getSchoolLevel() {
        return schoolLevel;
    }

    public void setSchoolLevel(String schoolLevel) {
        this.schoolLevel = schoolLevel;
    }

    public List<QuestionDTO> getQuestions() {
        return questions;
    }

    public void setQuestions(List<QuestionDTO> questions) {
        this.questions = questions;
    }
}