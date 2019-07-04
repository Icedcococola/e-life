package com.example.demo.Service;

import com.example.demo.Entity.Desireduser;

import java.util.List;

public interface DesireduserService {
    List<Desireduser> findall();
    List<Desireduser> findbyuserid(int userid);
}
