package math.backend.dto;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;

public class UserUpdateDto {
    @NotBlank(message = "Ime je obavezno")
    private String firstName;

    @NotBlank(message = "Prezime je obavezno")
    private String lastName;

    @NotBlank(message = "Korisničko ime je obavezno")
    private String username;

    @NotBlank(message = "Email je obavezan")
    @Email(message = "Email mora biti validan")
    private String email;

    public @NotBlank(message = "Ime je obavezno") String getFirstName() {
        return firstName;
    }

    public void setFirstName(@NotBlank(message = "Ime je obavezno") String firstName) {
        this.firstName = firstName;
    }

    public @NotBlank(message = "Prezime je obavezno") String getLastName() {
        return lastName;
    }

    public void setLastName(@NotBlank(message = "Prezime je obavezno") String lastName) {
        this.lastName = lastName;
    }

    public @NotBlank(message = "Korisničko ime je obavezno") String getUsername() {
        return username;
    }

    public void setUsername(@NotBlank(message = "Korisničko ime je obavezno") String username) {
        this.username = username;
    }

    public @NotBlank(message = "Email je obavezan") @Email(message = "Email mora biti validan") String getEmail() {
        return email;
    }

    public void setEmail(@NotBlank(message = "Email je obavezan") @Email(message = "Email mora biti validan") String email) {
        this.email = email;
    }
}