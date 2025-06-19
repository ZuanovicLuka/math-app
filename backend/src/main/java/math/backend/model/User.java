package math.backend.model;

import jakarta.persistence.*;

import java.util.ArrayList;
import java.util.Objects;
import java.util.List;

@Entity
@Table(name = "\"user\"")
public class User {
    // sa Id oznacavamo da je to pk, IDENTITY = autoincrement po pk
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "user_id")
    private Long userId;

    // ako je nullable = false onda je to obavezno polje (ne smije biti NULL)
    @Column(name = "firstName", nullable = false)
    private String firstName;

    @Column(name = "lastName", nullable = false)
    private String lastName;

    @Column(name = "schoolLevel", nullable = false)
    private String schoolLevel;

    @Column(name = "grade", nullable = false)
    private String grade;

    // unique jer ne smiju postojati 2 ista username-a, email-a
    @Column(nullable = false, unique = true)
    private String username;

    @Column(nullable = false, unique = true)
    private String email;

    @Column(name = "password_hash", nullable = false)
    private String passwordHash;

    @Column(name = "profile_picture") // moze biti NULL
    private String profilePicture;

    // dodao sam vezu na userTasks gdje cu pratiti koje zadatke je neki user rijesio
    @OneToMany(mappedBy = "user", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<UserTask> userTasks = new ArrayList<>();

    // defaultni konstruktor (required by JPA)
    public User() {
    }

    // konstruktor sa svim poljima
    public User(String firstName, String lastName, String schoolLevel, String grade,
                String username, String email, String passwordHash, String profilePicture) {
        this.firstName = firstName;
        this.lastName = lastName;
        this.schoolLevel = schoolLevel;
        this.grade = grade;
        this.username = username;
        this.email = email;
        this.passwordHash = passwordHash;
        this.profilePicture = profilePicture;
    }

    // getters i setters
    public Long getUserId() {
        return userId;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
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

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return passwordHash;
    }

    public void setPassword(String passwordHash) {
        this.passwordHash = passwordHash;
    }

    public String getProfilePicture() {
        return profilePicture;
    }

    public void setProfilePicture(String profilePicture) {
        this.profilePicture = profilePicture;
    }

    public List<UserTask> getUserTasks() {
        return userTasks;
    }

    public void setUserTasks(List<UserTask> userTasks) {
        this.userTasks = userTasks;
    }

    public void addUserTask(UserTask userTask) {
        userTasks.add(userTask);
        userTask.setUser(this);
    }

    public void removeUserTask(UserTask userTask) {
        userTasks.remove(userTask);
        userTask.setUser(null);
    }

    // equals() and hashCode()
    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        User user = (User) o;
        return Objects.equals(userId, user.userId);
    }

    @Override
    public int hashCode() { return Objects.hash(userId); }
}