package math.backend.service;

import math.backend.dto.LectionDTO;
import math.backend.model.Lection;
import math.backend.repository.LectionRepository;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class LectionService {
    private final LectionRepository lectionRepository;

    public LectionService(LectionRepository lectionRepository) {
        this.lectionRepository = lectionRepository;
    }

    public Lection createLection(Lection lection) {
        return lectionRepository.save(lection);
    }

    public Lection getLectionById(Long lectionId) {
        return lectionRepository.findById(lectionId)
                .orElseThrow(() -> new RuntimeException("Lection not found with id: " + lectionId));
    }

    public List<LectionDTO> getLectionsBySchoolLevelAndGrade(String schoolLevel, String grade) {
        List<Lection> lections = lectionRepository.findBySchoolLevelAndGrade(schoolLevel, grade);
        return convertToDTO(lections);
    }

    private List<LectionDTO> convertToDTO(List<Lection> lections) {
        return lections.stream()
                .map(this::mapToDTO)
                .collect(Collectors.toList());
    }

    private LectionDTO mapToDTO(Lection lection) {
        LectionDTO dto = new LectionDTO();
        dto.setLectionId(lection.getLectionId());
        dto.setTitle(lection.getTitle());
        dto.setSchoolLevel(lection.getSchoolLevel());
        dto.setGrade(lection.getGrade());
        return dto;
    }
}