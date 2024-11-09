package com.Logistics.Project.repo;

import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import com.Logistics.Project.entity.Request;
import com.Logistics.Project.entity.User;

public interface RequestRepository extends JpaRepository<Request, Long> {

    // Custom query to find requests by rider ID
    List<Request> findByRiderId(Long riderId);

    // Custom query to find requests by sender
    List<Request> findBySender(User sender);
    
    List<Request> findBySenderId(Long senderId);

    List<Request> findBySenderIdAndStatus(Long senderId, String status);
    
   
    Iterable<Request> findByRiderIdAndStatus(Long riderId, String status);
    // Custom query to find requests by rider ID where the status is not a specific value
    List<Request> findByRiderIdAndStatusNot(Long riderId, String status);

	//List<Request> findCompletedRequestsBySender(Long senderId);
    
}
