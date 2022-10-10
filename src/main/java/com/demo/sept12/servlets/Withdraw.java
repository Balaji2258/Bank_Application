package com.demo.sept12.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Date;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.demo.sept12.connection.Util;

@WebServlet("/Withdraw")
public class Withdraw extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			response.setContentType("text/html");
			
			PrintWriter out = response.getWriter();
			
			HttpSession session = request.getSession();
			String userName = (String) session.getAttribute("userName");
			
			if(userName != null) {
				double amt = Double.parseDouble(request.getParameter("amount"));
				
				Connection con = Util.getConnection();
				Statement stmt = con.createStatement();
				String sql = "select * from user where  user_name = '" + userName + "';";
				ResultSet rs = stmt.executeQuery(sql);
				DateTimeFormatter dtf = DateTimeFormatter.ofPattern("dd-MM-yyyy HH:mm:ss");
				
				if(rs.next()) {
					int accNo = rs.getInt("acc_no");
			       	double bal = rs.getDouble("balance");
			       	String type = rs.getString("acc_type");
			       	if((type.equalsIgnoreCase("savings") && (bal - amt >= 1000)) 
			       			|| (type.equalsIgnoreCase("current") && (bal - amt >= 2500))) {
			       		sql = "update user set balance = " + (bal-amt) + " where acc_no = " + accNo;
			       		stmt.executeUpdate(sql);
			       		sql = "insert into transactions(acc_no, trans_type, trans_amt, trans_date) "
			       				+ "values(" + accNo + ", 'Withdraw', " + amt + ", '" + LocalDateTime.now() + "');";
			       		stmt.executeUpdate(sql);
			       		RequestDispatcher rd = request.getRequestDispatcher("Transaction.html");
						rd.forward(request, response);
		        	} else {
		        		out.println("<center><font color = 'red'; weight = bolder;>Balance goes below minimum! Cannot withdraw!</font></center>");
						RequestDispatcher rd = request.getRequestDispatcher("WithdrawAmt.html");
						rd.include(request, response);
		        	}
		        }
				else {					
					out.println("<center><font color = 'red'; weight = bolder;>Account not found!!</font></center>");
					RequestDispatcher rd = request.getRequestDispatcher("WithdrawAmt.html");
					rd.include(request, response);
				}
				con.close();
			}
			else {
				out.println("<center><font color = 'red'; weight = bolder;>Please login to continue!</font></center>");
				RequestDispatcher rd = request.getRequestDispatcher("LoginUser.html");
				rd.include(request, response);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
