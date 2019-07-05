package com.example.demo.Entity;

import junit.framework.TestCase;
import org.junit.Test;

import java.text.SimpleDateFormat;
import java.util.Date;

import static org.junit.Assert.*;

public class PostTest extends TestCase {

    Post testpost;
    @Override
    protected  void setUp()throws Exception{
        super.setUp();
        String times="1999-10-28";
        SimpleDateFormat df=new SimpleDateFormat("yyyy-MM-dd");
        Date time=df.parse(times);
        testpost=new Post();
        testpost.setPosterid(123);
        testpost.setPoster("zbx");
        testpost.setTitle("haha");
        testpost.setPosttime(time);
        testpost.setArticle("wow");
        testpost.setPostid(1);
    }
    @Override
    protected  void tearDown()throws Exception
    { super.tearDown();}

    @Test
    public void testgetPostid()
    {
        assertEquals(1,testpost.getPostid());
    }
    @Test
    public void testsetPostid()
    {
        testpost.setPostid(2);
        assertEquals(2,testpost.getPostid());
    }
    @Test
    public void testgetPosttime()throws Exception {
        String times="1999-10-28";
        SimpleDateFormat df=new SimpleDateFormat("yyyy-MM-dd");
        Date time=df.parse(times);
        assertEquals(time,testpost.getPosttime());
    }

    @Test
    public void testsetPosttime() throws Exception{
        String times="1999-11-20";
        SimpleDateFormat df=new SimpleDateFormat("yyyy-MM-dd");
        Date time=df.parse(times);
        Date time2=df.parse(times);
        testpost.setPosttime(time);
        assertEquals(time2,testpost.getPosttime());
    }

    @Test
    public void testgetPoster() {
        assertEquals("zbx",testpost.getPoster());
    }

    @Test
    public void testsetPoster() {
        testpost.setPoster("slc");
        assertEquals("slc",testpost.getPoster());
    }

    @Test
    public void testgetArticle() {
        assertEquals("wow",testpost.getArticle() );
    }

    @Test
    public void testsetArticle() {
        testpost.setArticle("gg");
        assertEquals("gg",testpost.getArticle());
    }

    @Test
    public void testgetTitle() {
        assertEquals("haha",testpost.getTitle());
    }

    @Test
    public void testsetTitle() {
        testpost.setTitle("666");
        assertEquals("666",testpost.getTitle());
    }

    @Test
    public void testgetPosterid() {
        assertEquals(123,testpost.getPosterid());
    }

    @Test
    public void testsetPosterid() {
        testpost.setPosterid(3);
        assertEquals(3,testpost.getPosterid());
    }
}