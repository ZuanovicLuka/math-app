package math.backend.service;

import math.backend.db.SupabaseS3Service;
import math.backend.dto.UserProfileDto;
import math.backend.dto.UserRegistrationDto;
import math.backend.dto.UserUpdateDto;
import math.backend.mapper.UserMapper;
import math.backend.model.User;
import math.backend.repository.UserRepository;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import java.io.File;
import java.io.FileOutputStream;
import java.util.*;

@Service
public class UserService {
    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;
    private final SupabaseS3Service supabaseS3Service;

    public UserService(UserRepository userRepository, PasswordEncoder passwordEncoder, SupabaseS3Service supabaseS3Service) {
        this.userRepository = userRepository;
        this.passwordEncoder = passwordEncoder;
        this.supabaseS3Service = supabaseS3Service;
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
        user.setGrade(registrationDto.getGrade());
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
        profileDto.setGrade(user.getGrade());
        profileDto.setUsername(user.getUsername());
        profileDto.setEmail(user.getEmail());
        profileDto.setProfilePicture(user.getProfilePicture());

        return profileDto;
    }

    public void updateProfilePicture(Long userId, MultipartFile file) {
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new RuntimeException("Korisnik nije pronađen!"));

        if (file == null || file.isEmpty()) {
            throw new RuntimeException("Nije predan file ili je prazan!");
        }

        try {
            // Generate unique filename
            String originalFilename = file.getOriginalFilename();
            String uniqueFilename = UUID.randomUUID().toString()
                    + (originalFilename != null ? "-" + originalFilename : "");

            // Save the file to a temporary location
            File tempFile = File.createTempFile("profilepic-", "-" + uniqueFilename);
            try (FileOutputStream fos = new FileOutputStream(tempFile)) {
                fos.write(file.getBytes());
            }

            // Upload the file to Supabase bucket
            String bucketName = "profilne";
            supabaseS3Service.uploadFile(bucketName, uniqueFilename, tempFile.getAbsolutePath());

            // Construct the public URL
            String newProfilePicUrl = "https://iqszvfglmcrhvenpdgxt.supabase.co/storage/v1/object/public/"
                    + bucketName + "/" + uniqueFilename;

            // Clean up temp file
            tempFile.delete();

            // Save the URL to the user record
            user.setProfilePicture(newProfilePicUrl);
            userRepository.save(user);
        } catch (Exception e) {
            throw new RuntimeException("Failed to upload new profile picture.", e);
        }
    }

    public UserProfileDto updateUserProfile(Long userId, UserUpdateDto updateDto) {
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new RuntimeException("Korisnik nije pronađen!!!"));

        // Validacija jedinstvenosti username-a i email-a
        Map<String, String> errors = new HashMap<>();

        // Provjera username-a samo ako se promijenio
        if (!user.getUsername().equals(updateDto.getUsername())) {
            Optional<User> existingUserByUsername = userRepository.findByUsername(updateDto.getUsername());
            if (existingUserByUsername.isPresent()) {
                errors.put("usernameError", "Korisničko ime je zauzeto!");
            }
        }

        // Provjera email-a samo ako se promijenio
        if (!user.getEmail().equals(updateDto.getEmail())) {
            Optional<User> existingUserByEmail = userRepository.findByEmail(updateDto.getEmail());
            if (existingUserByEmail.isPresent()) {
                errors.put("emailError", "Email je zauzet!");
            }
        }

        if (!errors.isEmpty()) {
            throw new UpdateException(errors);
        }

        // Ažuriranje podataka, ako nema error-a
        user.setFirstName(updateDto.getFirstName());
        user.setLastName(updateDto.getLastName());
        user.setUsername(updateDto.getUsername());
        user.setEmail(updateDto.getEmail());

        User updatedUser = userRepository.save(user);
        UserProfileDto dto = UserMapper.toDto(updatedUser);

        return dto;
    }

    public static class UpdateException extends RuntimeException {
        private final Map<String, String> errors;

        public UpdateException(Map<String, String> errors) {
            super("Update failed");
            this.errors = errors;
        }

        public Map<String, String> getErrors() {
            return errors;
        }
    }

    public Optional<User> findById(Long userId) {
        return userRepository.findById(userId);
    }
}