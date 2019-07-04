package com.example.demo.daoImpl;

import com.example.demo.Entity.Post;
import com.example.demo.Repository.PostRepository;
import com.example.demo.dao.PostDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class PostDAOImpl implements PostDAO {

    @Autowired
    private PostRepository postRepository;


    @Override
    public List<Post> findbyposter(String poster){
        return postRepository.findByPoster(poster);
    }

    @Override
    public List<Post> findall(){
        return postRepository.findAll();
    }
}
