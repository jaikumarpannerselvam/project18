package com.Logistics.Project.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.Logistics.Project.entity.User;
import com.Logistics.Project.repo.UserRepository;

@Service
public class UserService {

    @Autowired
    private UserRepository userRepository;

    // Save a user
    public User save(User user) {
        return userRepository.save(user);
    }

    // Find a user by ID
    public User findById(Long id) {
        return userRepository.findById(id).orElse(null);
    }

    // Find users by role
    public List<User> findByRole(String role) {
        return userRepository.findByRole(role);
    }

    // Delete a user
    public void delete(Long id) {
        userRepository.deleteById(id);
      
    }

    // Find a user by username
    public User findByUsername(String username) {
        return userRepository.findByUsername(username);
    }
    
}
