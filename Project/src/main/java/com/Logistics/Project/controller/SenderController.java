package com.Logistics.Project.controller;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.time.LocalDateTime;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.RestTemplate;

import com.Logistics.Project.entity.PaymentDetails;
import com.Logistics.Project.entity.Request;
import com.Logistics.Project.entity.User;
import com.Logistics.Project.repo.PaymentDetailsRepository;
import com.Logistics.Project.service.EmailService;
import com.Logistics.Project.service.RequestService;
import com.Logistics.Project.service.UserService;
import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.pdf.PdfWriter;

import jakarta.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("/sender")
public class SenderController {
    @Autowired
    private UserService userService;

    @Autowired
    private RequestService requestService;

    @Autowired
    private EmailService emailService;

    @Autowired
    private RestTemplate restTemplate;

    @Autowired
    private PaymentDetailsRepository paymentDetailsRepository;

    @GetMapping("/paymentDetails")
    public String showPaymentDetailsPage(@RequestParam("requestId") Long requestId, Model model) {
        model.addAttribute("requestId", requestId);
        return "paymentDetails"; // Returns WEB-INF/paymentDetails.jsp
    }

    @PostMapping("/savePaymentDetails")
    public String savePaymentDetails(@ModelAttribute PaymentDetails paymentDetails,
            @RequestParam("amount") Double amount, @RequestParam("senderId") Long senderId,
            HttpServletRequest httpRequest) throws IOException {
        // Set the amount in the PaymentDetails object
        paymentDetails.setAmount(amount);

        // Retrieve the sender and ensure it's not null
        User sender = userService.findById(senderId);
        if (sender == null) {
            throw new RuntimeException("Sender not found with ID: " + senderId);
        }
        paymentDetails.setSender(sender);

        // Save payment details to the database
        paymentDetailsRepository.save(paymentDetails);

        // Generate PDF invoice with all payment details, including the amount
        generateInvoice(paymentDetails, httpRequest);

        // Redirect to the sender's status page after saving payment details
        return "redirect:/sender/status";
    }

    private void generateInvoice(PaymentDetails paymentDetails, HttpServletRequest request) throws IOException {
        // Retrieve request details
        Request requestDetails = requestService.findById(paymentDetails.getRequestId());
        User sender = (User) request.getSession().getAttribute("loggedInUser");

        // Check if objects are not null
        if (requestDetails == null || sender == null) {
            throw new RuntimeException("Request or Sender not found.");
        }

        String email = sender.getEmail();

        // Create the PDF document
        Document document = new Document();
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        try {
            PdfWriter.getInstance(document, baos);
            document.open();

            // Invoice Header
            document.add(new Paragraph("ShipEase Logistics"));
            document.add(new Paragraph("Chennai"));
            document.add(new Paragraph("Email: shipease@example.com"));
            document.add(new Paragraph("Phone: 7894561230"));
            document.add(new Paragraph(" ")); 
            document.add(new Paragraph("Invoice"));
            document.add(new Paragraph("Date: " + LocalDateTime.now()));
            document.add(new Paragraph(" ")); 

            // Sender (Customer) Information
            document.add(new Paragraph("Billed To:"));
            document.add(new Paragraph("Name: " + sender.getUsername()));
            document.add(new Paragraph("Email: " + sender.getEmail()));
            document.add(new Paragraph(" ")); 

            // Recipient (Company) Information
            document.add(new Paragraph("Service Provider:"));
            document.add(new Paragraph("ShipEase Logistics Company"));
            document.add(new Paragraph("Chennai, Tamil Nadu"));
            document.add(new Paragraph("Email: shipease@gmails.com"));
            document.add(new Paragraph(" ")); 

            // Request Details
            document.add(new Paragraph("Request Details:"));
            document.add(new Paragraph("Request ID: " + requestDetails.getId()));
            document.add(new Paragraph("Description: " + requestDetails.getDescription()));
            document.add(new Paragraph("Order Date: " + requestDetails.getOrderDate()));
            document.add(new Paragraph("Expected Delivery Date: " + requestDetails.getExpectedDelivery()));
            document.add(new Paragraph(" ")); 

            // Payment Details
            document.add(new Paragraph("Payment Details:"));
            document.add(new Paragraph("Card Holder: " + paymentDetails.getCardHolderName()));
            document.add(new Paragraph("Card Number: " + paymentDetails.getCardNumber().replaceAll(".(?=.{4})", "*")));
            document.add(new Paragraph("Amount Paid: $" + paymentDetails.getAmount())); // Use dynamic amount
            document.add(new Paragraph("Payment Date: " + LocalDateTime.now()));
            document.add(new Paragraph(" ")); 

            document.close();

            
            byte[] pdfBytes = baos.toByteArray();

            // Send PDF via email
            emailService.sendEmailWithAttachment(email, "Invoice for Your Payment",
                    "Please find your invoice attached.", pdfBytes);

        } catch (DocumentException e) {
            e.printStackTrace();
        } finally {
            baos.close();
        }
    }

    @RequestMapping("/create")
    public String createRequestForm(Model model) {
        model.addAttribute("request", new Request());
        return "create"; // Refers to src/main/webapp/WEB-INF/create.jsp
    }

    @RequestMapping("/payment")
    public String paymentPage(@RequestParam("requestId") Long requestId, Model model) {
        Request request = requestService.getRequestById(requestId);
        User sender = request.getSender(); // Assuming request has a sender object

        model.addAttribute("request", request);
        model.addAttribute("senderId", sender.getId());
        model.addAttribute("senderName", sender.getUsername());

        return "payment"; 
    }

    @PostMapping("/confirmPayment")
    public String confirmPayment(@RequestParam("requestId") Long requestId, Model model) {
        // Find the request by its ID
        Request request = requestService.findById(requestId);

        if (request != null) {
            // Update the request status to "Paid"
            request.setStatus("Paid");
            requestService.save(request);

            // Send email confirmation
            String senderEmail = request.getSender().getEmail();
            String subject = "Payment Confirmation for Request #" + request.getId();
            String body = "Dear " + request.getSenderName() + ",\n\n" +
                    "Your payment for Request #" + request.getId() + " has been successfully confirmed.\n" +
                    "The package will be delivered soon.\n\n" +
                    "Thank you for choosing our service!";
            emailService.sendEmail(senderEmail, subject, body);

            // Redirect to the status page
            return "redirect:/sender/status";
        } else {
            model.addAttribute("errorMessage", "Request not found.");
            return "error";
        }
    }

    @PostMapping("/submit")
    public String submitRequest(Request request, HttpServletRequest httpRequest) {
        User sender = (User) httpRequest.getSession().getAttribute("loggedInUser");
        if (sender != null) {
            request.setSender(sender);
            request.setSenderName(sender.getUsername());
            request.setStatus("Pending");

            // Ensure orderDate is set to the current date/time if not set
            if (request.getOrderDate() == null) {
                request.setOrderDate(LocalDateTime.now());
            }

            requestService.save(request);
            // Redirect to the payment page with the request ID
            return "redirect:/sender/payment?requestId=" + request.getId();
        } else {
            return "redirect:/login";
        }
    }

    @GetMapping("/deliveries")
    public String viewDeliveries(Model model, HttpServletRequest httpRequest) {
        User sender = (User) httpRequest.getSession().getAttribute("loggedInUser");

        if (sender != null) {
            List<Request> completedRequests = requestService.findCompletedRequestsBySender(sender.getId());
            model.addAttribute("completedRequests", completedRequests);
            model.addAttribute("senderUsername", sender.getUsername());
            model.addAttribute("senderId", sender.getId());
            return "yourDeliveries";
        }

        return "redirect:/login";
    }
    
   

    @RequestMapping("/status")
    public String viewStatus(Model model, HttpServletRequest request) {
        User sender = (User) request.getSession().getAttribute("loggedInUser");

        if (sender != null) {
            List<Request> requests = requestService.findBySender(sender);
            model.addAttribute("requests", requests);
        } else {
            return "redirect:/login";
        }
        return "status";
    }

    @GetMapping("/contactSupport")
    public String contactSupport(@RequestParam("requestId") Long requestId,
                                 @RequestParam("senderId") Long senderId,
                                 Model model) {

        // Ensure senderId and requestId are valid
        if (senderId == null || requestId == null) {
            throw new IllegalArgumentException("Missing senderId or requestId");
        }

      
        String supportUrl = "http://localhost:9091/support/ticket/new?requestId=" + requestId + "&senderId=" + senderId;

        // Call support system using RestTemplate
        ResponseEntity<String> response = restTemplate.getForEntity(supportUrl, String.class);

        // Handle error in response
        if (!response.getStatusCode().is2xxSuccessful()) {
            throw new RuntimeException("Failed to contact support system");
        }

        // Redirect to the support system's ticket form
        return "redirect:" + supportUrl;
    }


}
