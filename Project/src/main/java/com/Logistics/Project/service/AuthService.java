package com.Logistics.Project.service;



import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.Logistics.Project.entity.User;
import com.Logistics.Project.repo.UserRepository;

@Service
public class AuthService {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private EmailService emailService;

    public User authenticateUser(String username, String password) {
        User user = userRepository.findByUsername(username);
        if (user != null && user.getPassword().equals(password)) {
            return user;
        }
        return null;
    }

    public boolean registerUser(String username, String password, String role, String email) {
        User existingUser = userRepository.findByUsername(username);
        if (existingUser != null) {
            return false; // Username already exists
        }
        User user = new User();
        user.setUsername(username);
        user.setPassword(password); // Store hashed passwords in production
        user.setRole(role);
        user.setEmail(email);
        userRepository.save(user);

        // Send a confirmation email
        String subject = "Registration Confirmation";
        String text = "Dear " + username + ",\n\n" +
                "Thank you for registering with our logistics management system.\n" +
                "Your account has been successfully created.\n\n" +
                "Best regards,\n" +
                "ShipEase Logistics Management System Team";
        emailService.sendEmail(email, subject, text);

        return true;
    }
}
