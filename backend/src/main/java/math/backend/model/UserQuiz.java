package math.backend.model;

import jakarta.persistence.*;
import java.time.LocalDateTime;
import java.util.List;

@Entity
@Table(name = "user_quiz")
public class UserQuiz {
    // pk, autoincrement
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "user_quiz_id")
    private Long userQuizId;

    // više UserQuizova može ići na 1 User
    @ManyToOne
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    // više UserQuizova može ići na 1 quiz
    @ManyToOne
    @JoinColumn(name = "quiz_id", nullable = false)
    private Quiz quiz;

    @Column(name = "start_time")
    private LocalDateTime startTime;

    @Column(name = "end_time")
    private LocalDateTime endTime;

    @Column(name = "score")
    private Integer score;

    @Column(name = "time_taken_seconds")
    private Integer timeTakenSeconds;

    // string koji u sebi sadrzi 20 odgovora koji su predstavljeni indeksom, medusobno su odvojeni zarezom
    @Column(name = "user_answers")
    private String answers;

    // Default constructor (required by JPA)
    public UserQuiz() {
    }

    // Constructor for starting a new quiz
    public UserQuiz(User user, Quiz quiz, LocalDateTime startTime) {
        this.user = user;
        this.quiz = quiz;
        this.startTime = startTime;
    }

    // Full constructor
    public UserQuiz(User user, Quiz quiz, LocalDateTime startTime, LocalDateTime endTime,
                    Integer score, Integer timeTakenSeconds, String answers) {
        this.user = user;
        this.quiz = quiz;
        this.startTime = startTime;
        this.endTime = endTime;
        this.score = score;
        this.timeTakenSeconds = timeTakenSeconds;
        this.answers = answers;
    }

    public Long getUserQuizId() {
        return userQuizId;
    }

    public void setUserQuizId(Long userQuizId) {
        this.userQuizId = userQuizId;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Quiz getQuiz() {
        return quiz;
    }

    public void setQuiz(Quiz quiz) {
        this.quiz = quiz;
    }

    public LocalDateTime getStartTime() {
        return startTime;
    }

    public void setStartTime(LocalDateTime startTime) {
        this.startTime = startTime;
    }

    public LocalDateTime getEndTime() {
        return endTime;
    }

    public void setEndTime(LocalDateTime endTime) {
        this.endTime = endTime;
    }

    public Integer getScore() {
        return score;
    }

    public void setScore(Integer score) {
        this.score = score;
    }

    public Integer getTimeTakenSeconds() {
        return timeTakenSeconds;
    }

    public void setTimeTakenSeconds(Integer timeTakenSeconds) {
        this.timeTakenSeconds = timeTakenSeconds;
    }

    public String getAnswers() {
        return answers;
    }

    public void setAnswers(String answers) {
        this.answers = answers;
    }

    // funkcija za računanje koliko je netko dugo rješavao kviz
    public Integer calculateTimeTaken() {
        if (startTime != null && endTime != null) {
            return (int) java.time.Duration.between(startTime, endTime).getSeconds();
        }
        return null;
    }

    @Override
    public String toString() {
        return "UserQuiz{" +
                "userQuizId=" + userQuizId +
                ", user=" + (user != null ? user.getUserId() : "null") +
                ", quiz=" + (quiz != null ? quiz.getQuizId() : "null") +
                ", startTime=" + startTime +
                ", endTime=" + endTime +
                ", score=" + score +
                ", timeTakenSeconds=" + timeTakenSeconds +
                ", answers=" + answers +
                '}';
    }
}