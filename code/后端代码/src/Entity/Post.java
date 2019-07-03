package com.example.demo.Entity;


import javax.persistence.*;
import java.util.Date;

@Entity
@Table (name="post",schema = "elife")
public class Post {


    private int postid;
    private Date posttime;
    private String poster;
    private String title;
    private String article;


    @Basic
    @Column(name = "posttime")
    public Date getPosttime() {
        return posttime;
    }

    public void setPosttime(Date posttime) {
        this.posttime =posttime;
    }

    @Id
    @Column(name = "postid")
    public int getPostid() {
        return postid;
    }

    public void setPostid(int postid) {
        this.postid =postid;
    }

    @Basic
    @Column(name = "poster")
    public String getPoster() { return poster; }

    public void setPoster(String poster) {
        this.poster = poster;
    }

    @Basic
    @Column(name = "article")
    public String getArticle() { return article; }

    public void setArticle(String article) {
        this.article= article;
    }

    @Basic
    @Column(name = "title")
    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

}
