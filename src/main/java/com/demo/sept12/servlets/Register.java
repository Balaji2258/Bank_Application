package com.demo.sept12.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Random;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.demo.sept12.dao.UserDao;
import com.demo.sept12.exceptions.RegisterValidator;
import com.demo.sept12.model.User;

@WebServlet("/Register")
public class Register extends HttpServlet {
	private static final long serialVersionUID = 1L;
	static Random rand = new Random();
	
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		
		try {
			String fullName = request.getParameter("flname");
			String user = request.getParameter("uname");
			String pass = request.getParameter("pwd");
			String rePass = request.getParameter("rePwd");
			String accType = request.getParameter("accType");
			String bal = request.getParameter("balance");
			
			String address = request.getParameter("address");
			String phone = request.getParameter("phone");
			
			String email = request.getParameter("email");
//			String phoneRegex = "^\\d{10}$";
			
			RegisterValidator.checkUserName(user);
			RegisterValidator.checkPassword(pass);
			RegisterValidator.checkConfirmPassword(rePass);
			RegisterValidator.checkPasswordMatch(pass, rePass);
			RegisterValidator.checkAccType(accType);
			RegisterValidator.checkBalance(bal);
			double balance = Long.parseLong(bal);
			RegisterValidator.checkInsufficientBalance(accType, balance);
			RegisterValidator.checkPhone(phone);
			long ph = Long.parseLong(phone);
			RegisterValidator.checkEmail(email);
			
			int accNo = rand.nextInt(1000000000);
			User u = new User(accNo, fullName, user, pass, rePass, accType, balance, address, ph, email);
			UserDao.saveUser(u);
			
			RequestDispatcher rd = request.getRequestDispatcher("LoginUser.html");
			rd.include(request, response);
			out.println("<br><br><center><font color = 'neon'; weight = bolder;>Registration Successful!<br>Continue to login..</font></center>");
			
//			if(user == null || user == "") {
//				RequestDispatcher rd = request.getRequestDispatcher("RegisterUser.html");
//				rd.include(request, response);
//				out.println("<br><br><center><font color = 'red'; weight = bolder;>UserName cannot be empty!</font></center>");
//			}
//			else 
//			if(pass == null || pass == "") {
//				RequestDispatcher rd = request.getRequestDispatcher("RegisterUser.html");
//				rd.include(request, response);
//				out.println("<br><br><center><font color = 'red'; weight = bolder;>Password cannot be empty!</font></center>");
//			}
//			else if(rePass == null || rePass == "") {
//				RequestDispatcher rd = request.getRequestDispatcher("RegisterUser.html");
//				rd.include(request, response);
//				out.println("<br><br><center><font color = 'red'; weight = bolder;>Re-enter Password cannot be empty!</font></center>");
//			}
//			else if(!pass.equals(rePass)) {
//				RequestDispatcher rd = request.getRequestDispatcher("RegisterUser.html");
//				rd.include(request, response);
//				out.println("<br><br><center><font color = 'red'; weight = bolder;>Passwords do not match!</font></center>");
//			}
//			else if(accType == "" || accType == "#" || accType == null) {
//				RequestDispatcher rd = request.getRequestDispatcher("RegisterUser.html");
//				rd.include(request, response);
//				out.println("<br><br><center><font color = 'red'; weight = bolder;>Please select the account type!</font></center>");
//			}
//			else if(bal == "" || bal == null) {
//				RequestDispatcher rd = request.getRequestDispatcher("RegisterUser.html");
//				rd.include(request, response);
//				out.println("<br><br><center><font color = 'red'; weight = bolder;>Balance cannot be empty!</font></center>");
//			}
//			else if(accType.equalsIgnoreCase("savings") && Double.parseDouble(bal) < 1000.0) {
//				RequestDispatcher rd = request.getRequestDispatcher("RegisterUser.html");
//				rd.include(request, response);
//				out.println("<br><br><center><font color = 'red'; weight = bolder;>Minimum deposit for savings account must be 1000!</font></center>");
//			}
//			else if(accType.equalsIgnoreCase("current") && Double.parseDouble(bal) < 2500.0) {
//				RequestDispatcher rd = request.getRequestDispatcher("RegisterUser.html");
//				rd.include(request, response);
//				out.println("<br><br><center><font color = 'red'; weight = bolder;>Minimum deposit for current account must be 2500!</font></center>");
//			}
//			
//			else if(!phone.matches("^\\d{10}$")) {
//				RequestDispatcher rd = request.getRequestDispatcher("RegisterUser.html");
//				rd.include(request, response);
//				out.println("<br><br><center><font color = 'red'; weight = bolder;>Phone number cannot be less than 10 digits!</font></center>");
//			}
//			else if(email.isBlank() || email.isEmpty()) {
//				RequestDispatcher rd = request.getRequestDispatcher("RegisterUser.html");
//				rd.include(request, response);
//				out.println("<br><br><center><font color = 'red'; weight = bolder;>Email cannot be empty!</font></center>");
//			}
//			else {
////				if(bal != null || bal != "") {
////					balance = Double.parseDouble(bal);
////				}
//				
//				ph = 0;
//				if(phone != null || phone != "") {
//					ph = Long.parseLong(phone);
//				}
//				
//				int accNo = rand.nextInt(1000000000);
//				User u = new User(accNo, fullName, user, pass, rePass, accType, balance, address, ph, email);
//				UserDao.saveUser(u);
//				
//				RequestDispatcher rd = request.getRequestDispatcher("LoginUser.html");
//				rd.include(request, response);
//				out.println("<br><br><center><font color = 'neon'; weight = bolder;>Registration Successful!<br>Continue to login..</font></center>");
////				response.sendRedirect("LoginUser.html");
//			}
		} catch (Exception e) {
			RequestDispatcher rd = request.getRequestDispatcher("RegisterUser.html");
			rd.include(request, response);
			out.println("<br><br><center><font color = 'red'; weight = bolder;>" + e.getMessage() + "</font></center>");
			e.printStackTrace();
		}
		
	}

}
