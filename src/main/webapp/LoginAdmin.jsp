<%@page import="com.demo.sept12.connection.Util"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Your Bank - Login Admin</title>
<link rel="stylesheet" href="css/welcomeStyle.css">
<style>
	@import url('https://fonts.googleapis.com/css2?family=Kaushan+Script&display=swap');
	
	.content .container .login_img img {
		float: left;
		margin-left: 23%;
		margin-top: 2%;
		width: 13%;
		height: 13%;
	}
	
	.container table {
		margin-right: 23%;
	}
</style>
</head>
<body>
	<%
	try {
		response.setContentType("text/html");
		
		Connection con = Util.getConnection();
		Statement stmt = con.createStatement();
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
					<li><a href="Logout">Logout</a></li>
				</ul>
			</nav>
		</div>
	</header>
	
	<div class="content">
		<br>
		<div class="container">
			<div class="login_img">
				<img src="images/admin.png" alt="Login">
			</div>
			<form method="post">
				<table class = "login">
					<tr>
						<th colspan="2" align="center" class="tabhead">LOGIN</th>
					</tr>

					<tr>
						<td>Admin ID&nbsp;&nbsp;&nbsp;&nbsp;</td>
						<td><span class="error">*</span><input type="text" name="aname" required="required"></td>
					</tr>
					
					<tr>
						<td>Password&nbsp;&nbsp;&nbsp;&nbsp;</td>
						<td><span class="error">*</span><input type="password" name="pwd" required="required"></td>
					</tr>
					
					<!-- input type="submit" class="submit" value = "Login"-->
					<tr>
						<td colspan="2" align="center"><input type="submit" class="btn" value="LOGIN"></td>
					</tr>					
				</table>
			</form>
		</div>
	</div>
	<%
		String admin = request.getParameter("aname");
		String pass = request.getParameter("pwd");
		
		String sql = "select * from admin where admin_id = '" + admin + "' and admin_pass = '" + pass + "';";
		ResultSet rs = stmt.executeQuery(sql);
		
		if(rs.next()) {
			session.setAttribute("adminId", admin);
			response.sendRedirect("AdminHome.jsp");
		}
		else {
			out.println("<center><font color = 'red'; weight = bolder;>Invalid Credentials!</font></center>");
		}
		stmt.close();
		con.close();
		
	} catch (Exception e) {
		e.printStackTrace();
	}
	%>
</body>
</html>