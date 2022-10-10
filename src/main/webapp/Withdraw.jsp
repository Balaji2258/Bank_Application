<%@page import="com.demo.sept12.dao.UserDao"%>
<%@page import="java.time.LocalDateTime"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="com.demo.sept12.connection.Util"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Your Bank - Withdraw</title>
<link rel="stylesheet" href="css/welcomeStyle.css">
<style>
	@import url('https://fonts.googleapis.com/css2?family=Kaushan+Script&display=swap');
	
	.navbar {
		margin-left: 18%
	}
	
	.container table tr .nc {
		text-align: left;
		width: 220px;
		padding-left: 50px;
	}
	
	.container table tr td select {
		width: 205px;
		height: 40px;
		padding: 5px 25px;
		font-size: 15px;
	}
</style>
</head>
<body>
	<%
	try {
		response.setContentType("text/html");
		
		session = request.getSession();
		String userName = (String) session.getAttribute("userName");
		
		if(userName != null) {
			/* Connection con = Util.getConnection();
			Statement stmt = con.createStatement(); */
			
			double balance = UserDao.getBalance(userName);
			int accNo = UserDao.getAccNo(userName);
	%>
	<header>
		<div class="logo1">
			<img src="images/logo.jpg" class="logo" alt="Your Bank">
		</div>

		<div class="whatsapp">
			<a href="https://api.whatsapp.com/send?phone=9590867522"><img src="whatsapp.jpg" class="whatsapp" alt="Send Message"></a>
		</div>
		
		<div class = "head_content">
			<p class="bank_name">YOUR BANK</p>
			<p class="tagline" style="font-family: 'Kaushan Script', cursive;">A partner for life..</p>
		</div>

		<div class="navg">
			<nav class="navbar">
				<ul>
					<li><a href="Home.jsp">Home</a></li><li class="line">&nbsp;</li>
					<li><a href="Profile.jsp">Profile</a></li><li class="line">&nbsp;</li>
					<li><a href="Withdraw.jsp" class="active">Withdraw</a></li><li class="line">&nbsp;</li>
					<li><a href="Deposit.jsp">Deposit</a></li><li class="line">&nbsp;</li>
					<li><a href="Transfer.jsp">Transfer</a></li><li class="line">&nbsp;</li>
					<li><a href="ApplyCheque.jsp">Apply Cheque Book</a></li><li class="line">&nbsp;</li>
					<li><a href="Logout">Logout</a></li>
				</ul>
			</nav>
		</div>
		<ul class="balanceCheck">
			<li><input type="button" onclick="this.value='₹<%=balance%>'" value="View Balance"></li>
		</ul>
	</header>
	
	<div class="content">
		<br><br><br>
		
		<div class="container">
			<form method="post">
				<table class = "withdraw">
					<tr>
						<th colspan="2" align="center" class="tabhead">WITHDRAW</th>
					</tr>

					<tr>
						<td class="nc">Enter withdraw amount&nbsp;&nbsp;&nbsp;&nbsp;</td>
						<td><span class="error">*</span><input type="number" name="amount" required="required"></td>
					</tr>
					
					<tr>
						<td class="nc">Account No.</td>
						<td>
							<select>
								<option><%= accNo %></option>
							</select>
						</td>
					</tr>
					
					<tr>
						<td class="nc">Enter password&nbsp;&nbsp;&nbsp;&nbsp;</td>
						<td><span class="error">*</span><input type="password" name="pwd" required="required"></td>
					</tr>
					
					<tr>
						<td colspan="2" align="center"><input type="submit" class="btn" value="WITHDRAW"></td>
					</tr>					
				</table>
			</form>
		</div>
	</div>
	
	<%
			double amt = Double.parseDouble(request.getParameter("amount"));
			String pass = request.getParameter("pwd");
			
			String status = UserDao.withDraw(userName, pass, amt);
			
			if(status.equalsIgnoreCase("success")) {
				RequestDispatcher rd = request.getRequestDispatcher("Home.jsp");
				rd.forward(request, response);
				out.println("success");
			} else {
				out.println(status);
			}
		}
		else {
			RequestDispatcher rd = request.getRequestDispatcher("LoginUser.html");
			rd.include(request, response);
			out.println("<center><font color = 'red'; weight = bolder;>Please login to continue!</font></center>");
		}
	} catch (Exception e) {
		e.getMessage();
	}
	%>
</body>
</html>