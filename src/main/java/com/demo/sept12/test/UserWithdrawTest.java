package com.demo.sept12.test;

import static org.junit.jupiter.api.Assertions.assertEquals;

import java.sql.SQLException;

import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;

import com.demo.sept12.dao.UserDao;

public class UserWithdrawTest {
	
//	@BeforeAll
//	public static void beforeAll() {
//		System.out.println("\nTest cases for withdraw");
//	}
	
	@Test
	public void withdrawTest() throws SQLException {
		assertEquals("success", 
				UserDao.withDraw("Balaji1", "balaji@123", 500.0));
	}
	
	@Test
	public void withdrawBalanceTest() throws SQLException {
		assertEquals("<center><font color = 'red'; weight = bolder;>Balance goes below minimum! Cannot withdraw!</font></center>", 
				UserDao.withDraw("Balaji1", "balaji@123", 50000.0));
	}
	
	@Test
	public void withdrawPasswordTest() throws SQLException {
		assertEquals("<center><font color = 'red'; weight = bolder;>Invalid Password!!</font></center>", 
				UserDao.withDraw("Balaji1", "balaji1@123", 50000.0));
	}

}
