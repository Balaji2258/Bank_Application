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

@WebServlet("/Transfer")
public class Transfer extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			response.setContentType("text/html");
			
			PrintWriter out = response.getWriter();
			
			HttpSession session = request.getSession();
			String userName = (String) session.getAttribute("userName");
			
			if(userName != null) {
				int recAccNo = Integer.parseInt(request.getParameter("receiver"));
				double amt = Double.parseDouble(request.getParameter("amount"));
				
				Connection con = Util.getConnection();
				Statement stmt = con.createStatement();
				String sql = "select * from user where  user_name = '" + userName + "';";
				ResultSet rs = stmt.executeQuery(sql);
				
				if(rs.next()) {
					int accNo = rs.getInt("acc_no");
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
//				       		stmt.executeUpdate(sql1);
				       		sql = "insert into transactions(acc_no, trans_type, trans_amt, trans_date) "
				       				+ "values(" + recAccNo + ", 'Deposit', " + amt + ", '" + LocalDateTime.now() + "');";
				       		stmt.executeUpdate(sql);
				       		RequestDispatcher rd = request.getRequestDispatcher("Transaction.html");
							rd.forward(request, response);
			        	} else {
			        		out.println("<center><font color = 'red'; weight = bolder;>Balance goes below minimum! Cannot transfer!</font></center>");
							RequestDispatcher rd = request.getRequestDispatcher("TransferAmt.html");
							rd.include(request, response);
			        	}
					}
					else {
						out.println("<center><font color = 'red'; weight = bolder;>Recipient account not found!!</font></center>");
						RequestDispatcher rd = request.getRequestDispatcher("TransferAmt.html");
						rd.include(request, response);
					}
		        }
				else {
					out.println("<center><font color = 'red'; weight = bolder;>Account not found!!</font></center>");
					RequestDispatcher rd = request.getRequestDispatcher("TransferAmt.html");
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
