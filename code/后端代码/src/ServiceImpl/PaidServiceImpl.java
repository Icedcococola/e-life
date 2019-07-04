package com.example.demo.ServiceImpl;

import com.example.demo.Entity.Paid;
import com.example.demo.Service.PaidService;
import com.example.demo.dao.PaidDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class PaidServiceImpl implements PaidService {
    @Autowired
    private PaidDAO paidDAO;
    @Override
    public List<Paid> findall(){
        return paidDAO.findall();
    }
    @Override
    public List<Paid> findbyuseridandtype(int userid,String type){
        return paidDAO.findbyuseridandtype(userid,type);
    }

    @Override
    public List<Paid> findbytype(String type){
        return paidDAO.findbytype(type);
    }
}
