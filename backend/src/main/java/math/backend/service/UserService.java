package math.backend.service;

import math.backend.dto.UserProfileDto;
import math.backend.dto.UserRegistrationDto;
import math.backend.model.User;
import math.backend.repository.UserRepository;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import java.util.HashMap;
import java.util.Map;

@Service
public class UserService {
    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;

    public UserService(UserRepository userRepository, PasswordEncoder passwordEncoder) {
        this.userRepository = userRepository;
        this.passwordEncoder = passwordEncoder;
    }

    public Long registerUser(UserRegistrationDto registrationDto) {
        Map<String, String> errors = new HashMap<>();

        if (userRepository.existsByUsername(registrationDto.getUsername())) {
            errors.put("usernameError", "Korisničko ime je zauzeto!");
        }

        if (userRepository.existsByEmail(registrationDto.getEmail())) {
            errors.put("emailError", "Email je zauzet!");
        }

        if (!errors.isEmpty()) {
            throw new RegistrationException(errors);
        }

        // ako nema problema onda se kreira novi user, jedino se password hash-ira prije stavljanja u bazu
        User user = new User();
        user.setFirstName(registrationDto.getFirstName());
        user.setLastName(registrationDto.getLastName());
        user.setSchoolLevel(registrationDto.getSchoolLevel());
        user.setUsername(registrationDto.getUsername());
        user.setEmail(registrationDto.getEmail());
        user.setPassword(passwordEncoder.encode(registrationDto.getPassword()));

        // pospremamo user-a u bazu
        User savedUser = userRepository.save(user);

        // vracamo id user-a po kojem ce se raditi jwt token
        return savedUser.getUserId();
    }

    // exception za registraciju
    public static class RegistrationException extends RuntimeException {
        private final Map<String, String> errors;

        public RegistrationException(Map<String, String> errors) {
            super("Registration failed");
            this.errors = errors;
        }

        public Map<String, String> getErrors() {
            return errors;
        }
    }

    public Long authenticateUser(String username, String password) {
        // prvo dohvatimo user-a iz baze po tom username-u
        User user = userRepository.findByUsername(username)
                .orElseThrow(() -> new AuthenticationException("Invalid credentials"));

        // i onda provjerimo je li password koji je poslan isti kao u bazi
        if (!passwordEncoder.matches(password, user.getPassword())) {
            throw new AuthenticationException("Invalid credentials");
        }

        // ako je username postojeci i poslan je dobar password za njega vracamo njegov id (pk)
        return user.getUserId();
    }

    public static class AuthenticationException extends RuntimeException {
        public AuthenticationException(String message) {
            super(message);
        }
    }

    public UserProfileDto getUserProfile(Long userId) {
        // iz baze dohvatimo User-a po id-u, ako ga nema baca error
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new RuntimeException("Korisnik nije pronađen!"));

        UserProfileDto profileDto = new UserProfileDto();
        profileDto.setUserId(user.getUserId());
        profileDto.setFirstName(user.getFirstName());
        profileDto.setLastName(user.getLastName());
        profileDto.setSchoolLevel(user.getSchoolLevel());
        profileDto.setUsername(user.getUsername());
        profileDto.setEmail(user.getEmail());

        return profileDto;
    }
}