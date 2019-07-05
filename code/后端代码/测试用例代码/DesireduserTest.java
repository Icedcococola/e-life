package com.example.demo.Entity;

import junit.framework.TestCase;
import org.junit.Test;

import static org.junit.Assert.*;

public class DesireduserTest extends TestCase {


    Desireduser testdesireduser;
    @Override
    protected void setUp()throws Exception
    {
        super.setUp();
        testdesireduser=new Desireduser();
       testdesireduser.setDesiredid(1);
        testdesireduser.setUserid(123);
        testdesireduser.setDesireduserid(1);
    }

    @Override
    protected void tearDown() throws Exception{
        super.tearDown();
    }

    @Test
    public void testgetDesireduserid()
    {
        assertEquals(1,testdesireduser.getDesireduserid());
    }
    @Test
    public void testsetDesireduserid(){
        testdesireduser.setDesireduserid(2);
        assertEquals(2,testdesireduser.getDesireduserid());
    }
    @Test
    public void testgetDesiredid() {
        assertEquals(1,testdesireduser.getDesiredid());
    }

    @Test
    public void testsetDesiredid() {
        testdesireduser.setDesiredid(2);
        assertEquals(2,testdesireduser.getDesiredid());
    }

    @Test
    public void testgetUserid() {
        assertEquals(123,testdesireduser.getUserid());
    }

    @Test
    public void testsetUserid() {
        testdesireduser.setUserid(321);
        assertEquals(321,testdesireduser.getUserid());
    }
}