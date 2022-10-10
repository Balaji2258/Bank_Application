package com.demo.sept12.servlets;

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

/**
 * Servlet implementation class LoginAdmin
 */
@WebServlet("/LoginAdmin")
public class LoginAdmin extends HttpServlet {
	private static final long serialVersionUID = 1L;
   
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			response.setContentType("text/html");
			PrintWriter out = response.getWriter();

			Connection con = Util.getConnection();
			Statement stmt = con.createStatement();
			
			String admin = request.getParameter("aid");
			String pass = request.getParameter("pwd");
			
			System.out.println(admin);
			System.out.println(pass);
			
			String sql = "select * from admins where admin_id = '" + admin + "' and admin_pass = '" + pass + "';";
			ResultSet rs = stmt.executeQuery(sql);
			
			if(rs.next()) {
				HttpSession session = request.getSession();
				session.setAttribute("adminId", admin);
				response.sendRedirect("AdminHome.jsp");
			}
			else {
				out.println("<center style='position: fixed'><font color = 'red'; weight = bolder;>Invalid Credentials!</font></center>");
				RequestDispatcher rd = request.getRequestDispatcher("LoginAdmin.html");
				rd.forward(request, response);
			}
			stmt.close();
			con.close();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
