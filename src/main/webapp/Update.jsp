<%@page import="com.demo.sept12.dao.UserDao"%>
<%@page import="com.demo.sept12.model.User"%>
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
<title>Your Bank - Edit Details</title>
<link rel="stylesheet" href="css/welcomeStyle.css">
<style>
	@import url('https://fonts.googleapis.com/css2?family=Kaushan+Script&display=swap');
	body {
		height: 70%;
	}
	
	.navbar {
		margin-left: 18%
	}
	
	.content {
		height: 50%;
	}
	
	.container table {
	    background: rgb(63, 62, 62);
	    color: #F6C7A1;
	    margin-top: 15%;
	    margin-left: auto;
	    margin-right: auto;
	    width: 35%;
	    position: relative;
	    border-radius: 2px;
	}
	
	.container table .tabhead {
	    background-color: black;
	    color: #F6C7A1;
	    padding: 10px;
	    font-size: 25px;
	}
	
	.container table tr td {
	    padding: 10px;
	    margin: 0;
	    border: 0;
	    text-align: center;
	}
	
	td input {
	    padding: 10px;
	    width: 60%;
	}
	
	td select {
	    padding: 10px;
	    width: 68%;
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
			Connection con = Util.getConnection();
			Statement stmt = con.createStatement();
			String sql = "select * from user where user_name = '" + userName + "';";
			ResultSet rs = stmt.executeQuery(sql);
			double balance = 0;
			if(rs.next()) {
				balance = rs.getDouble("balance");
			}
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
					<li><a href="Withdraw.jsp"">Withdraw</a></li><li class="line">&nbsp;</li>
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
		
		
		<div class="container">
			<form method="post">
				<table class = "edit">
					<tr>
						<th colspan="2" align="center" class="tabhead">UPDATE</th>
					</tr>
					
					<tr>
						<td>Account No.&nbsp;&nbsp;&nbsp;&nbsp;</td>
						<td><input type="number" name="accNo" readonly="readonly" value='<%= rs.getInt("acc_no") %>'></td>
					</tr>
					
					<tr>
						<td>Full Name&nbsp;&nbsp;&nbsp;&nbsp;</td>
						<td><input type="text" name="flname" value='<%= rs.getString("full_name") %>'></td>
					</tr>
					
					<tr>
						<td>User Name&nbsp;&nbsp;&nbsp;&nbsp;</td>
						<td><input type="text" name="uname" readonly="readonly" value='<%= userName %>'></td>
					</tr>
					
					<tr>
						<td>Account Type&nbsp;&nbsp;&nbsp;&nbsp;</td>
						<td><input type="text" name="accType" readonly="readonly" value='<%= rs.getString("acc_type") %>'></td>
					</tr>

					<tr>
						<td>Address&nbsp;&nbsp;&nbsp;&nbsp;</td>
						<td><input type="text" name="address" required="required" value='<%= rs.getString("address") %>'></td>
					</tr>
					
					<tr>
						<td>Phone&nbsp;&nbsp;&nbsp;&nbsp;</td>
						<td><input type="text" name="phone" readonly="readonly" value='<%= rs.getString("phone") %>'></td>
					</tr>
					
					<tr>
						<td>Email&nbsp;&nbsp;&nbsp;&nbsp;</td>
						<td><input type="text" name="email" value='<%= rs.getString("email") %>'></td>
					</tr>
					
					<tr>
						<td colspan="2" align="center"><input type="submit" class="btn" value="UPDATE"></td>
					</tr>					
				</table>
			</form>
		</div>
	</div>
	<%
			int accNo = 0;
			String accNum = request.getParameter("accNo");
			if(accNum != null || accNum != "") {
				accNo = Integer.parseInt(accNum);
			}
			
			String fullName = request.getParameter("flname");
			
			//String userName = request.getParameter("uname");
			
			String accType = request.getParameter("accType");
			
			String address = request.getParameter("address");
			
			long phone = 0;
			String ph = request.getParameter("phone");
			if(ph != null || ph != "") {
				phone = Long.parseLong(accNum);
			}
			
			String email = request.getParameter("email");
			
			User user = new User();
			user.setAccNo(accNo);
			user.setUserName(userName);
			user.setFullName(fullName);
			user.setAccType(accType);
			user.setAddress(address);
			user.setPhone(phone);
			user.setEmail(email);
			
			int succ = UserDao.updateDetails(user);
			
			if(succ != 0) {
				out.println("<center><font color = 'green'; weight = bolder;>User updated successfully!</font></center>");
				RequestDispatcher rd = request.getRequestDispatcher("Profile.jsp");
				rd.forward(request, response);
			} else {
				out.println("<center><font color = 'red'; weight = bolder;>Player could not be updated!</font></center>");
				RequestDispatcher rd = request.getRequestDispatcher("Profile.jsp");
				rd.forward(request, response);
			}
			stmt.close();
			con.close();
		}
		else {
			out.println("<center><font color = 'red'; weight = bolder;>Please login to continue!</font></center>");
			RequestDispatcher rd = request.getRequestDispatcher("LoginUser.html");
			rd.include(request, response);
		}
		
	} catch (Exception e) {
		e.printStackTrace();
	}
	%>
</body>
</html>