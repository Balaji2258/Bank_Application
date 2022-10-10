package com.demo.sept12.connection;

import java.sql.Connection;
import java.sql.DriverManager;

public class Util {
	
	public static Connection getConnection() {
		Connection con = null;
		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/Bank", "root", "password");
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return con;
	}
	
//	public static Connection getConnection() {
//		Connection con = null;
//		
//		try {
//			Class.forName("org.h2.Driver");
//			con = DriverManager.getConnection("jdbc:h2:~/test", "sa", "");
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//		
//		return con;
//	}

}
