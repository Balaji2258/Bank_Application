package com.demo.sept12.servlets;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/Transaction")
public class Transaction extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {	
			response.setContentType("text/html");
			PrintWriter out = response.getWriter();
			
			HttpSession session = request.getSession();
			if(session.getAttribute("userName") == null) {
				out.println("<center><font color = 'red'; weight = bolder;>Please login to continue!</font></center>");
				RequestDispatcher rd = request.getRequestDispatcher("LoginUser.html");
				rd.include(request, response);
//				response.sendRedirect("LoginUser.html");
			}
			else {
				response.sendRedirect("Transaction.html");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}



/*
 * 
 * 
package com.demo.sept12.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.demo.sept12.connection.Util;

@WebServlet("/Transaction")
public class Transaction extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {	
			response.setContentType("text/html");
			PrintWriter out = response.getWriter();
			
			HttpSession session = request.getSession();
			String userName = (String) session.getAttribute("user_name");
			
			String sql = "select acc_no from user where user_name = " + userName;
			Statement st = Util.getConnection().createStatement();
			ResultSet rs = st.executeQuery(sql);
			
//			if(userName == null) {
			if(rs.next()) {
				response.sendRedirect("Transaction.html");
			}
			else {
				out.println("<center><font color = 'red'; weight = bolder;>Please login to continue!</font></center>");
//			RequestDispatcher rd = request.getRequestDispatcher("Login.html");
//			rd.forward(request, response);
				response.sendRedirect("Login.html");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}


*/



