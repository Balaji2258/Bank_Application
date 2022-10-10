package com.demo.sept12.test;

import static org.junit.jupiter.api.Assertions.assertEquals;

import java.sql.SQLException;

import org.junit.jupiter.api.Test;

import com.demo.sept12.dao.UserDao;

public class UserDepositTest {

	@Test
	public void depositTest() throws SQLException {
		assertEquals("success", 
				UserDao.deposit("Balaji1", "balaji@123", 500.0));
	}
	
	@Test
	public void depositPasswordTest() throws SQLException {
		assertEquals("<center><font color = 'red'; weight = bolder;>Invalid Password!!</font></center>", 
				UserDao.deposit("Balaji1", "balaji1@123", 50000.0));
	}
	
}
