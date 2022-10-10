package com.demo.sept12.dao;

import java.sql.Statement;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.SQLIntegrityConstraintViolationException;

import com.demo.sept12.connection.Util;
import com.demo.sept12.model.User;

public class UserDao {
	Scanner sc = new Scanner(System.in);
	int accNo;
    String name, address;
    double bal;
	
	public static int saveUser(User user) {
		Statement stmt = null;
		String sql = null;
		try {
			sql = "insert into user(acc_no, full_name, user_name, password, re_pw, acc_type, balance, address, phone, email)"
					+ " values(" + user.getAccNo()
					+ ", '" + user.getFullName()
					+ "', '" + user.getUserName() 
					+ "', '" + user.getPassword() 
					+ "', '" + user.getRePassword()
					+ "', '" + user.getAccType()
					+ "', " + user.getAmount() 
					+ ", '" + user.getAddress() 
					+ "', " + user.getPhone() 
					+ ", '" + user.getEmail() + "');";
			Connection con = Util.getConnection();
			stmt = con.createStatement();
			int ret = stmt.executeUpdate(sql);
			con.close();
			return ret;
		} catch (SQLException e) {
			e.printStackTrace();
			return 0;
		}
	}
	
	public static int updateDetails(User user) {
		Statement stmt = null;
		String sql = null;
		try {
			sql = "update user set full_name = '" + user.getFullName()
						+ "', address = '" + user.getAddress() 
						+ "', phone = " + user.getPhone() 
						+ ", email = '" + user.getEmail() 
						+"' where acc_no = " + user.getAccNo() + ";";
			stmt = Util.getConnection().createStatement();
			return stmt.executeUpdate(sql);
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
	}
	
	public static void deleteUser(int accNo) {
		Statement stmt = null;
		String sql = null;
		try {
            sql = "delete from user where acc_no = " + accNo + ";";
            stmt = Util.getConnection().createStatement();
			stmt.executeUpdate(sql);
        } catch (Exception e) {
            e.printStackTrace();
        }
	}
	
//	public List<User> getAllUsers() {
//		List<User> userList = new ArrayList<User>();
//		Statement stmt = null;
//		String sql = null;
//        try {
//            sql = "select * from user;";
//            stmt = Util.getConnection().createStatement();
//            ResultSet rs = stmt.executeQuery(sql);
//
//            while(rs.next()) {
//                User user = new User();
//                user.setAccNo(rs.getInt(1));
//                user.setUserName(rs.getString(2));
//                user.setAccType(rs.getString(5));
//                user.setAmount(rs.getDouble(6));
//                user.setAddress(rs.getString(7));
//                user.setPhone(rs.getLong(8));
//                user.setEmail(rs.getString(9));
//                userList.add(user);
//            }
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//        return userList;
//	}
	
	public static double getBalance(String userName) throws SQLException {
		Connection con = Util.getConnection();
		Statement stmt = con.createStatement();
		
		double balance = 0;
		String sql = "select * from user where user_name = '" + userName + "';";
		ResultSet rs = stmt.executeQuery(sql);
		if(rs.next()) {
			balance = rs.getDouble("balance");
		}
		stmt.close();
		con.close();
		return balance;
	}
	
	public static int getAccNo(String userName) throws SQLException {
		Connection con = Util.getConnection();
		Statement stmt = con.createStatement();
		
		int accNo = 0;
		String sql = "select * from user where user_name = '" + userName + "';";
		ResultSet rs = stmt.executeQuery(sql);
		if(rs.next()) {
			accNo = rs.getInt("acc_no");
		}
		stmt.close();
		con.close();
		return accNo;
	}
	
	public static String withDraw(String userName, String pass, double amt) throws SQLException {
		Connection con = Util.getConnection();
		Statement stmt = con.createStatement();
		String ret = null;
		
		String sql = "select * from user where  user_name = '" + userName + "' and password = '" + pass + "';";
		ResultSet rs = stmt.executeQuery(sql);
		
		if(rs.next()) {
			int accNo = rs.getInt("acc_no");
	       	double bal = rs.getDouble("balance");
	       	String type = rs.getString("acc_type");
	       	if((type.equalsIgnoreCase("savings") && (bal - amt >= 1000)) 
	       			|| (type.equalsIgnoreCase("current") && (bal - amt >= 2500))) {
	       		sql = "update user set balance = " + (bal-amt) + " where acc_no = " + accNo;
	       		int status = stmt.executeUpdate(sql);
	       		sql = "insert into transactions(acc_no, trans_type, trans_amt, trans_date) "
	       				+ "values(" + accNo + ", 'Withdraw', " + amt + ", '" + LocalDateTime.now() + "');";
	       		status &= stmt.executeUpdate(sql);
	       		ret = "success";
	    	} else {
	    		ret = "<center><font color = 'red'; weight = bolder;>Balance goes below minimum! Cannot withdraw!</font></center>";
	    	}
	    }
		else {					
			ret = "<center><font color = 'red'; weight = bolder;>Invalid Password!!</font></center>";
		}
		stmt.close();
		con.close();
		return ret;
	}
	
	public static String deposit(String userName, String pass, double amt) throws SQLException {
		Connection con = Util.getConnection();
		Statement stmt = con.createStatement();
		String ret = null;
		
		String sql = "select * from user where  user_name = '" + userName + "' and password = '" + pass + "';";
		ResultSet rs = stmt.executeQuery(sql);
		
		if(rs.next()) {
			int accNo = rs.getInt("acc_no");
	       	double bal = rs.getDouble("balance");
	       	
	       	sql = "update user set balance = " + (bal+amt) + " where acc_no = " + accNo;
	       	int status = stmt.executeUpdate(sql);
	   		sql = "insert into transactions(acc_no, trans_type, trans_amt, trans_date) "
	   				+ "values(" + accNo + ", 'Deposit', " + amt + ", '" + LocalDateTime.now() + "');";
	   		status &= stmt.executeUpdate(sql);
	   		ret = "success";
	    }
		else {					
			ret = "<center><font color = 'red'; weight = bolder;>Invalid Password!!</font></center>";
		}
		stmt.close();
		con.close();
		return ret;
	}
	
	public static String transfer(String userName, String pass, double amt, int recAccNo) throws SQLException {
		Connection con = Util.getConnection();
		Statement stmt = con.createStatement();
		String ret = null;
		
		String sql = "select * from user where  user_name = '" + userName + "' and password = '" + pass + "';";
		ResultSet rs = stmt.executeQuery(sql);
		
		if(rs.next()) {
			int accNo = rs.getInt("acc_no");
			
			if(accNo == recAccNo) {
				ret = "<center><font color = 'red'; weight = bolder;>Cannot transfer to self! Please enter a valid recipient account number..</font></center>";
			}
			else{
		       	double bal = rs.getDouble("balance");
		       	String type = rs.getString("acc_type");
				String sql1 = "select * from user where acc_no = " + recAccNo;
				ResultSet rs1 = stmt.executeQuery(sql1);
				
				if(rs1.next()) {
			       	double recBal = rs1.getDouble("balance");
			       	if((type.equalsIgnoreCase("savings") && (bal - amt >= 1000)) 
			       			|| (type.equalsIgnoreCase("current") && (bal - amt >= 2500))) {
			       		stmt = Util.getConnection().createStatement();
			       		sql = "update user set balance = " + (bal-amt) + " where acc_no = " + accNo;
			       		stmt.executeUpdate(sql);
			       		sql = "update user set balance = " + (recBal+amt) + " where acc_no = " + recAccNo;
			       		stmt.executeUpdate(sql);
			       		sql = "insert into transactions(acc_no, trans_type, trans_amt, trans_date) "
			       				+ "values(" + accNo + ", 'Withdraw', " + amt + ", '" + LocalDateTime.now() + "');";
			       		stmt.executeUpdate(sql);
		//	       		stmt.executeUpdate(sql1);
			       		sql = "insert into transactions(acc_no, trans_type, trans_amt, trans_date) "
			       				+ "values(" + recAccNo + ", 'Deposit', " + amt + ", '" + LocalDateTime.now() + "');";
			       		stmt.executeUpdate(sql);
//			       		RequestDispatcher rd = request.getRequestDispatcher("Home.jsp");
//						rd.forward(request, response);
			       		ret = "success";
		        	} else {
		        		ret = "<center><font color = 'red'; weight = bolder;>Balance goes below minimum! Cannot transfer!</font></center>";
		        	}
				}
				else {
					ret = "<center><font color = 'red'; weight = bolder;>Recipient account not found!!</font></center>";
				}
			}
	    }
		else {
			ret = "<center><font color = 'red'; weight = bolder;>Invalid Password!!</font></center>";
		}
		stmt.close();
		con.close();
		return ret;
	}
	
	public static boolean checkUserExists(String userName) throws SQLException {
		boolean ret = false;
		Connection con = Util.getConnection();
		Statement stmt = con.createStatement();
		
		String sql = "select * from user where user_name = '" + userName + "';";
		ResultSet rs = stmt.executeQuery(sql);
		if(rs.next())
			ret = true;
		
		return ret;
	}
	
	public static boolean checkPhoneExists(long phone) throws SQLException {
		boolean ret = false;
		Connection con = Util.getConnection();
		Statement stmt = con.createStatement();
		
		String sql = "select * from user where phone = " + phone;
		ResultSet rs = stmt.executeQuery(sql);
		if(rs.next())
			ret = true;
		
		return ret;
	}
	
	public static boolean checkEmailExists(String email) throws SQLException {
		boolean ret = false;
		Connection con = Util.getConnection();
		Statement stmt = con.createStatement();
		
		String sql = "select * from user where email = '" + email + "';";
		ResultSet rs = stmt.executeQuery(sql);
		if(rs.next())
			ret = true;
		
		return ret;
	}
}
