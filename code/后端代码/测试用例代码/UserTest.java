package com.example.demo.Entity;

import junit.framework.TestCase;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import static org.junit.Assert.*;

public class UserTest extends TestCase {
    User testuser;
    @Before
    public void setUp() throws Exception {
        super.setUp();
        testuser=new User();
        testuser.setUserid(1);
        testuser.setCommunity("community");
        testuser.setEmail("123");
        testuser.setPassword("pw");
        testuser.setPhonenum("123");
        testuser.setRealname("zbx");
        testuser.setUsername("slc");
    }

    @After
    public void tearDown() throws Exception {
        super.tearDown();
    }

    @Test
    public void testgetUserid() {
        assertEquals(1,testuser.getUserid());
    }

    @Test
    public void testsetUserid() {
        testuser.setUserid(2);
        assertEquals(2,testuser.getUserid());
    }

    @Test
    public void testgetUsername() {
        assertEquals("slc",testuser.getUsername());
    }

    @Test
    public void testsetUsername() {
        testuser.setUsername("zbx");
        assertEquals("zbx",testuser.getUsername());
    }

    @Test
    public void testgetPassword() {
        assertEquals("pw",testuser.getPassword());
    }

    @Test
    public void testsetPassword() {
        testuser.setPassword("1");
        assertEquals("1",testuser.getPassword());
    }

    @Test
    public void testgetEmail() {
        assertEquals("123",testuser.getEmail());
    }

    @Test
    public void testsetEmail() {
        testuser.setEmail("@");
        assertEquals("@",testuser.getEmail());
    }

    @Test
    public void testgetRealname() {
        assertEquals("zbx",testuser.getRealname());
    }

    @Test
    public void testsetRealname() {
        testuser.setRealname("slc");
        assertEquals("slc",testuser.getRealname());
    }

    @Test
    public void testgetPhonenum() {
        assertEquals("123",testuser.getPhonenum());
    }

    @Test
    public void testsetPhonenum() {
        testuser.setPhonenum("23");
        assertEquals("23",testuser.getPhonenum());
    }

    @Test
    public void testgetCommunity() {
        assertEquals("community",testuser.getCommunity());
    }

    @Test
    public void testsetCommunity() {
        testuser.setCommunity("s");
        assertEquals("s",testuser.getCommunity());
    }
}