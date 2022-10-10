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
<title>Your Bank - Admin Home</title>
<link rel="stylesheet" href="css/welcomeStyle.css">
<style>
	@import url('https://fonts.googleapis.com/css2?family=Kaushan+Script&display=swap');
	.navbar {
		margin-left: 28%;
	}
	
	.content {
		height: 50%;
	}
	
	.container table {
		width: 60%;
	}
	
	.container table .tabhead {
	    background-color: black;
	    color: #F6C7A1;
	    padding: 15px;
	    font-size: 25px;
	}
	
	.container table tr:nth-child(odd) {
		background-color: rgb(80, 80, 80);
	}
	
	.container table tr th {
		padding: 15px;
	    text-align: center;
	}
	
	.container table tr td {
	    padding: 15px;
	    text-align: center;
	    
	}
	
	.container table tr .nc {
	    padding: 15px;
	    text-align: left;
	}
	
	.container table tr .right {
	    padding: 15px;
	    text-align: right;
	    width: 80px;
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
			
			String sql = "select * from admins where admin_id = '" + adminId + "';";
			ResultSet rs1 = stmt.executeQuery(sql);
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
					<li><a href="AdminHome.jsp" class="active">Home</a></li><li class="line">&nbsp;</li>
					<li><a href="ViewUsers.jsp">Users</a></li><li class="line">&nbsp;</li>
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
				
				</div>
			</div>
	<%
		}
		else {
//			out.println("<center><font color = 'red'; weight = bolder;>Please login to continue!</font></center>");
			response.sendRedirect("LoginAdmin.html");
//			response.sendRedirect("Home.html");
		}
	} catch (Exception e) {
		e.printStackTrace();
	}
	%>
	
</body>
</html>