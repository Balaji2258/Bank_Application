package com.demo.sept12.test;
import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertTrue;
import java.sql.SQLException;

import org.junit.jupiter.api.*;

import com.demo.sept12.dao.UserDao;

public class UserExistsTest {
	
	@Test
	public void checkUserExistsTest() throws SQLException {
		assertTrue(UserDao.checkUserExists("Balaji1"));
	}
	
	@Test
	public void checkUserDoesNotExistsTest() throws SQLException {
		assertFalse(UserDao.checkUserExists("Balaji"));
	}
	
}
