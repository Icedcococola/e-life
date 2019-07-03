package com.example.demo.Entity;

import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;
@Entity
@Table (name="desireduser",schema = "elife")
public class Desireduser {

    private int desiredid;
    private int userid;

    @Basic
    @Column(name="desiredid")
    public int getDesiredid()
    {return desiredid;}

    public void setDesiredid(int desiredid){
        this.desiredid=desiredid;
    }
    @Basic
    @Column(name="userid")
    public int getUserid(){
        return userid;
    }
    public void setUserid(int userid){
        this.userid=userid;
    }
}
