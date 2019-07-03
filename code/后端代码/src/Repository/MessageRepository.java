package com.example.demo.Repository;

import com.example.demo.Entity.Message;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface MessageRepository extends JpaRepository<Message,Integer> {
    Message findByMessageid(int messageid);
    List<Message> findByType(String type);
    List<Message> findByTitle(String title);
}
