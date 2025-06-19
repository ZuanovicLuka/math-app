package math.backend.repository;

import math.backend.model.Lection;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface LectionRepository extends JpaRepository<Lection, Long> {
    List<Lection> findBySchoolLevelAndGrade(String schoolLevel, String grade);
}