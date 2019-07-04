package com.example.demo.daoImpl;

import com.example.demo.Entity.Express;
import com.example.demo.Repository.ExpressRepository;
import com.example.demo.dao.ExpressDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ExpressDAOImpl implements ExpressDAO {
        @Autowired
        private ExpressRepository expressRepository;

        @Override
        public Express findbyid(int id){
            return expressRepository.findAllByPackageid(id);
        }

        @Override
        public void save(Express express){ expressRepository.save(express);}
}
