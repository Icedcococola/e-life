package com.example.demo.Entity;

import junit.framework.TestCase;
import org.junit.Test;

import java.text.SimpleDateFormat;
import java.util.Date;

import static org.junit.Assert.*;

public class ExpressTest extends TestCase {
    Express testexpress;

    @Override
    protected void setUp() throws Exception
    {
        super.setUp();
        String times="1998-11-20";
        SimpleDateFormat df=new SimpleDateFormat("yyyy-MM-dd");
        Date time=df.parse(times);
        testexpress=new Express();
        testexpress.setTime(time);
        testexpress.setPhonenum("num");
        testexpress.setCompany("company");
        testexpress.setPackageid(1);
    }

    @Override
    protected void tearDown() throws Exception
    {
        super.tearDown();
    }

    @Test
    public void testgetPackageid()
    {
        assertEquals(1,testexpress.getPackageid());
    }

    @Test
    public void testsetPackageid()
    {
        testexpress.setPackageid(2);
        assertEquals(2,testexpress.getPackageid());
    }
    @Test
    public void testgetPhonenum() {
        assertEquals("num",testexpress.getPhonenum());
    }

    @Test
    public void testsetPhonenum() {
        testexpress.setPhonenum("N");
        assertEquals("N",testexpress.getPhonenum());
    }

    @Test
    public void testgetTime() throws  Exception{
        String times="1998-11-20";
        SimpleDateFormat df=new SimpleDateFormat("yyyy-MM-dd");
        Date time=df.parse(times);
        assertEquals(time,testexpress.getTime());
    }

    @Test
    public void testsetTime() throws  Exception{
        String times="1998-10-28";
        SimpleDateFormat df=new SimpleDateFormat("yyyy-MM-dd");
        Date time=df.parse(times);
        Date time2=df.parse(times);
        testexpress.setTime(time);
        assertEquals(time2,testexpress.getTime());
    }

    @Test
    public void testgetCompany() {
        assertEquals("company",testexpress.getCompany());
    }

    @Test
    public void testsetCompany() {
        testexpress.setCompany("C");
    assertEquals("C",testexpress.getCompany());
    }
}