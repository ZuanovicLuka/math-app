package math.backend.controller;

import math.backend.dto.UserRegistrationDto;
import math.backend.service.UserService;
import math.backend.config.JwtService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import jakarta.validation.Valid;
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
}