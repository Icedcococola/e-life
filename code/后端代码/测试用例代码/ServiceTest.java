package com.example.demo.Entity;

import junit.framework.TestCase;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import static org.junit.Assert.*;

public class ServiceTest extends TestCase {
        Service testservice;
    @Before
    public void setUp() throws Exception {
        super.setUp();
        testservice=new Service();
        testservice.setServiceid(1);
        testservice.setPhonenum("123");
        testservice.setType("type");
    }

    @After
    public void tearDown() throws Exception {
        super.tearDown();
    }

    @Test
    public void testgetServiceid() {
        assertEquals(1,testservice.getServiceid());
    }

    @Test
    public void testsetServiceid() {
        testservice.setServiceid(2);
        assertEquals(2,testservice.getServiceid());
    }

    @Test
    public void testgetType() {
        assertEquals("type",testservice.getType());
    }

    @Test
    public void testsetType() {
        testservice.setType("22");
        assertEquals("22",testservice.getType());
    }

    @Test
    public void testgetPhonenum() {
        assertEquals("123",testservice.getPhonenum());
    }

    @Test
    public void testsetPhonenum() {
        testservice.setPhonenum("222");
        assertEquals("222",testservice.getPhonenum());
    }
}