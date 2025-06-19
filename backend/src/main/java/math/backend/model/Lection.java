package math.backend.model;

import jakarta.persistence.*;
import java.util.List;
import java.util.Objects;

@Entity
@Table(name = "lection")
public class Lection {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "lection_id")
    private Long lectionId;

    @Column(nullable = false)
    private String title;

    @Column(name = "school_level", nullable = false)
    private String schoolLevel;

    @Column(nullable = false)
    private String grade;

    @OneToMany(mappedBy = "lection", cascade = CascadeType.ALL)
    private List<Task> tasks;

    public Lection() {
    }

    public Lection(String title, String schoolLevel, String grade, List<Task> tasks) {
        this.title = title;
        this.schoolLevel = schoolLevel;
        this.grade = grade;
        this.tasks = tasks;

        if(tasks != null){
            tasks.forEach(t -> t.setLection(this));
        }
    }

    public Long getLectionId() {
        return lectionId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
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

    public List<Task> getTasks() {
        return tasks;
    }

    public void setTasks(List<Task> tasks) {
        this.tasks = tasks;
        if(tasks != null){
            tasks.forEach(t -> t.setLection(this));
        }
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Lection lection = (Lection) o;
        return Objects.equals(lectionId, lection.lectionId);
    }

    @Override
    public int hashCode() {
        return Objects.hash(lectionId);
    }

    @Override
    public String toString() {
        return "Lection{" +
                "lectionId=" + lectionId +
                ", title='" + title + '\'' +
                ", schoolLevel='" + schoolLevel + '\'' +
                ", grade='" + grade + '\'' +
                '}';
    }
}