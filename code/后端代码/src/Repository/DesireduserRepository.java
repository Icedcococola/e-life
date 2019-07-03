package com.example.demo.Repository;

import com.example.demo.Entity.Desireduser;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface DesireduserRepository extends JpaRepository<Desireduser,Integer> {
    List<Desireduser> findAll();
    List<Desireduser> findAllByUserid(int userid);
}
