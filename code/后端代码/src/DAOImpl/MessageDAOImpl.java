package com.example.demo.daoImpl;

import com.example.demo.Entity.Message;
import com.example.demo.Repository.MessageRepository;
import com.example.demo.dao.MessageDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;
@Repository
public class MessageDAOImpl implements MessageDAO {
    @Autowired
    private MessageRepository messageRepository;

    @Override
    public List<Message> findbytype(String type){
        return messageRepository.findByType(type);
    }
    @Override
    public List<Message> findbytitle(String title){
        return messageRepository.findByTitle(title);
    }
}
