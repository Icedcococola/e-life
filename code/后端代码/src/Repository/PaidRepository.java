package com.example.demo.Repository;

import com.example.demo.Entity.Paid;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface PaidRepository extends JpaRepository<Paid,Integer> {
    List<Paid> findAll();
    List<Paid> findAllByUseridAndType(int userid,String type);
    List<Paid> findAllByType(String type);

}
