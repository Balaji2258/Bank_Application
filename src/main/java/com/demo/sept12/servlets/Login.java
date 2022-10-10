package com.demo.sept12.servlets;

import java.awt.Color;
import java.awt.Font;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
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
import com.demo.sept12.dao.UserDao;
import com.demo.sept12.model.User;

@WebServlet("/Login")
public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			response.setContentType("text/html");
			
			PrintWriter out = response.getWriter();
			String user = request.getParameter("uname");
			String pass = request.getParameter("pwd");
			
			Connection con = Util.getConnection();
			Statement stmt = con.createStatement();
			String sql = "select * from user where user_name = '" + user + "' and password = '" + pass + "';";
			ResultSet rs = stmt.executeQuery(sql);
			
//			HttpSession session = request.getSession();
			
			if(rs.next()) {
				HttpSession session = request.getSession();
				session.setAttribute("userName", user);
//				out.println("<center><font color = 'green'; weight = bolder;>Login Success!</font></center>");
//				RequestDispatcher rd = request.getRequestDispatcher("Home.jsp"); //redirecting to required page
//				rd.forward(request, response);
				response.sendRedirect("Home.jsp");
			}
			else {
				RequestDispatcher rd = request.getRequestDispatcher("LoginUser.html");
				rd.include(request, response);
				out.println("<center><font color = 'red'; weight = bolder;>Invalid Credentials!</font></center>");
			}
			stmt.close();
			con.close();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
