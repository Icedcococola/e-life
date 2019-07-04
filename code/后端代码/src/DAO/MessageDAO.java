package com.example.demo.dao;

import com.example.demo.Entity.Message;

import java.util.List;

public interface MessageDAO {
        List<Message> findbytype(String type);
List<Message> findbytitle(String title);
}
