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
<title>Your Bank - Services</title>
<link rel="stylesheet" href="css/welcomeStyle.css">
<style>
	@import url('https://fonts.googleapis.com/css2?family=Kaushan+Script&display=swap');
	
	.navbar {
		margin-left: 18%
	}
	
	.container table {
		margin-top: 17%;
	}
	
	.container table tr .nc {
		text-align: left;
		width: 220px;
		padding-left: 50px;
	}
	
	.container table tr td .btn {
		width: auto;
	}
	
	.container table tr td select {
		width: 205px;
		height: 40px;
		padding: 5px 25px;
		font-size: 15px;
	}
	
	.container table tr td a {
	    padding: 5px;
	    background-color: #333;
	    color: #F6C7A1;
	    width: 30%;
	    font-weight: bolder;
	}
	
	.container table tr td a:hover {
	    background-color: #fadec8;
    	color: black;
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
			int accNo = 0;
			if(rs.next()) {
				balance = rs.getDouble("balance");
				accNo = rs.getInt("acc_no");
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
	
	<div class="content">
		<br>
		
		<div class="container">
			<form method="post">
				<table class = "applyCheque">
					<tr>
						<th colspan="2" align="center" class="tabhead">APPLY CHEQUE BOOK</th>
					</tr>

					<tr>
						<td class="nc">Cheque leaves required&nbsp;&nbsp;&nbsp;&nbsp;</td>
						<td><span class="error">*</span><input type="number" name="num" required="required"></td>
					</tr>
					
					<tr>
						<td class="nc">Sender Account No.</td>
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
						<!-- td align="center"><input type="button" class="btn" value="CHECK STATUS"></td-->
						<td align="center"><button class="btn" value="CHECK STATUS"><a class="btn" href="ViewUserRequests.jsp">CHECK STATUS</a></button>
						<td align="center"><input type="submit" class="btn" value="APPLY"></td>
					</tr>					
				</table>
			</form>
		</div>
	</div>
	
	<%
			int numLeaves = Integer.parseInt(request.getParameter("num"));
			String pass = request.getParameter("pwd");
			
			//Connection con = Util.getConnection();
			//Statement stmt = con.createStatement();
			sql = "select * from user where  user_name = '" + userName + "' and password = '" + pass + "';";
			rs = stmt.executeQuery(sql);
			
			if(rs.next()) {
				sql = "insert into services(acc_no, user_name, apply_cheque, apply_date) "
						+ "values("+ accNo + ", '" + userName + "', 1, '" + LocalDateTime.now() + "');";
				int status = stmt.executeUpdate(sql);
				if(status != 0) {
					out.println("<center><font color = 'green'; weight = bolder;>Cheque Book applied successfully! Waiting for approval!</font></center>");
					RequestDispatcher rd = request.getRequestDispatcher("ViewUserRequests.jsp");
					rd.include(request, response);
				}
				else {
					out.println("<center><font color = 'red'; weight = bolder;>Cheque Book could not be applied!</font></center>");
				}
				/* RequestDispatcher rd = request.getRequestDispatcher("Home.jsp");
				rd.include(request, response); */
				
		    }
			else {					
				out.println("<center><font color = 'red'; weight = bolder;>Invalid Password!!</font></center>");
			}
	
			stmt.close();
			con.close();
		}
		else {
			RequestDispatcher rd = request.getRequestDispatcher("LoginUser.html");
			rd.include(request, response);
			out.println("<center><font color = 'red'; weight = bolder;>Please login to continue!</font></center>");
		}
	} catch (Exception e) {
		e.printStackTrace();
	}
	%>
</body>
</html>