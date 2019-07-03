package com.example.demo.Repository;

import com.example.demo.Entity.Post;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface PostRepository extends JpaRepository<Post,Integer> {
            List<Post> findByPoster(String poster);
            List<Post> findAll();

}
