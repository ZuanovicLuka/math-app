package math.backend.dto;

import java.time.LocalDate;

public class QuizFinishRequestDTO {
    private LocalDate quizDate;
    private String answers;

    // getteri i setteri
    public LocalDate getQuizDate() {
        return quizDate;
    }

    public void setQuizDate(LocalDate quizDate) {
        this.quizDate = quizDate;
    }

    public String getAnswers() {
        return answers;
    }

    public void setAnswers(String answers) {
        this.answers = answers;
    }
}
