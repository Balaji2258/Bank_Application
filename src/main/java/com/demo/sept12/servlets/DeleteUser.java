package com.demo.sept12.servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.demo.sept12.dao.UserDao;

@WebServlet("/DeleteUser")
public class DeleteUser extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int userAccNo = Integer.parseInt(request.getParameter("accNo"));  
		UserDao.deleteUser(userAccNo);  
		response.sendRedirect("ViewUsers.jsp"); 
	}
}
