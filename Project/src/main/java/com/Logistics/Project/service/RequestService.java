package com.Logistics.Project.service;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.Logistics.Project.entity.Request;
import com.Logistics.Project.entity.User;
import com.Logistics.Project.repo.RequestRepository;

@Service
public class RequestService {

    @Autowired
    private RequestRepository requestRepository;

    // Find all requests
    public List<Request> findAll() {
        return requestRepository.findAll();
    }

    // Find a request by ID
    public Request findById(Long id) {
        return requestRepository.findById(id).orElse(null);
    }

    // Find requests by rider ID
    public List<Request> findByRiderId(Long riderId) {
        return requestRepository.findByRiderId(riderId);
    }

    // Find requests by rider ID and status
    public List<Request> findByRiderIdAndStatus(Long riderId, String status) {
        return (List<Request>) requestRepository.findByRiderIdAndStatus(riderId, status);
    }

    // Find requests by rider ID where the status is not a specific value
    public List<Request> findByRiderIdAndStatusNot(Long riderId, String status) {
        return requestRepository.findByRiderIdAndStatusNot(riderId, status);
    }

    // Delete a request
    public void delete(Long id) {
        requestRepository.deleteById(id);
    }

    // Find requests by sender (User entity)
    public List<Request> findBySender(User sender) {
        return requestRepository.findBySender(sender);
    }

    // Find requests by sender ID
    public List<Request> findBySenderId(Long senderId) {
        return requestRepository.findBySenderId(senderId);
    }

    // Find completed requests by sender ID
    public List<Request> findCompletedRequestsBySender(Long senderId) {
        return requestRepository.findBySenderIdAndStatus(senderId, "Completed");
    }

    // Find completed requests by rider ID
    public List<Request> findCompletedRequestsByRider(Long riderId) {
        return (List<Request>) requestRepository.findByRiderIdAndStatus(riderId, "Completed");
    }

    // Constants for request calculation
    private static final double UNIT_PRICE = 100.0; // Define your unit price here

    // Save a request with automatic timestamp and total amount calculation
    public void save(Request request) {
        // Set the createdAt field before saving
        request.setCreatedAt(LocalDateTime.now());

        // Calculate the total amount based on quantity
        double totalAmount = request.getQuantity() * UNIT_PRICE;
        request.setAmount(totalAmount);

        // Save the request to the database
        requestRepository.save(request);
    }

    // Get assigned requests (where status is not 'Completed')
    public List<Request> getAssignedRequests(Long riderId) {
        return requestRepository.findByRiderIdAndStatusNot(riderId, "Completed");
    }

    // Get sender ID by request ID
    public Long getSenderId(Long requestId) {
        Request request = findById(requestId);
        if (request != null && request.getSender() != null) {
            return request.getSender().getId();
        }
        return null; // If the request or sender is null, return null
    }

    // Get request by ID
    public Request getRequestById(Long requestId) {
        return requestRepository.findById(requestId).orElse(null);
    }

    // Find completed requests for sender by sender ID
    public List<Request> getCompletedRequestsForSender(Long senderId) {
        return requestRepository.findBySenderIdAndStatus(senderId, "Completed");
    }
}
