package com.example.demo.Entity;

import junit.framework.TestCase;
import org.junit.Test;

import java.text.SimpleDateFormat;
import java.util.Date;

import static org.junit.Assert.*;

public class MessageTest extends TestCase {

    Message testmessage;

    @Override
    protected  void setUp() throws Exception{
        super.setUp();
        String times="1998-11-20";
        SimpleDateFormat df=new SimpleDateFormat("yyyy-MM-dd");
        Date time=df.parse(times);
        testmessage=new Message();
        testmessage.setTime(time);
        testmessage.setDetail("detail");
        testmessage.setTitle("title");
        testmessage.setType("type");
        testmessage.setMessageid(1);

    }
    @Override
    protected void tearDown()throws Exception{
        super.tearDown();
    }

    @Test
    public void testgetMessageid()
    {assertEquals(1,testmessage.getMessageid());}

    @Test
    public void testgstMessageid()
    {
        testmessage.setMessageid(2);
        assertEquals(2,testmessage.getMessageid());
    }
    @Test
    public void testgetDetail() {
        assertEquals("detail",testmessage.getDetail());
    }

    @Test
    public void testsetDetail() {
        testmessage.setDetail("D");
        assertEquals("D",testmessage.getDetail());
    }

    @Test
    public void testgetTime() throws Exception{
        String times="1998-11-20";
        SimpleDateFormat df=new SimpleDateFormat("yyyy-MM-dd");
        Date time=df.parse(times);
        assertEquals(time,testmessage.getTime());
    }

    @Test
    public void testsetTime() throws  Exception{
        String times="1998-10-28";
        SimpleDateFormat df=new SimpleDateFormat("yyyy-MM-dd");
        Date time=df.parse(times);
        Date time2=df.parse(times);
        testmessage.setTime(time);
        assertEquals(time2,testmessage.getTime());
    }

    @Test
    public void testgetType() {
        assertEquals("type",testmessage.getType());
    }

    @Test
    public void testsetType() {
        testmessage.setType("T");
        assertEquals("T",testmessage.getType());
    }

    @Test
    public void testgetTitle() {
        assertEquals("title",testmessage.getTitle());
    }

    @Test
    public void testsetTitle() {
        testmessage.setTitle("TT");
        assertEquals("TT",testmessage.getTitle());
    }
}