<%@page import="java.sql.ResultSet"%>
<%@page import="com.demo.sept12.connection.Util"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Your Bank - View Your Requests</title>
<link rel="stylesheet" href="css/welcomeStyle.css">
<style>
	@import url('https://fonts.googleapis.com/css2?family=Kaushan+Script&display=swap');
	
	.navbar {
		margin-left: 18%;
	}
	
	.container table {
		width: 60%;
	}
	
	.container table tr:nth-child(odd) {
	background-color: rgb(85, 85, 85);
}
</style>
</head>
<body>
	<%
	try {
		response.setContentType("text/html");
				
		session = request.getSession();
		String userName = (String) session.getAttribute("userName");
		
		if(session.getAttribute("userName") != null) {
			Connection con = Util.getConnection();
			Statement stmt = con.createStatement();
			
			String sql = "select * from user where user_name = '" + userName + "';";
			ResultSet rs = stmt.executeQuery(sql);
			
			double balance = 0;
			int accNo = 0;
			if(rs.next()) {
				balance = rs.getDouble("balance");
				accNo = rs.getInt("acc_no");
			}
			
			sql = "select * from services where user_name = '" + userName + "';";
			rs = stmt.executeQuery(sql);
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
					<li><a href="Withdraw.jsp">Withdraw</a></li><li class="line">&nbsp;</li>
					<li><a href="Deposit.jsp">Deposit</a></li><li class="line">&nbsp;</li>
					<li><a href="Transfer.jsp">Transfer</a></li><li class="line">&nbsp;</li>
					<li><a href="ApplyCheque.jsp" class="active">Apply Cheque Book</a></li><li class="line">&nbsp;</li>
					<li><a href="Logout">Logout</a></li>
				</ul>
			</nav>
		</div>
		<ul class="balanceCheck">
			<li><input type="button" onclick="this.value='₹<%=balance%>'" value="View Balance"></li>
		</ul>
	</header>
	
	<br>
	<div class="content">
		<div class="container">
				<table class = "tab">
					<tr>
						<th colspan=5 align="center" class="tabhead">CHEQUE BOOK REQUESTS</th>
					</tr>
	<%
			if(!rs.next()) {
	%>
					<tr>
						<td colspan=5 align="center">You have not made any requests yet!</td>
					</tr>
	<%
			}
			else {
	%>
					<tr>
						<th>Service</th>
						<th>Request Date</th>
						<th>Approved Date</th>
						<th>Status</th>
					</tr>
					
					<tr>
						<td> Cheque Book </td>
						<td> <%=rs.getString("apply_date")%> </td>
	<%
					String approvedDate = rs.getString("approve_date");
					if(approvedDate == "" || approvedDate == null) {
	%>
						<td> NOT APPROVED </td>
	<%
					}
					else {
	%>
						<td> <%=approvedDate%> </td>
	<%
					}
					boolean ac = rs.getBoolean("apply_cheque");
					if(ac) {
						%>
						<td> APPLIED </td>
	<%
					}
					else {
	%>
						<td> APPROVED </td>
	<%
					}
	%>
					</tr>
	<%
				while(rs.next()) {
	%>
					<tr>
						<td> Cheque Book </td>
						<td> <%=rs.getString("apply_date")%> </td>
	<%
					approvedDate = rs.getString("approve_date");
					if(approvedDate == "" || approvedDate == null) {
	%>
						<td> NOT APPROVED </td>
	<%
					}
					else {
	%>
						<td> <%=approvedDate%> </td>
	<%
					}
					ac = rs.getBoolean("apply_cheque");
					if(ac) {
	%>
						<td> APPLIED </td>
	<%
					}
					else {
	%>
						<td> APPROVED </td>
	<%
					}
	%>
					</tr>
	<%
				}
			}
	%>
				</table>
		</div>
	</div>
	<%
			stmt.close();
			con.close();
		}
		else {
			out.println("<center><font color = 'red'; weight = bolder;>Please login to continue!</font></center>");
			response.sendRedirect("LoginAdmin.html");
		}
	} catch (Exception e) {
		e.printStackTrace();
	}
	%>
</body>
</html>