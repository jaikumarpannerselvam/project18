package com.Logistics.Project.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.Logistics.Project.entity.Request;
import com.Logistics.Project.repo.RequestRepository;

@Service
public class RiderService {

    @Autowired
    private RequestRepository requestRepository;

    public Iterable<Request> getAssignedRequests(Long riderId) {
        return requestRepository.findByRiderIdAndStatusNot(riderId, "Completed");
    }

    public Request findRequestById(Long requestId) {
        return requestRepository.findById(requestId).orElse(null);
    }

    public void updateRequestStatus(Long requestId, String status) {
        Request request = findRequestById(requestId);
        if (request != null) {
            request.setStatus(status);
            requestRepository.save(request);
        }
    }

    public Iterable<Request> getCompletedRequests(Long riderId) {
        return requestRepository.findByRiderIdAndStatus(riderId, "Completed");
    }
}
