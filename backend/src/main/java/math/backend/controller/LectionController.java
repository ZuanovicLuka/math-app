package math.backend.controller;

import math.backend.config.JwtService;
import math.backend.dto.LectionDTO;
import math.backend.model.Lection;
import math.backend.model.User;
import math.backend.service.LectionService;
import math.backend.service.UserService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/lections")
public class LectionController {
    private final LectionService lectionService;
    private final UserService userService;
    private final JwtService jwtService;

    public LectionController(LectionService lectionService, UserService userService, JwtService jwtService) {
        this.lectionService = lectionService;
        this.userService = userService;
        this.jwtService = jwtService;
    }

    private User getUserFromToken(String authHeader) {
        if (authHeader == null || !authHeader.startsWith("Bearer ")) {
            throw new RuntimeException("Neispravan autorizacijski header");
        }

        String token = authHeader.substring(7);
        String userId = jwtService.extractUserId(token);
        return userService.findById(Long.parseLong(userId))
                .orElseThrow(() -> new RuntimeException("Korisnik nije pronađen za ID: " + userId));
    }

    @GetMapping
    public ResponseEntity<?> getLectionsByLevelAndGrade(
            @RequestHeader("Authorization") String authHeader,
            @RequestParam String schoolLevel,
            @RequestParam String grade) {
        try {
            User user = getUserFromToken(authHeader);

            List<LectionDTO> lections = lectionService.getLectionsBySchoolLevelAndGrade(schoolLevel, grade);

            return ResponseEntity.ok(Map.of(
                    "status", "uspjeh",
                    "lections", lections
            ));

        } catch (Exception e) {
            return ResponseEntity.status(401).body(Map.of(
                    "status", "error",
                    "message", e.getMessage()
            ));
        }
    }

    @PostMapping
    public ResponseEntity<Lection> createLection(@RequestBody LectionDTO lectionDTO) {
        Lection lection = new Lection();
        lection.setTitle(lectionDTO.getTitle());
        lection.setSchoolLevel(lectionDTO.getSchoolLevel());
        lection.setGrade(lectionDTO.getGrade());

        Lection createdLection = lectionService.createLection(lection);
        return ResponseEntity.ok(createdLection);
    }
}