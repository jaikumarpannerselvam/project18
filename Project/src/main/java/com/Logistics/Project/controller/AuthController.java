package com.Logistics.Project.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.Logistics.Project.entity.User;
import com.Logistics.Project.service.AuthService;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class AuthController {

    @Autowired
    private AuthService authService;

    @RequestMapping("/")
    public String index() {
        return "index";
    }

    @RequestMapping("/login")
    public String loginPage() {
        return "login";
    }

    @RequestMapping("/register")
    public String registerPage() {
        return "register";
    }

    @PostMapping("/login")
    public String login(@RequestParam String username, @RequestParam String password, HttpServletRequest httpRequest, Model model) {
        User user = authService.authenticateUser(username, password);
        if (user != null) {
            httpRequest.getSession().setAttribute("loggedInUser", user);

            if ("Rider".equals(user.getRole())) {
                return "redirect:/rider/assigned?riderId=" + user.getId();
            }
            switch (user.getRole()) {
                case "Admin":
                    return "redirect:/admin/panel";
                case "Sender":
                    return "redirect:/sender/create";
                default:
                    model.addAttribute("error", "Invalid role");
                    return "login";
            }
        } else {
            model.addAttribute("error", "Invalid username or password");
            return "login";
        }
    }

    @PostMapping("/register")
    public String register(@RequestParam String username, @RequestParam String password, @RequestParam String role, @RequestParam String email, Model model) {
        boolean isRegistered = authService.registerUser(username, password, role, email);
        if (!isRegistered) {
            model.addAttribute("error", "Username already exists");
            return "register";
        }
        return "redirect:/login";
    }

    @RequestMapping("/logout")
    public String logout(HttpServletRequest request) {
        request.getSession().invalidate();
        return "redirect:/login";
    }
}
