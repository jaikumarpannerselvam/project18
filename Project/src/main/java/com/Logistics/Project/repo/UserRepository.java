package com.Logistics.Project.repo;

import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import com.Logistics.Project.entity.User;

public interface UserRepository extends JpaRepository<User, Long> {

    // Custom query to find users by role
    List<User> findByRole(String role);

	User findByUsername(String username);
}
