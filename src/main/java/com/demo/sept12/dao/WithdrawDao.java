package com.demo.sept12.dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import com.demo.sept12.connection.Util;

public class WithdrawDao {
	
	public void withdraw(String userName, String pass, double amt) throws SQLException {
		Connection con = Util.getConnection();
		Statement stmt = con.createStatement();
		
		String sql = "select * from user where  user_name = '" + userName + "' and password = '" + pass + "';";
		ResultSet rs = stmt.executeQuery(sql);
	}

}
