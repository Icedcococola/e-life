package com.example.demo.Entity;

import junit.framework.TestCase;
import org.junit.Test;

import java.text.SimpleDateFormat;
import java.util.Date;

import static org.junit.Assert.*;

public class PaidTest extends TestCase {

    Paid testpaid;

    @Override
    protected  void setUp()throws  Exception{
        super.setUp();
        String times="1999-10-28";
        SimpleDateFormat df=new SimpleDateFormat("yyyy-MM-dd");
        Date time=df.parse(times);
        testpaid=new Paid();
        testpaid.setUserid(123);
        testpaid.setPrice(20);
        testpaid.setType("罚款");
        testpaid.setIspaid(0);
        testpaid.setTime(time);
        testpaid.setPaidid(1);

    }
    @Override
    protected void tearDown() throws  Exception{
        super.tearDown();

    }

    @Test
    public void testgetPaidid()
    {
        assertEquals(1,testpaid.getPaidid());
    }
    @Test
    public void testsetPaidid()
    {
        testpaid.setPaidid(2);
        assertEquals(2,testpaid.getPaidid());
    }
    @Test
    public void testgetUserid() {
        assertEquals(123,testpaid.getUserid());
        System.out.println("test_getUserid()");
    }



    @Test
    public void testgetTime() throws  Exception{
        String times="1999-10-28";
        SimpleDateFormat df=new SimpleDateFormat("yyyy-MM-dd");
        Date time=df.parse(times);
        assertEquals(time,testpaid.getTime());
        System.out.println("test_getTime");
    }


    @Test
    public void testgetPrice() {
        assertEquals(20,testpaid.getPrice());
        System.out.println("test_getPrice");
    }


    @Test
    public void testgetType() {
        assertEquals("罚款",testpaid.getType());
        System.out.println("test_getType()");
    }



    @Test
    public void testgetIspaid() {
        assertEquals(0,testpaid.getIspaid());
        System.out.println("test_getIspaid()");
    }

    @Test
    public void testsetUserid(){
            testpaid.setUserid(999);
            assertEquals(999,testpaid.getUserid());
    }
    @Test
    public void testsetType(){
        testpaid.setType("物业管理费");
        assertEquals("物业管理费",testpaid.getType());
    }

    @Test
    public void testsetPrice(){
        testpaid.setPrice(998);
        assertEquals(998,testpaid.getPrice());
    }

    @Test
    public void testsetTime() throws Exception{
        String times="1998-11-20";
        SimpleDateFormat df=new SimpleDateFormat("yyyy-MM-dd");
        Date time=df.parse(times);
        Date time2=df.parse(times);
        testpaid.setTime(time);
        assertEquals(time2,testpaid.getTime());
    }
    @Test
    public void testsetIspaid()
    {
        testpaid.setIspaid(1);
        assertEquals(1,testpaid.getIspaid());
    }
}