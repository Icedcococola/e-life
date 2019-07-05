package com.example.demo.Entity;

import junit.framework.TestCase;
import org.junit.Test;

import static org.junit.Assert.*;

public class AdministratorTest extends TestCase {

    Administrator testadministrator;
    @Override
    protected void setUp()throws Exception
    {
        super.setUp();
        testadministrator=new Administrator();
        testadministrator.setAdminname("zbx");
        testadministrator.setPassword("123");
        testadministrator.setType("admin");
        testadministrator.setAdminid(1);
    }
    @Override
   protected void tearDown()throws Exception
    {
        super.tearDown();
    }

    @Test
    public  void testgetAdminid()
    {
        assertEquals(1,testadministrator.getAdminid());
    }
    @Test
    public void testsetAdminid()
    {
        testadministrator.setAdminid(2);
        assertEquals(2,testadministrator.getAdminid());
    }

    @Test
    public void testgetAdminname() {
        assertEquals("zbx",testadministrator.getAdminname());
    }

    @Test
    public void testsetAdminname() {
        testadministrator.setAdminname("slc");
        assertEquals("slc",testadministrator.getAdminname());
    }

    @Test
    public void testgetPassword() {
        assertEquals("123",testadministrator.getPassword());
    }

    @Test
    public void testsetPassword() {
        testadministrator.setPassword("22");
        assertEquals("22",testadministrator.getPassword());
    }

    @Test
    public void testgetType() {
        assertEquals("admin",testadministrator.getType());
    }

    @Test
    public void testsetType() {
        testadministrator.setType("12");
        assertEquals("12",testadministrator.getType());
    }
}