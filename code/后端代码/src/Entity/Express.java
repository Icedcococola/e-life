package com.example.demo.Entity;


import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name="express",schema = "elife")
public class Express {
    private int packageid;
    private String phonenum;
    private Date time;
    private String company;

    @Id
    @Column(name="packageid")
    public int getPackageid(){return packageid;}
    public void setPackageid(int packageid){this.packageid=packageid;}

    @Basic
    @Column(name="phonenum")
    public String getPhonenum(){return phonenum;}
    public void setPhonenum(String phonenum){this.phonenum=phonenum;}

    @Basic
    @Column(name="time")
    public Date getTime(){return time;}
    public void setTime(Date time){this.time=time;}

    @Basic
    @Column(name="company")
    public String getCompany(){return company;}
    public void setCompany(String company){this.company=company;}

}
