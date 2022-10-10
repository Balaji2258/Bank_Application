package com.demo.sept12.servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.Statement;
import java.time.LocalDateTime;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.demo.sept12.connection.Util;

@WebServlet("/Approve")
public class Approve extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			Connection con = Util.getConnection();
			Statement stmt = con.createStatement();
			
			int userAccNo = Integer.parseInt(request.getParameter("accNo"));
			String sql = "update services set apply_cheque = 0, approve_date = '" + LocalDateTime.now() + "' where acc_no = " + userAccNo;
			
			int status = stmt.executeUpdate(sql);
			if(status != 0)
				response.sendRedirect("ApproveCheque.jsp");
		}catch (Exception e) {
			e.getMessage();
		}
	}

}
