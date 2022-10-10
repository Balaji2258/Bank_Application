package com.demo.sept12.test;

import static org.junit.jupiter.api.Assertions.assertEquals;

import java.sql.SQLException;

import org.junit.jupiter.api.Test;

import com.demo.sept12.dao.UserDao;

public class UserTransferTest {

	@Test
	public void transferTest() throws SQLException {
		assertEquals("success", 
				UserDao.transfer("Balaji1", "balaji@123", 500.0, 882446237));
	}
	
	@Test
	public void transferAccountTest() throws SQLException {
		assertEquals("<center><font color = 'red'; weight = bolder;>Cannot transfer to self! Please enter a valid recipient account number..</font></center>", 
				UserDao.transfer("Balaji1", "balaji@123", 500.0, 342649602));
	}
	
	@Test
	public void transferBalanceTest() throws SQLException {
		assertEquals("<center><font color = 'red'; weight = bolder;>Balance goes below minimum! Cannot transfer!</font></center>", 
				UserDao.transfer("Balaji1", "balaji@123", 50000.0, 882446237));
	}
	
	@Test
	public void transferPasswordTest() throws SQLException {
		assertEquals("<center><font color = 'red'; weight = bolder;>Invalid Password!!</font></center>", 
				UserDao.transfer("Balaji1", "balaji1@123", 50000.0, 882446237));
	}
	
}
