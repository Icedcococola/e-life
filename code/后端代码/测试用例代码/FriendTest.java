package com.example.demo.Entity;

import junit.framework.TestCase;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import static org.junit.Assert.*;

public class FriendTest extends TestCase {
    Friend testfriend;
    @Before
    public void setUp() throws Exception {
        super.setUp();
        testfriend=new Friend();
        testfriend.setFriendid(1);
        testfriend.setUserid1(2);
        testfriend.setUserid2(3);
    }

    @After
    public void tearDown() throws Exception {
        super.tearDown();
    }

    @Test
    public void testgetFriendid() {
        assertEquals(1,testfriend.getFriendid());
    }

    @Test
    public void testsetFriendid() {
        testfriend.setFriendid(2);
        assertEquals(2,testfriend.getFriendid());
    }

    @Test
    public void testgetUserid1() {
        assertEquals(2,testfriend.getUserid1());
    }

    @Test
    public void testsetUserid1() {
        testfriend.setUserid1(22);
        assertEquals(22,testfriend.getUserid1());
    }

    @Test
    public void testgetUserid2() {
        assertEquals(3,testfriend.getUserid2());
    }

    @Test
    public void testsetUserid2() {
        testfriend.setUserid2(33);
        assertEquals(33,testfriend.getUserid2());
    }
}