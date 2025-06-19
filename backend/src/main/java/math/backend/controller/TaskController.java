package math.backend.controller;

import math.backend.config.JwtService;
import math.backend.dto.TaskDTO;
import math.backend.dto.UserTaskDTO;
import math.backend.model.Lection;
import math.backend.model.Task;
import math.backend.model.User;
import math.backend.model.UserTask;
import math.backend.repository.TaskRepository;
import math.backend.repository.UserTaskRepository;
import math.backend.service.LectionService;
import math.backend.service.TaskService;
import math.backend.service.UserService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@RestController
@RequestMapping("/api/tasks")
public class TaskController {
    private final TaskService taskService;
    private final LectionService lectionService;
    private final UserService userService;
    private final JwtService jwtService;
    private final TaskRepository taskRepository;
    private final UserTaskRepository userTaskRepository;

    public TaskController(TaskService taskService, LectionService lectionService, UserService userService, JwtService jwtService, TaskRepository taskRepository, UserTaskRepository userTaskRepository) {
        this.taskService = taskService;
        this.lectionService = lectionService;
        this.userService = userService;
        this.jwtService = jwtService;
        this.taskRepository = taskRepository;
        this.userTaskRepository = userTaskRepository;
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

    @GetMapping("/by-lection/{lectionId}")
    public ResponseEntity<?> getTasksByLectionId( @RequestHeader("Authorization") String authHeader, @PathVariable Long lectionId) {
        try {
            User user = getUserFromToken(authHeader);

            List<TaskDTO> tasks = taskService.getTasksByLectionId(lectionId);
            Lection lection = lectionService.getLectionById(lectionId);

            return ResponseEntity.ok(Map.of(
                    "status", "uspjeh",
                    "lectionTitle", lection.getTitle(),
                    "tasks", tasks
            ));

        } catch (Exception e) {
            return ResponseEntity.status(401).body(Map.of(
                    "status", "error",
                    "message", e.getMessage()
            ));
        }
    }

    @PostMapping("/toggle-completion/{taskId}/{selectedOption}")
    public ResponseEntity<?> toggleTaskCompletion(
            @RequestHeader("Authorization") String authHeader,
            @PathVariable Long taskId,
            @PathVariable(required = false) Integer selectedOption) {
        try {
            User user = getUserFromToken(authHeader);
            Task task = taskRepository.findById(taskId)
                    .orElseThrow(() -> new RuntimeException("Zadatak nije pronađen"));

            Optional<UserTask> userTask = userTaskRepository.findByUserAndTask(user, task);

            if (userTask.isPresent()) {
                // Ako postoji, brišemo ga (odznačavanje)
                userTaskRepository.delete(userTask.get());
                return ResponseEntity.ok(Map.of(
                        "status", "uspjeh",
                        "message", "Zadatak uspješno odznačen"
                ));
            } else {
                // Ako ne postoji, kreiramo novi (označavanje)
                if (selectedOption == null) {
                    return ResponseEntity.badRequest().body(Map.of(
                            "status", "error",
                            "message", "Odabir odgovora je obavezan"
                    ));
                }

                UserTask newUserTask = new UserTask();
                newUserTask.setUser(user);
                newUserTask.setTask(task);
                newUserTask.setSelectedOption(selectedOption);
                newUserTask.setCompleted(true);
                userTaskRepository.save(newUserTask);

                return ResponseEntity.ok(Map.of(
                        "status", "uspjeh",
                        "message", "Zadatak uspješno označen kao naučen"
                ));
            }
        } catch (Exception e) {
            return ResponseEntity.status(400).body(Map.of(
                    "status", "error",
                    "message", e.getMessage()
            ));
        }
    }

    @GetMapping("/user-task-status/{taskId}")
    public ResponseEntity<?> getUserTaskStatus(
            @RequestHeader("Authorization") String authHeader,
            @PathVariable Long taskId) {
        try {
            User user = getUserFromToken(authHeader);
            Task task = taskRepository.findById(taskId)
                    .orElseThrow(() -> new RuntimeException("Zadatak nije pronađen"));

            Optional<UserTask> userTask = userTaskRepository.findByUserAndTask(user, task);

            Map<String, Object> response = new HashMap<>();
            response.put("status", "uspjeh");
            response.put("isCompleted", userTask.isPresent());

            // Ako postoji UserTask, vrati selectedOption, inače null
            Integer selectedOption = userTask.map(UserTask::getSelectedOption).orElse(null);
            response.put("selectedOption", selectedOption);

            return ResponseEntity.ok(response);
        } catch (Exception e) {
            return ResponseEntity.status(400).body(Map.of(
                    "status", "error",
                    "message", e.getMessage()
            ));
        }
    }

    @GetMapping("/completed-tasks/{lectionId}")
    public ResponseEntity<?> getCompletedTasksForLection(
            @RequestHeader("Authorization") String authHeader,
            @PathVariable Long lectionId) {
        try {
            User user = getUserFromToken(authHeader);

            List<UserTask> completedTasks = userTaskRepository.findByUserAndTask_Lection_LectionId(user, lectionId);

            List<Long> completedTaskIds = completedTasks.stream()
                    .map(userTask -> userTask.getTask().getTaskId())
                    .toList();

            return ResponseEntity.ok(Map.of(
                    "status", "uspjeh",
                    "completedTaskIds", completedTaskIds
            ));
        } catch (Exception e) {
            return ResponseEntity.status(400).body(Map.of(
                    "status", "error",
                    "message", e.getMessage()
            ));
        }
    }

    @GetMapping("/completed-tasks-count")
    public ResponseEntity<?> getCompletedTasksCountForLections(
            @RequestHeader("Authorization") String authHeader,
            @RequestParam List<Long> lectionIds) {
        try {
            User user = getUserFromToken(authHeader);

            Map<Long, Integer> counts = new HashMap<>();

            List<UserTask> completedTasks = userTaskRepository.findByUserAndIsCompletedTrue(user);

            for (Long lectionId : lectionIds) {
                long count = completedTasks.stream()
                        .filter(ut -> ut.getTask().getLection().getLectionId().equals(lectionId))
                        .count();
                counts.put(lectionId, (int) count);
            }

            return ResponseEntity.ok(Map.of(
                    "status", "uspjeh",
                    "counts", counts
            ));
        } catch (Exception e) {
            return ResponseEntity.status(400).body(Map.of(
                    "status", "error",
                    "message", e.getMessage()
            ));
        }
    }

    @PostMapping
    public ResponseEntity<Task> createTask(@RequestBody TaskDTO taskDTO) {
        Lection lection = lectionService.getLectionById(taskDTO.getLectionId());

        Task task = new Task();
        task.setQuestionText(taskDTO.getQuestionText());
        task.setOptions(String.join(",", taskDTO.getOptions()));
        task.setCorrectAnswerIndex(taskDTO.getCorrectAnswerIndex());
        task.setLection(lection);

        Task createdTask = taskService.createTask(task);
        return ResponseEntity.ok(createdTask);
    }
}