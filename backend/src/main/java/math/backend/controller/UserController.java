package math.backend.controller;

import math.backend.dto.UserLoginDto;
import math.backend.dto.UserProfileDto;
import math.backend.dto.UserRegistrationDto;
import math.backend.dto.UserUpdateDto;
import math.backend.service.UserService;
import math.backend.config.JwtService;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import jakarta.validation.Valid;
import org.springframework.web.multipart.MultipartFile;

import java.util.Map;

@RestController
@RequestMapping("/api/users")
public class UserController {
    private final UserService userService;
    private final JwtService jwtService;

    public UserController(UserService userService, JwtService jwtService) {
        this.userService = userService;
        this.jwtService = jwtService;
    }

    @PostMapping("/register")
    public ResponseEntity<?> registerUser(@RequestBody @Valid UserRegistrationDto registrationDto) {
        try {
            // registriramo korisnika i vrati nam se njegov primary key (id)
            Long userId = userService.registerUser(registrationDto);

            // nakon toga generiramo jwt token sa tim id-em
            String token = jwtService.generateToken(userId.toString());

            return ResponseEntity.ok(Map.of(
                    "status", "success",
                    "message", "User registered successfully",
                    "token", token
            ));
        } catch (UserService.RegistrationException e) {
            return ResponseEntity.badRequest().body(Map.of(
                    "status", "error",
                    "message", "Registration failed",
                    "errors", e.getErrors()
            ));
        } catch (RuntimeException e) {
            return ResponseEntity.badRequest().body(Map.of(
                    "status", "error",
                    "message", e.getMessage()
            ));
        }
    }

    @PostMapping("/login")
    public ResponseEntity<?> loginUser(@RequestBody @Valid UserLoginDto loginDto) {
        try {
            // Authenticate user and get their ID
            Long userId = userService.authenticateUser(loginDto.getUsername(), loginDto.getPassword());

            // nakon toga generiramo jwt token sa tim id-em
            String token = jwtService.generateToken(userId.toString());

            return ResponseEntity.ok(Map.of(
                    "status", "success",
                    "message", "Login successful",
                    "token", token
            ));
        } catch (UserService.AuthenticationException e) {
            return ResponseEntity.badRequest().body(Map.of(
                    "status", "error",
                    "error", "Korisničko ime ili lozinka nisu ispravni!"
            ));
        } catch (RuntimeException e) {
            return ResponseEntity.badRequest().body(Map.of(
                    "status", "error",
                    "message", e.getMessage()
            ));
        }
    }

    @PostMapping(value = "/update-profile-picture", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    public ResponseEntity<?> updateProfilePicture(@RequestHeader("Authorization") String authHeader, @RequestPart(value = "file", required = false) MultipartFile file) {
        try {
            // Provjera tokena
            if (authHeader == null || !authHeader.startsWith("Bearer ")) {
                return ResponseEntity.status(401).body(Map.of(
                        "status", "error",
                        "message", "Nedostaje autorizacijski token!"
                ));
            }

            String token = authHeader.substring(7);
            String userId = jwtService.extractUserId(token);

            userService.updateProfilePicture(Long.parseLong(userId), file);

            return ResponseEntity.ok(Map.of(
                    "status", "success",
                    "message", "Profilna slika uspješno ažurirana!"
            ));

        } catch (Exception e) {
            return ResponseEntity.status(401).body(Map.of(
                    "status", "error",
                    "message", e.getMessage()
            ));
        }
    }

    @PatchMapping("/update-profile")
    public ResponseEntity<?> updateUserProfile(
            @RequestHeader("Authorization") String authHeader,
            @RequestBody @Valid UserUpdateDto updateDto) {
        try {
            // Provjera tokena
            if (authHeader == null || !authHeader.startsWith("Bearer ")) {
                return ResponseEntity.status(401).body(Map.of(
                        "status", "error",
                        "message", "Nedostaje autorizacijski token!"
                ));
            }

            String token = authHeader.substring(7);
            String userId = jwtService.extractUserId(token);

            // Ažuriranje podataka
            UserProfileDto updatedUser = userService.updateUserProfile(Long.parseLong(userId), updateDto);

            return ResponseEntity.ok(Map.of(
                    "status", "success",
                    "message", "Profil uspješno ažuriran",
                    "user", updatedUser
            ));

        } catch (UserService.UpdateException e) {
            return ResponseEntity.badRequest().body(Map.of(
                    "status", "error",
                    "message", "Ažuriranje profila nije uspjelo",
                    "errors", e.getErrors()
            ));
        } catch (Exception e) {
            return ResponseEntity.status(401).body(Map.of(
                    "status", "error",
                    "message", e.getMessage()
            ));
        }
    }

    @GetMapping("/info")
    public ResponseEntity<?> getUserProfile(@RequestHeader("Authorization") String authHeader) {
        try {
            // provjera tokena
            if (authHeader == null || !authHeader.startsWith("Bearer ")) {
                return ResponseEntity.status(401).body(Map.of(
                        "status", "error",
                        "message", "Nedostaje autorizacijski token!"
                ));
            }

            // ako token postoji izvadimo ga
            String token = authHeader.substring(7);

            // uzimamo id iz tokena
            String userId = jwtService.extractUserId(token);

            // i onda prema tom Id-u (pk) dohvatimo sve podatke o user-u
            UserProfileDto userProfile = userService.getUserProfile(Long.parseLong(userId));

            return ResponseEntity.ok(Map.of(
                    "status", "success",
                    "user", userProfile
            ));
        } catch (Exception e) {
            return ResponseEntity.status(401).body(Map.of(
                    "status", "error",
                    "message", "Nevažeći token ili korisnik nije pronađen!"
            ));
        }
    }
}