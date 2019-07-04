package com.example.demo.daoImpl;

import com.example.demo.Entity.Paid;
import com.example.demo.Repository.PaidRepository;
import com.example.demo.dao.PaidDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class PaidDAOImpl implements PaidDAO {
        @Autowired
        private PaidRepository paidRepository;

        @Override
        public List<Paid> findall(){return paidRepository.findAll();}
    @Override
    public List<Paid> findbytype(String type){
            return paidRepository.findAllByType(type);
    }

    @Override
    public List<Paid> findbyuseridandtype(int userid,String type){
            return paidRepository.findAllByUseridAndType(userid,type);
    }
}
