package com.example.demo.ServiceImpl;

import com.example.demo.Entity.Desireduser;
import com.example.demo.Service.DesireduserService;
import com.example.demo.dao.DesireduserDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class DesireduserServiceImpl implements DesireduserService {
    @Autowired
    private DesireduserDAO desireduserDAO;

    @Override
    public List<Desireduser> findall()
    {
        return desireduserDAO.findall();
    }

    @Override
    public List<Desireduser> findbyuserid(int userid){
        return desireduserDAO.findbyuserid(userid);
    }
}
