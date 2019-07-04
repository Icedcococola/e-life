package com.example.demo.ServiceImpl;

import com.example.demo.Entity.Post;
import com.example.demo.Service.PostService;
import com.example.demo.dao.PostDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class PostServiceImpl implements PostService {
    @Autowired
    private PostDAO postDAO;

    @Override
    public List<Post> findall(){
        return postDAO.findall();
    }
}
