package com.Logistics.Project.service;

import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.Logistics.Project.entity.PaymentDetails;
import com.Logistics.Project.entity.Request;
import com.Logistics.Project.entity.User;
import com.Logistics.Project.repo.PaymentDetailsRepository;
import com.Logistics.Project.repo.RequestRepository;
import com.Logistics.Project.repo.UserRepository;
import com.itextpdf.text.BaseColor;
import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Element;
import com.itextpdf.text.Font;
import com.itextpdf.text.PageSize;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.Phrase;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;

import jakarta.servlet.http.HttpServletResponse;

@Service
public class AdminService {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private RequestRepository requestRepository;
    
    @Autowired
    private EmailService emailService;
    
    @Autowired
    private PaymentDetailsRepository paymentDetailsRepository;

    public List<User> findAllRiders() {
        return userRepository.findByRole("Rider");
    }

    public List<Request> findAllRequests() {
        return requestRepository.findAll();
    }

    public void addRider(String username, String password) {
        User user = new User();
        user.setUsername(username);
        user.setPassword(password); // Store hashed passwords in production
        user.setRole("Rider");
        userRepository.save(user);
    }
    
   public void allocateRider(Long requestId, Long riderId) {
        Request request = requestRepository.findById(requestId).orElse(null);
        User rider = userRepository.findById(riderId).orElse(null);
        if (request != null && rider != null) {
            request.setRider(rider);
            request.setStatus("Allocated");
            requestRepository.save(request);
        }
    }

    public void updateStatus(Long requestId, String status) {
        Request request = requestRepository.findById(requestId).orElse(null);
        if (request != null) {
            request.setStatus(status);
            requestRepository.save(request);

            
            
            if ("Completed".equals(status)) {
                User sender = request.getSender();
                String senderEmail = sender.getEmail(); //user entity

                // Email to sender
                String senderSubject = "Request Completed";
                String senderText = "Dear " + sender.getUsername() + ",\n\n" +
                        "Your request with ID " + requestId + " has been completed.\n\n" +
                        "Thank you for using our service!";
                emailService.sendEmail(senderEmail, senderSubject, senderText);
            }
        }
    }

    public List<PaymentDetails> findAllPaymentDetails() {
        return paymentDetailsRepository.findAll();
    }

    public void generatePdf(HttpServletResponse response) throws DocumentException, IOException {
        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition", "attachment; filename=payments.pdf");

        List<PaymentDetails> paymentDetailsList = paymentDetailsRepository.findAll();

        // Set document margins
        Document document = new Document(PageSize.A4, 20, 20, 30, 30); // left, right, top, bottom margins
        PdfWriter.getInstance(document, response.getOutputStream());

        document.open();

        // Add a title to the PDF
        Font titleFont = new Font(Font.FontFamily.HELVETICA, 16, Font.BOLD);
        Paragraph title = new Paragraph("Payment Details Report", titleFont);
        title.setAlignment(Element.ALIGN_CENTER);
        title.setSpacingAfter(20); // Add space after the title
        document.add(title);

        // Table with 8 columns
        PdfPTable table = new PdfPTable(8); // 8 columns
        table.setWidthPercentage(100); // Table width to cover full page width
        table.setSpacingBefore(10f); // Space before the table
        table.setSpacingAfter(10f); // Space after the table

        // Set column widths (adjust as per your need)
        float[] columnWidths = {1.5f, 2.5f, 3.5f, 1.5f, 2.5f, 2.0f, 1.5f, 3.0f}; // Proportional widths for each column
        table.setWidths(columnWidths);

        // Table Header
        Font headerFont = new Font(Font.FontFamily.HELVETICA, 12, Font.BOLD);
        String[] headers = {"Request ID", "Card Number", "Card Holder Name", "CVV", "Expiry Date", "Amount", "Sender ID", "Sender Name"};
        for (String header : headers) {
            PdfPCell headerCell = new PdfPCell(new Phrase(header, headerFont));
            headerCell.setHorizontalAlignment(Element.ALIGN_CENTER);
            headerCell.setPadding(5); // Add padding to the header cells
            headerCell.setBackgroundColor(BaseColor.LIGHT_GRAY); // Set background color for header
            table.addCell(headerCell);
        }

        // Table Rows
        Font rowFont = new Font(Font.FontFamily.HELVETICA, 10, Font.NORMAL);
        for (PaymentDetails payment : paymentDetailsList) {
            // Request ID
            table.addCell(createCell(payment.getRequestId().toString(), rowFont, Element.ALIGN_CENTER));

            // Card Number
            table.addCell(createCell(payment.getCardNumber(), rowFont, Element.ALIGN_CENTER));

            // Card Holder Name
            table.addCell(createCell(payment.getCardHolderName(), rowFont, Element.ALIGN_CENTER));

            // CVV
            table.addCell(createCell(payment.getCvv(), rowFont, Element.ALIGN_CENTER));

            // Expiry Date
            table.addCell(createCell(payment.getExpiryDate(), rowFont, Element.ALIGN_CENTER));

            // Amount (handling null values)
            String amount = (payment.getAmount() != null) ? payment.getAmount().toString() : "N/A";
            table.addCell(createCell(amount, rowFont, Element.ALIGN_RIGHT));

            // Sender ID (handling null values)
            User sender = payment.getSender();
            String senderId = (sender != null && sender.getId() != null) ? sender.getId().toString() : "N/A";
            table.addCell(createCell(senderId, rowFont, Element.ALIGN_CENTER));

            // Sender Name (handling null values)
            String senderName = (sender != null && sender.getUsername() != null) ? sender.getUsername() : "N/A";
            table.addCell(createCell(senderName, rowFont, Element.ALIGN_CENTER));
        }

        document.add(table);
        document.close();
    }

    // Helper method to create table cells
    private PdfPCell createCell(String content, Font font, int alignment) {
        PdfPCell cell = new PdfPCell(new Phrase(content, font));
        cell.setHorizontalAlignment(alignment);
        cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
        cell.setPadding(5); // Add padding to make the cell content neat
        return cell;
    }

}
