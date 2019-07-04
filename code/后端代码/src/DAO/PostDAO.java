package com.example.demo.dao;

import com.example.demo.Entity.Post;

import java.util.List;

public interface PostDAO {
    List<Post> findall();
    List<Post> findbyposter(String poster);
}
