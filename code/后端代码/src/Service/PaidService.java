package com.example.demo.Service;

import com.example.demo.Entity.Paid;

import java.util.List;

public interface PaidService {
    List<Paid> findall();
    List<Paid> findbyuseridandtype(int userid,String type);
    List<Paid> findbytype(String type);
}
