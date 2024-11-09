package com.Logistics.Project.repo;

import com.Logistics.Project.entity.PaymentDetails;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface PaymentDetailsRepository extends JpaRepository<PaymentDetails, Long> {
    List<PaymentDetails> findByRequestId(Long requestId);
    List<PaymentDetails> findBySenderId(Long senderId); // Ensure this method matches the field name
}
