package com.example.demo.ServiceImpl;

import com.example.demo.Entity.User;
import com.example.demo.Service.UserService;
import com.example.demo.dao.UserDAO;
import com.zhenzi.sms.ZhenziSmsClient;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Random;

@Service
public class UserServiceImpl implements UserService {
    @Autowired
    private UserDAO userDAO;

    @Override
    public User findbyphonenum(String phonenum)
    {
        return userDAO.findbyphonenum(phonenum);
    }
    @Override
    public User findbyusername(String username)
    {
        return userDAO.findbyusername(username);
    }

    @Override
    public int login(String username,String password){
        User is_empty_user=userDAO.findbyusername(username);
        if(is_empty_user==null) return 0;

        User user=userDAO.findbyusernameandpassword(username,password);
        if(user==null)
        {
            return 1;
        }
        else
        {
            return 2;
        }

    }

    @Override
    public int register(String username,String password,String email,String realname,
    String phonenum,String community) throws Exception {
        User is_exist_user=userDAO.findbyusername(username);
        if(!(is_exist_user==null))
        {
            return 0;
        }
        User is_exist_phone=userDAO.findbyphonenum(phonenum);
        if(!(is_exist_phone==null))
        {
            return 2;
        }


        User user=new User() ;
        user.setUsername(username);
        user.setPassword(password);
        user.setEmail(email);
        user.setCommunity(community);
        user.setRealname(realname);
        user.setPhonenum(phonenum);
        userDAO.save(user);
        return 3;
    }

    @Override
    public int modify(String username,String password,String email,String realname,
                       String phonenum,String community)
    {
        User user=userDAO.findbyusername(username);
        user.setPassword(password);
        user.setRealname(realname);
        user.setEmail(email);
        user.setPhonenum(phonenum);
        user.setCommunity(community);
        userDAO.save(user);
        return 1;
    }

    @Override
    public int verify(String phonenum)throws Exception {
        User user = userDAO.findbyphonenum(phonenum);
        //手机号已被注册
        if (!(user == null))
        {
            return 2;
        }

        Random r=new Random();
        int ran=r.nextInt(10000);
        System.out.println(ran);
        ZhenziSmsClient client=new ZhenziSmsClient("https://sms_developer.zhenzikj.com",
                "102013","4f54b9d7-e296-4d82-9df5-7a643d4720b1");

        String result=client.send(phonenum, "尊敬的e-life用户您好，您的验证码为"+ran
                + "，有效时长为2分钟");
        //返回验证码的值，前端点击注册按钮时进行验证，匹配成功了再调用后端注册的函数
        return ran;

    }


    @Override
    public void modifypassword(String username,String new_password)
    {
        User user=userDAO.findbyusername(username);
        user.setPassword(new_password);
        userDAO.save(user);
    }
}
