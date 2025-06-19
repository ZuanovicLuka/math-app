package math.backend.repository;

import math.backend.model.Task;
import math.backend.model.User;
import math.backend.model.UserTask;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;
import java.util.Optional;

public interface UserTaskRepository extends JpaRepository<UserTask, Long> {
    Optional<UserTask> findByUserAndTask(User user, Task task);
    List<UserTask> findByUserAndTask_Lection_LectionIdAndIsCompleted(User user, Long lectionId, boolean isCompleted);
    List<UserTask> findByUserAndTask_Lection_LectionId(User user, Long lectionId);
    List<UserTask> findByUserAndIsCompletedTrue(User user);
}