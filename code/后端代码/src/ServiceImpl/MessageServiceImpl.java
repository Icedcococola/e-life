package com.example.demo.ServiceImpl;

import com.example.demo.Entity.Message;
import com.example.demo.Service.MessageService;
import com.example.demo.dao.MessageDAO;
import net.minidev.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

@Service
public class MessageServiceImpl implements MessageService {

    @Autowired
    private MessageDAO messageDAO;

    @Override
    public List<JSONObject> findbytype(String type){
        List<Message> tmp=messageDAO.findbytype(type);
        List<JSONObject> messages=new ArrayList<JSONObject>();
        if(tmp==null)
        { return messages;}
        Iterator<Message> it=tmp.iterator();
            while(it.hasNext()){
                    Message message=it.next();
                    JSONObject jsonObject=new JSONObject();
                    jsonObject.put("messageid",message.getMessageid());
                    jsonObject.put("time",message.getTime());
                    jsonObject.put("detail",message.getDetail());
                    jsonObject.put("type",message.getType());
                    jsonObject.put("title",message.getTitle());
                    messages.add(jsonObject);
        }
            return messages;
    }

    @Override
    public List<JSONObject> findbytitle(String title){
        List<Message> tmp=messageDAO.findbytitle(title);
        List<JSONObject> messages=new ArrayList<JSONObject>();
        if(tmp==null)
        { return messages;}
        Iterator<Message> it=tmp.iterator();
        while(it.hasNext()){
            Message message=it.next();
            JSONObject jsonObject=new JSONObject();
            jsonObject.put("time",message.getTime());
            jsonObject.put("detail",message.getDetail());
            jsonObject.put("type",message.getType());
            jsonObject.put("messageid",message.getMessageid());
            jsonObject.put("title",message.getTitle());
            messages.add(jsonObject);
        }
        return messages;
    }


}
