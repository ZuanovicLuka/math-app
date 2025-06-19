package math.backend.model;

import jakarta.persistence.*;
import java.util.Objects;

@Entity
@Table(name = "task")
public class Task {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "task_id")
    private Long taskId;

    @ManyToOne
    @JoinColumn(name = "lection_id", nullable = false)
    private Lection lection;

    @Column(name = "question_text", nullable = false)
    private String questionText;

    @Column(nullable = false)
    private String options; // Format: "Odgovor1@Odgovor2@Odgovor3@Odgovor4"

    @Column(name = "correct_answer_index", nullable = false)
    private int correctAnswerIndex;

    public Task() {
    }

    public Task(Lection lection, String questionText, String options, int correctAnswerIndex) {
        this.lection = lection;
        this.questionText = questionText;
        this.options = options;
        this.correctAnswerIndex = correctAnswerIndex;
    }

    public Long getTaskId() {
        return taskId;
    }

    public Lection getLection() {
        return lection;
    }

    public void setLection(Lection lection) {
        this.lection = lection;
    }

    public String getQuestionText() {
        return questionText;
    }

    public void setQuestionText(String questionText) {
        this.questionText = questionText;
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

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Task task = (Task) o;
        return Objects.equals(taskId, task.taskId);
    }

    @Override
    public int hashCode() {
        return Objects.hash(taskId);
    }

    // toString()
    @Override
    public String toString() {
        return "Task{" +
                "taskId=" + taskId +
                ", questionText='" + questionText + '\'' +
                ", options='" + options + '\'' +
                ", correctAnswerIndex=" + correctAnswerIndex +
                '}';
    }
}