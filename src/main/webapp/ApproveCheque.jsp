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
<title>Your Bank - Approve Cheque Book</title>
<link rel="stylesheet" href="css/welcomeStyle.css">
<style>
	@import url('https://fonts.googleapis.com/css2?family=Kaushan+Script&display=swap');
	
	.navbar {
		margin-left: 28%;
	}
	
	.container table {
		width: 60%;
	}
	
	.container table tr:nth-child(odd) {
		background-color: rgb(85, 85, 85);
	}
	
	.container table tr td a {
		background: black;
	}
</style>
</head>
<body>
	<%
	try {
		response.setContentType("text/html");
				
		session = request.getSession();
		String adminId = (String) session.getAttribute("adminId");
		
		if(session.getAttribute("adminId") != null) {
			Connection con = Util.getConnection();
			Statement stmt = con.createStatement();
			
			String sql = "select * from services;";
			ResultSet rs = stmt.executeQuery(sql);
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
					<li><a href="AdminHome.jsp">Home</a></li><li class="line">&nbsp;</li>
					<li><a href="ViewUsers.jsp">Users</a></li><li class="line">&nbsp;</li>
					<li><a href="ViewTransactions.jsp">Transactions</a></li><li class="line">&nbsp;</li>
					<li><a href="ApproveCheque.jsp" class="active">Requests</a></li><li class="line">&nbsp;</li>
					<li><a href="Logout">Logout</a></li>
				</ul>
			</nav>
		</div>
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
						<td colspan=5 align="center">No requests available at the moment!</td>
					</tr>
	<%
			}
			else {
	%>
					<tr>
						<th>Account No.</th>
						<th>User Name</th>
						<th>Status</th>
					</tr>
					
					<tr>
						<td> <%=rs.getInt("acc_no")%> </td>
						<td> <%=rs.getString("user_name")%> </td>
	<%
					boolean ac = rs.getBoolean("apply_cheque");
					if(ac) {
	%>
						<td> <a href="Approve?accNo=<%=rs.getInt("acc_no")%>"> APPROVE </a> </td>
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
						<td> <%=rs.getInt("acc_no")%> </td>
						<td> <%=rs.getString("user_name")%> </td>
	<%
					ac = rs.getBoolean("apply_cheque");
					if(ac) {
	%>
						<td> <a href="Approve?accNo=<%=rs.getInt("acc_no")%>"> APPROVE </a> </td>
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