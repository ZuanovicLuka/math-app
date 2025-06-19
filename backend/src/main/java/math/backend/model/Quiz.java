package math.backend.model;

import jakarta.persistence.*;
import java.time.LocalDate;
import java.util.List;

@Entity
@Table(name = "quiz")
public class Quiz {
    // pk tablice, autoincrement
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "quiz_id")
    private Long quizId;

    @Column(name = "quiz_date", nullable = false)
    private LocalDate quizDate;

    @Column(name = "school_level", nullable = false)
    private String schoolLevel;

    @Column(name = "grade", nullable = false)
    private String grade;

    // cascade ovdje radi ako obrisemo questions brise se sve iz tablice QuizQuestion vezano za taj kviz
    @OneToMany(mappedBy = "quiz", cascade = CascadeType.ALL)
    private List<QuizQuestion> questions;

    // Defaultni konstruktor (obavezan za JPA)
    public Quiz() {
    }

    // Konstruktor sa svim poljima osim ID-ja (generira se automatski)
    public Quiz(LocalDate quizDate, String schoolLevel, String grade, List<QuizQuestion> questions) {
        this.quizDate = quizDate;
        this.schoolLevel = schoolLevel;
        this.grade = grade;
        this.questions = questions;

        // Postavi dvosmjernu vezu ako postoje pitanja
        if (questions != null) {
            questions.forEach(q -> q.setQuiz(this));
        }
    }

    // Konstruktor bez pitanja (može se dodati kasnije)
    public Quiz(LocalDate quizDate, String schoolLevel, String grade) {
        this(quizDate, schoolLevel, grade, null);
    }

    // Getteri i setteri ostaju isti kao što si ih već napisao/la
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

    public String getGrade() {
        return grade;
    }

    public void setGrade(String grade) {
        this.grade = grade;
    }

    public List<QuizQuestion> getQuestions() {
        return questions;
    }

    public void setQuestions(List<QuizQuestion> questions) {
        this.questions = questions;

        // Osiguraj dvosmjernu vezu
        if (questions != null) {
            questions.forEach(q -> q.setQuiz(this));
        }
    }
}