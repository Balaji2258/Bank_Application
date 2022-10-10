<%@page import="com.demo.sept12.dao.UserDao"%>
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
<title>Your Bank - Home</title>
<link rel="stylesheet" href="css/welcomeStyle.css">
<style>
	@import url('https://fonts.googleapis.com/css2?family=Kaushan+Script&display=swap');
	.navbar {
		margin-left: 18%
	}
	
	.content {
		height: 50%;
	}
	
	.container .btn {
		padding: 5px;
	    background-color: rgb(85, 85, 85);
	    color: #F6C7A1;
	    width: 5%;
	    font-weight: bolder;
	}
	
	.container .btn:hover {
		background-color: #333;
    	color: #F6C7A1;
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
<script type="text/javascript" src="https://unpkg.com/xlsx@0.15.1/dist/xlsx.full.min.js"></script>
<script type="text/javascript">
	function ExportToExcel(type, fn, dl) {
	    var elt = document.getElementById('transaction_table');
	    var wb = XLSX.utils.table_to_book(elt, { sheet: "sheet1" });
	    return dl ?
	    	XLSX.write(wb, { bookType: type, bookSST: true, type: 'base64' }):
	      	XLSX.writeFile(wb, fn || ('MyTransactions.' + (type || 'xlsx')));
	}
</script>
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
			
			double balance = UserDao.getBalance(userName);
			
			String sql = "select * from transactions where acc_no = (select acc_no from user where user_name = '" + userName + "');";
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
					<li><a href="Home.jsp" class="active">Home</a></li><li class="line">&nbsp;</li>
					<li><a href="Profile.jsp">Profile</a></li><li class="line">&nbsp;</li>
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
				<table id="transaction_table">
					<tr>
						<th colspan=4 align="center" class="tabhead">TRANSACTIONS</th>
					</tr>
	<%
			if(!rs.next()) {
	%>
					<tr>
						<td colspan=4 align="center">You have not made any transactions yet!</td>
					</tr>
	<%
			}
			else {
	%>
					
					<tr>
						<th>Transaction ID</th>
						<th class="nc">Transaction Type</th>
						<th class="right">Amount</th>
						<th>DateTime</th>
					</tr>
					<tr>
						<td><%= rs.getInt("id") %></td>
						<td class="nc"><%= rs.getString("trans_type") %></td>
						<td class="right"><%= rs.getDouble("trans_amt") %></td>
						<td><%= rs.getString("trans_date") %></td>
					</tr>
	<%
				while(rs.next()) {
	%>
						<tr>
							<td><%= rs.getInt("id") %></td>
							<td class="nc"><%= rs.getString("trans_type") %></td>
							<td class="right"><%= rs.getDouble("trans_amt") %></td>
							<td><%= rs.getString("trans_date") %></td>
						</tr>
	<%
				}
			}
	%>
				</table>
				<br><br>
				<center><button class="btn" onclick="ExportToExcel('xlsx')">DOWNLOAD</button></center>
				<br><br>
				</div>
			</div>
	<%
		}
		else {
			out.println("<center><font color = 'red'; weight = bolder;>Please login to continue!</font></center>");
			response.sendRedirect("LoginUser.html");
//			response.sendRedirect("Home.html");
		}
	} catch (Exception e) {
		e.printStackTrace();
	}
	%>
	
</body>
</html>