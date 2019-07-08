package com.example.demo.Service;

import com.example.demo.Entity.User;

public interface UserService {
    User findbyphonenum(String phonenum);
    User findbyusername(String username);
    int login(String username,String password);
    int register(String username,String password,
                 String email,String realname,String phonenum,String community) throws Exception;
    int modify(String username,String password,String email,
                String realname,String phonenum,String community);
    int  verify(String phonenum) throws Exception;
    void modifypassword(String username,String new_password);
    int fetchpassword(String username,String phonenum)throws  Exception;
}
