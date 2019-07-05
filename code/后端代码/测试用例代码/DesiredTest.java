package com.example.demo.Entity;

import junit.framework.TestCase;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import java.text.SimpleDateFormat;
import java.util.Date;

import static org.junit.Assert.*;

public class DesiredTest extends TestCase {
        Desired testdesired;
    @Before
    public void setUp() throws Exception {
        super.setUp();
        String times="1998-11-20";
        SimpleDateFormat df=new SimpleDateFormat("yyyy-MM-dd");
        Date time=df.parse(times);
        testdesired=new Desired();
        testdesired.setGoods("123");
        testdesired.setTime(time);
        testdesired.setDesiredid(1);
    }

    @After
    public void tearDown() throws Exception {
        super.tearDown();
    }

    @Test
    public void testgetDesiredid() {
        assertEquals(1,testdesired.getDesiredid());
    }

    @Test
    public void testsetDesiredid() {
        testdesired.setDesiredid(2);
        assertEquals(2,testdesired.getDesiredid());
    }

    @Test
    public void testgetGoods() {
        assertEquals("123",testdesired.getGoods());
    }

    @Test
    public void testsetGoods() {
        testdesired.setGoods("2");
        assertEquals("2",testdesired.getGoods());
    }

    @Test
    public void testgetTime() throws Exception{
        String times="1998-11-20";
        SimpleDateFormat df=new SimpleDateFormat("yyyy-MM-dd");
        Date time=df.parse(times);
        assertEquals(time,testdesired.getTime());
    }

    @Test
    public void testsetTime() throws  Exception{
        String times="1999-12-20";
        SimpleDateFormat df=new SimpleDateFormat("yyyy-MM-dd");
        Date time=df.parse(times);
        Date time2=df.parse(times);
        testdesired.setTime(time);
        assertEquals(time2,testdesired.getTime());
    }
}