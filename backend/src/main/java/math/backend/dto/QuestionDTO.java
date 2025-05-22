package math.backend.dto;

public class QuestionDTO {
    private String text;
    private String[] options;
    private int correctAnswerIndex;

    // Konstruktori
    public QuestionDTO() {
    }

    public QuestionDTO(String text, String[] options, int correctAnswerIndex) {
        this.text = text;
        this.options = options;
        this.correctAnswerIndex = correctAnswerIndex;
    }

    // Getteri i setteri
    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }

    public String[] getOptions() {
        return options;
    }

    public void setOptions(String[] options) {
        this.options = options;
    }

    public int getCorrectAnswerIndex() {
        return correctAnswerIndex;
    }

    public void setCorrectAnswerIndex(int correctAnswerIndex) {
        this.correctAnswerIndex = correctAnswerIndex;
    }
}