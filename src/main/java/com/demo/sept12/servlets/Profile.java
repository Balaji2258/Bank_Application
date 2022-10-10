package com.demo.sept12.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.demo.sept12.connection.Util;

@WebServlet("/Profile")
public class Profile extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		
		try {
			HttpSession session = request.getSession();
			
			if(session.getAttribute("userName") != null) {
				String userName = (String) session.getAttribute("userName");
				String sql = "select * from user where user_name = '" + userName + "'";
				Connection con = Util.getConnection();
				Statement stmt = con.createStatement();
				ResultSet rs = stmt.executeQuery(sql);
				if(rs.next()) {
//					String html = """
//							<html>
//							<head>
//							<meta charset="UTF-8">
//							<title>Your Bank - Profile</title>
//							</head>
//							<body>
//								<header>
//									<center><img src="logo.jpg" class="logo" alt="Your Bank"></center>
//									
//									<!-- p align="right">
//										<a href = "Logout">Logout</a>
//									</p-->
//								</header>
//								<h1 align="center">YOUR BANK</h1>
//								<!-- h2 align="center">HOME</h1-->
//								
//								<div class="navg">
//								<nav class="navigation">
//								<ul>
//									<li><a href="Home" class="active">Home</a></li>
//									<li><a href="Profile" class="active">Profile</a></li>
//									<li><a href="Transaction">Transactions</a></li>
//									<li><a href="Cards.html">Cards</a></li>
//									<li><a href="Loans.html">Loans</a></li>
//									<li><a href="Services.html">Services</a></li>
//									<li><a href="Contact.html">Contact Us</a></li>
//									<li><a href="Logout">Logout</a></li>
//								</ul>
//								</nav>
//								</div>
//							</body>
//							</html>
//							""";
					
					out.println("<html>"
							+ " <head>"
							+ "	<meta charset=\"UTF-8\">"
							+ "	<title>Your Bank - Profile</title>"
							+ " <link rel='stylesheet' href='style.css'> "
							+ " <style type = 'text/css'>"
							+ " .tab {"
							+ "	background: beige;"
							+ "	margin-left: auto;"
							+ "	margin-right: auto;"
							+ "	border: 1px;"
							+ "	border-color: aqua;"
							+ "}"
							+ " </style>"
							+ "	</head>"
							+ "	<body>"
							+ "	<header>"
							+ "	<center><img src=\"logo.jpg\" class=\"logo\" alt=\"Your Bank\"></center>"
							+ "	</header>"
							+ "	<h1 align=\"center\">YOUR BANK</h1>\n"
							+ "								<!-- h2 align=\"center\">HOME</h1-->\n"
							+ "								<div class=\"navg\">\n"
							+ "								<nav class=\"navigation\">\n"
							+ "								<ul>\n"
							+ "									<li><a href=\"Home\">Home</a></li>\n"
							+ "									<li><a href=\"Profile\" class=\"active\">Profile</a></li>\n"
							+ "									<li><a href=\"Transaction\">Transactions</a></li>\n"
							+ "									<li><a href=\"Cards.html\">Cards</a></li>\n"
							+ "									<li><a href=\"Loans.html\">Loans</a></li>\n"
							+ "									<li><a href=\"Services.html\">Services</a></li>\n"
							+ "									<li><a href=\"Contact.html\">Contact Us</a></li>\n"
							+ "									<li><a href=\"Logout\">Logout</a></li>\n"
							+ "								</ul>\n"
							+ "								</nav>\n"
							+ "								</div>\n"
							+ "							</body>\n"
							+ "							</html>");
					out.println("<table id = \"tab\">"
						+ "<tr><td>Account No</td><td>" + rs.getInt("acc_no") + "</td></tr>" 
						+ "<tr><td>User Name</td><td>" + rs.getString("user_name") + "</td></tr>" 
						+ "<tr><td>Account Type</td><td>" + rs.getString("acc_type").toUpperCase() + "</td></tr>"
						+ "<tr><td>Account Balance</td><td>" + rs.getDouble("balance") + "</td></tr>"
						+ "<tr><td>Address</td><td>" + rs.getString("address") + "</td></tr>"
						+ "<tr><td>Phone No.</td><td>" + rs.getLong("phone") + "</td></tr>"
						+ "<tr><td>Email ID</td><td>" + rs.getString("email") + "</td></tr></table>");
				}
				con.close();
			}
			else {
				response.sendRedirect("Login");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
