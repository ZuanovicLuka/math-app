package math.backend.mapper;

import math.backend.dto.UserProfileDto;
import math.backend.model.User;

public class UserMapper {
    public static UserProfileDto toDto(User user) {
        UserProfileDto dto = new UserProfileDto();
        dto.setUserId(user.getUserId());
        dto.setFirstName(user.getFirstName());
        dto.setLastName(user.getLastName());
        dto.setUsername(user.getUsername());
        dto.setEmail(user.getEmail());
        dto.setSchoolLevel(user.getSchoolLevel());
        dto.setProfilePicture(user.getProfilePicture());
        return dto;
    }
}