package com.example.demo.daoImpl;

import com.example.demo.Entity.Desireduser;
import com.example.demo.Repository.DesireduserRepository;
import com.example.demo.dao.DesireduserDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;
@Repository
public class DesireduserDAOImpl implements DesireduserDAO {
    @Autowired
    private DesireduserRepository desireduserRepository;

    @Override
    public List<Desireduser> findall()
    {return desireduserRepository.findAll();}

    @Override
    public List<Desireduser> findbyuserid(int userid){
        return desireduserRepository.findAllByUserid(userid);
    }
}
