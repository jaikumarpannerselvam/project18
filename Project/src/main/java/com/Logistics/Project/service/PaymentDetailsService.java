package com.Logistics.Project.service;

import com.Logistics.Project.entity.PaymentDetails;
import com.Logistics.Project.repo.PaymentDetailsRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class PaymentDetailsService {

    @Autowired
    private PaymentDetailsRepository paymentDetailsRepository;

    // Fetch payment details by request ID
    public List<PaymentDetails> findByRequestId(Long requestId) {
        return paymentDetailsRepository.findByRequestId(requestId);
    }

    // Fetch payment details by sender ID
    public List<PaymentDetails> findBySenderId(Long senderId) {
        return paymentDetailsRepository.findBySenderId(senderId);
    }

    // Fetch all payment details
    public List<PaymentDetails> findAll() {
        return paymentDetailsRepository.findAll(); // Corrected to return all payment details
    }
}
