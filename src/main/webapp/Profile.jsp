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
	<title>Your Bank - Profile</title>
	<link rel="stylesheet" href="css/welcomeStyle.css">
	<style>
	@import url('https://fonts.googleapis.com/css2?family=Kaushan+Script&display=swap');
	.navbar {
		margin-left: 18%;
	}
	
	.content {
		height: 50%;
	}
	
	.container table {
		margin-top: 15%;
		width: 40%;
	}
	
	.container table .tabhead {
	    background-color: black;
	    color: #F6C7A1;
	    padding: 15px;
	    font-size: 25px;
	}
	
	.container table tr:nth-child(odd) {
		background-color: rgb(85, 85, 85);
	}
	
	.container table tr td {
	    padding: 15px;
	    text-align: left;
	    width: 50%
	    
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
		String userName = (String) session.getAttribute("userName");
		
		if(session.getAttribute("userName") != null) {
			Connection con = Util.getConnection();
			Statement stmt = con.createStatement();
			
			String sql = "select * from user where user_name = '" + userName + "';";
			ResultSet rs = stmt.executeQuery(sql);
			double balance = 0;
			if(rs.next()) {
				balance = rs.getDouble("balance");
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
					<li><a href="Profile.jsp" class="active">Profile</a></li><li class="line">&nbsp;</li>
					<li><a href="Withdraw.jsp">Withdraw</a></li><li class="line">&nbsp;</li>
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
	
	<br>
	<div class="content">
		<div class="container">
		
					<table class = "tab">
					<tr>
						<th colspan=2 align="center" class="tabhead">PROFILE : <%=rs.getString("full_name")%>
						&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;<a class="update" href="Update.jsp">EDIT</a></th>
					</tr>
					<!-- tr>
						<th colspan=2 align="center" class="tabhead"><a href="Update.jsp">EDIT</a></th>
					</tr-->
					<tr>
						<td>Account No</td>
						<td> <%=rs.getInt("acc_no")%> </td>
					</tr>
					<tr>
						<td>User Name</td>
						<td> <%=rs.getString("user_name")%> </td>
					</tr>
					<tr>
						<td>Account Type</td>
						<td> <%=rs.getString("acc_type").toUpperCase()%> </td>
					</tr>
					<tr>
						<td>Address</td>
						<td> <%=rs.getString("address")%> </td>
					</tr>
					<tr>
						<td>Phone No.</td>
						<td> <%=rs.getLong("phone")%> </td>
					</tr>
					<tr>
						<td>Email ID</td>
						<td> <%=rs.getString("email")%> </td>
					</tr>
					</table>
		</div>
	</div>
	<%			
				}
				con.close();
			}
			else {
				RequestDispatcher rd = request.getRequestDispatcher("LoginUser.html");
				rd.include(request, response);
				out.println("<center><font color = 'red'; weight = bolder;>Please login to continue!</font></center>");
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
	%>
	
</body>
</html>