package com.example.demo.Entity;

import junit.framework.TestCase;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import java.text.SimpleDateFormat;
import java.util.Date;

import static org.junit.Assert.*;

public class CommentsTest extends TestCase {
    Comments testcomments;
    @Override
    protected void setUp() throws Exception
    {
        super.setUp();
        String times="1998-11-20";
        SimpleDateFormat df=new SimpleDateFormat("yyyy-MM-dd");
        Date time=df.parse(times);
        testcomments=new Comments();
        testcomments.setMessage("123");
        testcomments.setPostid(1);
        testcomments.setTime(time);
        testcomments.setUserid(1);
        testcomments.setCommentsid(1);
    }

    @Override
    protected void tearDown()throws Exception
    {
        super.tearDown();
    }

    @Test
    public void testgetCommentsid()
    {
        assertEquals(1,testcomments.getCommentsid());
    }
        @Test
        public void testsetCommentsid()
        {
            testcomments.setCommentsid(2);
            assertEquals(2,testcomments.getCommentsid());
        }
    @Test
    public void testgetUserid() {
        assertEquals(1,testcomments.getUserid());
    }

    @Test
    public void testsetUserid() {
        testcomments.setUserid(2);
        assertEquals(2,testcomments.getUserid());
    }

    @Test
    public void testgetPostid() {
        assertEquals(1,testcomments.getPostid());
    }

    @Test
    public void testsetPostid() {
        testcomments.setPostid(321);
        assertEquals(321,testcomments.getPostid());
    }

    @Test
    public void testgetMessage() {
        assertEquals("123",testcomments.getMessage());
    }

    @Test
    public void testsetMessage() {
        testcomments.setMessage("test");
        assertEquals("test",testcomments.getMessage());
    }

    @Test
    public void testgetTime() throws Exception{
        String times="1998-11-20";
        SimpleDateFormat df=new SimpleDateFormat("yyyy-MM-dd");
        Date time=df.parse(times);
        assertEquals(time,testcomments.getTime());
    }

    @Test
    public void testsetTime() throws Exception{
        String times="1999-02-25";
        SimpleDateFormat df=new SimpleDateFormat("yyyy-MM-dd");
        Date time1=df.parse(times);
        Date time2=df.parse(times);
        testcomments.setTime(time1);
        assertEquals(time2,testcomments.getTime());
    }
}