package com.Logistics.Project.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.Logistics.Project.entity.Request;
import com.Logistics.Project.service.RiderService;

import jakarta.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("/rider")
public class RiderController {

    @Autowired
    private RiderService riderService;

 
    @GetMapping("/assigned")
    public String viewAssignedRequests(@RequestParam(name = "riderId", required = true) Long riderId, Model model) {
        Iterable<Request> requests = riderService.getAssignedRequests(riderId);
        model.addAttribute("riderId", riderId); // Add riderId to model
        model.addAttribute("requests", requests); // Add requests to model
        return "assigned"; // Return the view name for the assigned requests JSP
    }


    @PostMapping("/updateStatus")
    public String updateStatus(@RequestParam Long requestId, @RequestParam String status) {
        riderService.updateRequestStatus(requestId, status);
        Request updatedRequest = riderService.findRequestById(requestId);
        Long riderId = (updatedRequest != null && updatedRequest.getRider() != null) ? updatedRequest.getRider().getId() : null;
        return "redirect:/rider/assigned?riderId=" + riderId;
    }


    @GetMapping("/completedRequests")
    public String viewCompletedRequests(@RequestParam Long riderId, Model model) {
        Iterable<Request> completedRequests = riderService.getCompletedRequests(riderId);
        model.addAttribute("requests", completedRequests);
        model.addAttribute("riderId", riderId); // Add riderId to model
        return "completedRequests"; // Return the view name for the completed requests JSP
    }

    // Logout
    @RequestMapping("/logout")
    public String logout(HttpServletRequest request) {
        request.getSession().invalidate();
        return "redirect:/login";
    }
}
