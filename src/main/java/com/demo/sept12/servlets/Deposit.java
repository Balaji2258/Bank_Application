package com.demo.sept12.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.time.LocalDateTime;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.demo.sept12.connection.Util;

@WebServlet("/Deposit")
public class Deposit extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			response.setContentType("text/html");
			
			PrintWriter out = response.getWriter();
			
			HttpSession session = request.getSession();
			String userName = (String) session.getAttribute("userName"); 
			
			if(userName != null) {
//				int accNo = Integer.parseInt(request.getParameter("acc_no"));
				double amt = Double.parseDouble(request.getParameter("amount"));
				
				Connection con = Util.getConnection();
				Statement stmt = con.createStatement();
				String sql = "select * from user where  user_name = '" + userName + "';";
				ResultSet rs = stmt.executeQuery(sql);
				
				if(rs.next()) {
					int accNo = rs.getInt("acc_no");
					double bal = rs.getDouble("balance");
					sql = "update user set balance = " + (bal+amt) + " where acc_no = " + accNo;
		       		stmt = Util.getConnection().createStatement();
		       		stmt.executeUpdate(sql);
		       		sql = "insert into transactions(acc_no, trans_type, trans_amt, trans_date) "
		       				+ "values(" + accNo + ", 'Deposit', " + amt + ", '" + LocalDateTime.now() + "');";
		       		stmt.executeUpdate(sql);
		       		RequestDispatcher rd = request.getRequestDispatcher("Transaction.html");
					rd.forward(request, response);
		        }
				else {
					out.println("<center><font color = 'red'; weight = bolder;>Account not found!!</font></center>");
					RequestDispatcher rd = request.getRequestDispatcher("DepositAmt.html");
					rd.include(request, response);
				}
				con.close();
			}
			else {
				out.println("<center><font color = 'red'; weight = bolder;>Please login to continue!</font></center>");
				RequestDispatcher rd = request.getRequestDispatcher("LoginUser.html");
				rd.forward(request, response);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
