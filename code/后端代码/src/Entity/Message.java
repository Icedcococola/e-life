package com.example.demo.Entity;

import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name="message" ,schema = "elife")
public class Message {
        private int messageid;
    private String detail;
    private String type;
    private Date time;
    private String title;

    @Id
    @Column(name="messageid")
    public int getMessageid(){return messageid;}
    public void setMessageid(int messageid){this.messageid=messageid;}

    @Basic
    @Column(name="detail")
    public String getDetail(){return detail;}
    public void setDetail(String detail){this.detail=detail;}

    @Basic
    @Column(name="time")
    public Date getTime(){return time;}
    public void setTime(Date time){this.time=time;}

    @Basic
    @Column(name="type")
    public String getType(){return type;}
    public void setType(String type){this.type=type;}

    @Basic
    @Column(name="title")
    public String getTitle(){return title;}
    public void setTitle(String title){this.title=title;}

}
