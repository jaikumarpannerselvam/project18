package com.Logistics.Project.controller;

import java.io.IOException;
import java.util.List;

import org.apache.log4j.Logger;
//import org.slf4j.Logger;
//import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.RestTemplate;

import com.Logistics.Project.entity.PaymentDetails;
import com.Logistics.Project.service.AdminService;
import com.Logistics.Project.service.UserService;
import com.itextpdf.text.DocumentException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Controller
@RequestMapping("/admin")
public class AdminController {

   // public static final Logger logger = LoggerFactory.getLogger(AdminController.class);
    public static final Logger logger=Logger.getLogger(AdminController.class); 

    @Autowired
    private AdminService adminService;
    
    @Autowired
    private RestTemplate restTemplate;
    
    @Autowired
    private UserService userService;


    @RequestMapping("/panel")
    public String adminPanel(Model model) {
        model.addAttribute("riders", adminService.findAllRiders());
        model.addAttribute("requests", adminService.findAllRequests());
        logger.info("enter into panel");
        return "adminPanel";
    }

    @RequestMapping("/manageRiders")
    public String manageRiders(Model model) {
        model.addAttribute("riders", adminService.findAllRiders());
        return "manageRiders";
    }

    @RequestMapping("/manageRequests")
    public String manageRequests(Model model) {
        model.addAttribute("requests", adminService.findAllRequests());
        model.addAttribute("riders", adminService.findAllRiders());
        return "manageRequests";
    }

    @PostMapping("/addRider")
    public String addRider(@RequestParam String username, @RequestParam String password) {
        adminService.addRider(username, password);
        return "redirect:/admin/manageRiders";
    }

    @PostMapping("/removeRider")
    public String removeRider(@RequestParam Long riderId) {
        userService.delete(riderId);
        
        return "redirect:/admin/manageRiders";
    }

    @PostMapping("/allocate")
    public String allocateRider(@RequestParam Long requestId, @RequestParam Long riderId) {
        adminService.allocateRider(requestId, riderId);
        return "redirect:/admin/manageRequests";
    }

    @PostMapping("/updateStatus")
    public String updateStatus(@RequestParam Long requestId, @RequestParam String status) {
        adminService.updateStatus(requestId, status);
        return "redirect:/admin/manageRequests";
    }

    @RequestMapping("/logout")
    public String logout(HttpServletRequest request) {
        request.getSession().invalidate();
        return "redirect:/login";
    }
    
    
    @GetMapping("/paydetails")
    public String viewPaymentDetails(Model model) {
        List<PaymentDetails> paymentDetails = adminService.findAllPaymentDetails();
        model.addAttribute("paymentDetails", paymentDetails);
        return "paydetails"; // Renders paydetails.jsp
    }

    
    @GetMapping("/downloadPayments")
    public void downloadPayments(HttpServletResponse response) throws IOException {
        try {
            adminService.generatePdf(response);
        } catch (DocumentException e) {
            throw new IOException("Error generating PDF", e);
        }
    }
   
    
    
    @GetMapping("/viewTickets")
    public String contactSupport(Model model) {
    	 logger.info("calling support team");

  
        String supportUrl = "http://localhost:9091/support/ticket";

        ResponseEntity<String> response = restTemplate.getForEntity(supportUrl, String.class);

        if (!response.getStatusCode().is2xxSuccessful()) {
            throw new RuntimeException("Failed to contact support system");
        }

   
        return "redirect:" + supportUrl;
    }

}
