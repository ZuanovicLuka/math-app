package math.backend.model;

import jakarta.persistence.*;

@Entity
@Table(name = "user_task")
public class UserTask {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "user_task_id")
    private Long userTaskId;

    @ManyToOne
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    @ManyToOne
    @JoinColumn(name = "task_id", nullable = false)
    private Task task;

    @Column(name = "is_completed", nullable = false)
    private boolean isCompleted;

    @Column(name = "selected_option")
    private int selectedOption;

    public UserTask() {
    }

    public UserTask(User user, Task task, boolean isCompleted) {
        this.user = user;
        this.task = task;
        this.isCompleted = isCompleted;
    }

    // Getters and setters
    public Long getUserTaskId() {
        return userTaskId;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Task getTask() {
        return task;
    }

    public void setTask(Task task) {
        this.task = task;
    }

    public boolean isCompleted() {
        return isCompleted;
    }

    public void setCompleted(boolean completed) {
        isCompleted = completed;
    }

    public int getSelectedOption() {
        return selectedOption;
    }

    public void setSelectedOption(int selectedOption) {
        this.selectedOption = selectedOption;
    }
}