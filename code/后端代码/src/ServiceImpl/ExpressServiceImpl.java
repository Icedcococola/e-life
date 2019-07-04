package com.example.demo.ServiceImpl;

import com.example.demo.Entity.Express;
import com.example.demo.Service.ExpressService;
import com.example.demo.dao.ExpressDAO;
import net.minidev.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;

@Service
public class ExpressServiceImpl implements ExpressService {
    @Autowired
    private ExpressDAO expressDAO;

    @Override
    public JSONObject findbyid(int id){
        Express express=expressDAO.findbyid(id);
        JSONObject jsonObject=new JSONObject();
        jsonObject.put("packageid",express.getPackageid());
        jsonObject.put("time",express.getTime());
        jsonObject.put("company",express.getCompany());
        jsonObject.put("phonenum",express.getPhonenum());
        return jsonObject;
    }

    @Override
    public void addexpress(String phonenum, Date time,String company)
    {

    }
}
