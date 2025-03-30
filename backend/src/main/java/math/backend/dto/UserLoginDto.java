package math.backend.dto;

import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;

public class UserLoginDto {
    @NotNull(message = "Username is required")
    @Size(min = 4, message = "Username must be at least 4 characters")
    private String username;

    @NotNull(message = "Password is required")
    @Size(min = 6, message = "Password should be at least 6 characters")
    private String password;

    // Getters and setters
    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }
}