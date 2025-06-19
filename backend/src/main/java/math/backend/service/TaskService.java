package math.backend.service;

import math.backend.dto.TaskDTO;
import math.backend.dto.UserTaskDTO;
import math.backend.model.Task;
import math.backend.model.User;
import math.backend.model.UserTask;
import math.backend.repository.TaskRepository;
import math.backend.repository.UserTaskRepository;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
public class TaskService {
    private final TaskRepository taskRepository;
    private final UserTaskRepository userTaskRepository;

    public TaskService(TaskRepository taskRepository, UserTaskRepository userTaskRepository) {
        this.taskRepository = taskRepository;
        this.userTaskRepository = userTaskRepository;
    }

    public Task createTask(Task task) {
        return taskRepository.save(task);
    }

    public List<TaskDTO> getTasksByLectionId(Long lectionId){
        List<Task> tasks = taskRepository.findByLection_LectionId(lectionId);
        return convertTasksToDTO(tasks);
    }

    private List<TaskDTO> convertTasksToDTO(List<Task> tasks) {
        return tasks.stream()
                .map(this::mapTaskToDTO)
                .collect(Collectors.toList());
    }

    private TaskDTO mapTaskToDTO(Task task) {
        TaskDTO taskDTO = new TaskDTO();
        taskDTO.setTaskId(task.getTaskId());
        taskDTO.setQuestionText(task.getQuestionText());
        taskDTO.setOptions(task.getOptions());
        taskDTO.setCorrectAnswerIndex(task.getCorrectAnswerIndex());
        return taskDTO;
    }

    public void markTaskAsCompleted(User user, Long taskId, boolean completed) {
        Task task = taskRepository.findById(taskId)
                .orElseThrow(() -> new RuntimeException("Zadatak nije pronađen"));

        Optional<UserTask> userTaskOpt = userTaskRepository.findByUserAndTask(user, task);

        if (userTaskOpt.isPresent()) {
            UserTask userTask = userTaskOpt.get();
            userTask.setCompleted(completed);
            userTaskRepository.save(userTask);
        } else {
            UserTask userTask = new UserTask(user, task, completed);
            userTaskRepository.save(userTask);
        }
    }

    public List<Long> getCompletedTaskIds(User user, Long lectionId) {
        return userTaskRepository.findByUserAndTask_Lection_LectionIdAndIsCompleted(user, lectionId, true)
                .stream()
                .map(ut -> ut.getTask().getTaskId())
                .collect(Collectors.toList());
    }

    public void saveUserAnswer(User user, Long taskId, int selectedOption) {
        Task task = taskRepository.findById(taskId)
                .orElseThrow(() -> new RuntimeException("Zadatak nije pronađen"));

        Optional<UserTask> userTaskOpt = userTaskRepository.findByUserAndTask(user, task);

        UserTask userTask = userTaskOpt.orElseGet(() -> new UserTask(user, task, false));
        userTask.setSelectedOption(selectedOption);
        userTaskRepository.save(userTask);
    }

    public Map<Long, Integer> getUserAnswers(User user, Long lectionId) {
        return userTaskRepository.findByUserAndTask_Lection_LectionId(user, lectionId)
                .stream()
                .collect(Collectors.toMap(
                        ut -> ut.getTask().getTaskId(),
                        ut -> ut.getSelectedOption()
                ));
    }

    public List<UserTaskDTO> getUserTasks(User user, Long lectionId) {
        return userTaskRepository.findByUserAndTask_Lection_LectionId(user, lectionId)
                .stream()
                .map(ut -> {
                    UserTaskDTO dto = new UserTaskDTO();
                    dto.setTaskId(ut.getTask().getTaskId());
                    dto.setSelectedOption(ut.getSelectedOption());
                    dto.setCompleted(ut.isCompleted());
                    return dto;
                })
                .collect(Collectors.toList());
    }
}