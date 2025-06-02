package math.backend.dto;

import java.time.LocalDateTime;

public class UserRankingDTO {
    private int position;
    private Long userId;
    private String username;
    private String firstName;
    private String lastName;
    private String profilePicture;
    private int score;
    private int timeTakenSeconds;
    private LocalDateTime endTime;

    // Konstruktori
    public UserRankingDTO() {}

    public UserRankingDTO(int position, Long userId, String username, String firstName, String lastName, String profilePicture, int score,
                          int timeTakenSeconds, LocalDateTime endTime) {
        this.position = position;
        this.userId = userId;
        this.username = username;
        this.firstName = firstName;
        this.lastName = lastName;
        this.profilePicture = profilePicture;
        this.score = score;
        this.timeTakenSeconds = timeTakenSeconds;
        this.endTime = endTime;
    }

    // Getteri i setteri
    public int getPosition() {
        return position;
    }

    public void setPosition(int position) {
        this.position = position;
    }

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
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

    public String getProfilePicture() {
        return profilePicture;
    }

    public void setProfilePicture(String profilePicture) {
        this.profilePicture = profilePicture;
    }

    public int getScore() {
        return score;
    }

    public void setScore(int score) {
        this.score = score;
    }

    public int getTimeTakenSeconds() {
        return timeTakenSeconds;
    }

    public void setTimeTakenSeconds(int timeTakenSeconds) {
        this.timeTakenSeconds = timeTakenSeconds;
    }

    public LocalDateTime getEndTime() {
        return endTime;
    }

    public void setEndTime(LocalDateTime endTime) {
        this.endTime = endTime;
    }
}