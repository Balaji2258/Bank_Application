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
<title>Your Bank - View Users</title>
<link rel="stylesheet" href="css/welcomeStyle.css">
<style>
	@import url('https://fonts.googleapis.com/css2?family=Kaushan+Script&display=swap');
	
	.navbar {
		margin-left: 28%;
	}
	
	.container table {
		width: 80%;
	}
	
	.container table tr td a {
		background: black;
	}
	
	.container table tr th, .container table tr td{
		padding: 15px;
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
		String adminId = (String) session.getAttribute("adminId");
		
		if(session.getAttribute("adminId") != null) {
			Connection con = Util.getConnection();
			Statement stmt = con.createStatement();
			
			String sql = "select * from user;";
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
					<li><a href="ViewUsers.jsp" class="active">Users</a></li><li class="line">&nbsp;</li>
					<li><a href="ViewTransactions.jsp">Transactions</a></li><li class="line">&nbsp;</li>
					<li><a href="ApproveCheque.jsp">Requests</a></li><li class="line">&nbsp;</li>
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
						<th colspan=10 align="center" class="tabhead">USERS</th>
					</tr>
	<%
			if(!rs.next()) {
	%>
					<tr>
						<td colspan=8 align="center">There are no users yet!</td>
					</tr>
	<%
			}
			else {
	%>
					<tr>
						<th>Account No.</th>
						<th>Full Name</th>
						<th>User Name</th>
						<th>Account Type</th>
						<th>Account Balance</th>
						<th>Address</th>
						<th>Phone</th>
						<th>Email</th>
						<th>View Transactions</th>
						<th>Delete Account</th>
					</tr>
					
					<tr>
						<td> <%=rs.getInt("acc_no")%> </td>
						<td> <%=rs.getString("full_name")%> </td>
						<td> <%=rs.getString("user_name")%> </td>
						<td> <%=rs.getString("acc_type").toUpperCase()%> </td>
						<td> <%=rs.getDouble("balance")%> </td>
						<td> <%=rs.getString("address")%> </td>
						<td> <%=rs.getLong("phone")%> </td>
						<td> <%=rs.getString("email")%> </td>
						<td> <a href='ViewTransactionByAcc.jsp?accNo=<%=rs.getInt("acc_no")%>'>VIEW</a> </td>
						<td> <a href='DeleteUser?accNo=<%=rs.getInt("acc_no")%>'> DELETE </a> </td>
					</tr>
	<%
				while(rs.next()) {
	%>
					<tr>
						<td> <%=rs.getInt("acc_no")%> </td>
						<td> <%=rs.getString("full_name")%> </td>
						<td> <%=rs.getString("user_name")%> </td>
						<td> <%=rs.getString("acc_type").toUpperCase()%> </td>
						<td> <%=rs.getDouble("balance")%> </td>
						<td> <%=rs.getString("address")%> </td>
						<td> <%=rs.getLong("phone")%> </td>
						<td> <%=rs.getString("email")%> </td>
						<td> <a href='ViewTransactionByAcc.jsp?accNo=<%=rs.getInt("acc_no")%>'>VIEW</a> </td>
						<td> <a href='DeleteUser?accNo=<%=rs.getInt("acc_no")%>'> DELETE </a> </td>
					</tr>
	<%
				}
			}
	%>
				</table>
		</div>
	</div>
	<%
		}
		else {
			out.println("<center><font color = 'red'; weight = bolder;>Please login to continue!</font></center>");
			response.sendRedirect("LoginAdmin.html");
//			response.sendRedirect("Home.html");
		}
	} catch (Exception e) {
		e.printStackTrace();
	}
	%>
</body>
</html>