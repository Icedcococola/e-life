package com.example.demo.Service;

import net.minidev.json.JSONObject;

import java.util.List;

public interface MessageService {
    List<JSONObject> findbytype(String type);
    List<JSONObject> findbytitle(String title);
}
