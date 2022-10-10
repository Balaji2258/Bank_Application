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

@WebServlet("/Home")
public class Home extends HttpServlet {
	private static final long serialVersionUID = 1L;
   
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			response.setContentType("text/html");
			
			PrintWriter out = response.getWriter();
			
			HttpSession session = request.getSession();
			String userName = (String) session.getAttribute("userName");
			
			if(session.getAttribute("userName") == null) {
				out.println("<center><font color = 'red'; weight = bolder;>Please login to continue!</font></center>");
				response.sendRedirect("LoginUser.html");
			}
			else {
				out.println("<center><font color = 'green'; weight = bolder;>Login Successful! Welcome " + userName + "</font></center>");
				RequestDispatcher rd = request.getRequestDispatcher("Home.html");
				rd.include(request, response);
//				response.sendRedirect("Home.html");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
