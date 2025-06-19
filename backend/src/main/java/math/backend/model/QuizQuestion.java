package math.backend.model;

import jakarta.persistence.*;

@Entity
@Table(name = "quiz_question")
public class QuizQuestion {
    // pk, autoincrement
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "question_id")
    private Long questionId;

    @ManyToOne
    @JoinColumn(name = "quiz_id", nullable = false)
    private Quiz quiz;

    @Column(nullable = false)
    private String text;

    // moguca 4 odgovora spojena znakom ,
    @Column(name = "options", nullable = false)
    private String options;

    @Column(name = "correct_answer_index", nullable = false)
    private int correctAnswerIndex;

    // Default constructor (required by JPA)
    public QuizQuestion() {
    }

    // Constructor without ID (auto-generated)
    public QuizQuestion(Quiz quiz, String text, String options, int correctAnswerIndex) {
        this.quiz = quiz;
        this.text = text;
        this.options = options;
        this.correctAnswerIndex = correctAnswerIndex;
    }

    // Constructor without quiz (can be set later)
    public QuizQuestion(String text, String options, int correctAnswerIndex) {
        this(null, text, options, correctAnswerIndex);
    }

    public Long getQuestionId() {
        return questionId;
    }

    public void setQuestionId(Long questionId) {
        this.questionId = questionId;
    }

    public Quiz getQuiz() {
        return quiz;
    }

    public void setQuiz(Quiz quiz) {
        this.quiz = quiz;
    }

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }

    public String getOptions() {
        return options;
    }

    public void setOptions(String options) {
        this.options = options;
    }

    public int getCorrectAnswerIndex() {
        return correctAnswerIndex;
    }

    public void setCorrectAnswerIndex(int correctAnswerIndex) {
        this.correctAnswerIndex = correctAnswerIndex;
    }

    // toString() method for debugging purposes
    @Override
    public String toString() {
        return "QuizQuestion{" +
                "questionId=" + questionId +
                ", quiz=" + (quiz != null ? quiz.getQuizId() : "null") +
                ", text='" + text + '\'' +
                ", options=" + options +
                ", correctAnswerIndex=" + correctAnswerIndex +
                '}';
    }
}