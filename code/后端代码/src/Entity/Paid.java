package com.example.demo.Entity;

import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name="Paid" ,schema = "elife")
public class Paid {
    private int paidid;
    private int userid;
    private int price;
    private Date time;
    private String type;


    @Id
    @Column(name="paidid")
    public int getPaidid(){return paidid;}
    public void setPaidid(int paidid){this.paidid=paidid;}

    @Basic
    @Column(name="userid")
    public int getUserid(){return userid;}
    public void setUserid(int userid){this.userid=userid;}

    @Basic
    @Column(name="time")
    public Date getTime(){return time;}
    public void setTime(Date time){this.time=time;}

    @Basic
    @Column(name="price")
    public int getPrice(){return price;}
    public void setPrice(int price){this.price=price;}

    @Basic
    @Column(name="type")
    public String getType(){return type;}
    public void setType(String type){this.type=type;}



}
