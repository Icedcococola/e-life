package com.example.demo.dao;

import com.example.demo.Entity.Paid;

import java.util.List;

public interface PaidDAO {
    List<Paid> findall();
    List<Paid> findbyuseridandtype(int userid,String type);
    List<Paid> findbytype(String type);
}
