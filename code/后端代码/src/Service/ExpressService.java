package com.example.demo.Service;


import net.minidev.json.JSONObject;

import java.util.Date;

public interface ExpressService {
        JSONObject findbyid(int id);
        void addexpress(String company, Date time, String phonenum);

}
