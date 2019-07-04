package com.example.demo.dao;

import com.example.demo.Entity.Express;

public interface ExpressDAO {
    Express findbyid(int id);
    void save(Express express);
}
