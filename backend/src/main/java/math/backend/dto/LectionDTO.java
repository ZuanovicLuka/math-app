package math.backend.dto;

import java.util.List;

public class LectionDTO {
    private Long lectionId;
    private String title;
    private String schoolLevel;
    private String grade;
    private List<TaskDTO> tasks;

    public LectionDTO() {
    }

    public LectionDTO(Long lectionId, String title, String schoolLevel, String grade, List<TaskDTO> tasks) {
        this.lectionId = lectionId;
        this.title = title;
        this.schoolLevel = schoolLevel;
        this.grade = grade;
        this.tasks = tasks;
    }

    public Long getLectionId() {
        return lectionId;
    }

    public void setLectionId(Long lectionId) {
        this.lectionId = lectionId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getSchoolLevel() {
        return schoolLevel;
    }

    public void setSchoolLevel(String schoolLevel) {
        this.schoolLevel = schoolLevel;
    }

    public String getGrade() {
        return grade;
    }

    public void setGrade(String grade) {
        this.grade = grade;
    }

    public List<TaskDTO> getTasks() {
        return tasks;
    }

    public void setTasks(List<TaskDTO> tasks) {
        this.tasks = tasks;
    }
}