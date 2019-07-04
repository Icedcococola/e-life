package com.example.demo.dao;

import com.example.demo.Entity.Desireduser;

import java.util.List;

public interface DesireduserDAO {
    List<Desireduser> findall();
    List<Desireduser> findbyuserid(int userid);
}
