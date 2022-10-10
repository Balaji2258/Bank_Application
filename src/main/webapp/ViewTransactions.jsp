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
<title>Your Bank - View Transactions</title>
<link rel="stylesheet" href="css/welcomeStyle.css">
<style>
	@import url('https://fonts.googleapis.com/css2?family=Kaushan+Script&display=swap');
	
	.navbar {
		margin-left: 28%;
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
	
	.container table tr th, .container table tr td{
		padding: 15px;
	}
	
	.container table tr:nth-child(even) {
		background-color: rgb(85, 85, 85);
	}
	
	.content .container .tab tr td .btn {
		width: 125px;
	}
	
	.content .container table button {
	    padding: 5px;
	    background-color: #333;
	    color: #F6C7A1;
	    width: 30%;
	    font-weight: bolder;
	}
	
	.container table .btn:hover {
	    background-color: #fadec8;
	    color: black;
	}
}
</style>
<script type="text/javascript" src="https://unpkg.com/xlsx@0.15.1/dist/xlsx.full.min.js"></script>
<script type="text/javascript">
	function ExportToExcel(type, fn, dl) {
	    var elt = document.getElementById('transaction_table');
	    var wb = XLSX.utils.table_to_book(elt, { sheet: "sheet1" });
	    return dl ?
	    	XLSX.write(wb, { bookType: type, bookSST: true, type: 'base64' }):
	      	XLSX.writeFile(wb, fn || ('AllTransactions.' + (type || 'xlsx')));
	}
</script>
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
			
			String sql = "select * from transactions;";
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
					<li><a href="ViewTransactions.jsp" class="active">Transactions</a></li><li class="line">&nbsp;</li>
					<li><a href="ApproveCheque.jsp">Requests</a></li><li class="line">&nbsp;</li>
					<li><a href="Logout">Logout</a></li>
				</ul>
			</nav>
		</div>
	</header>
	
	<br>
	<div class="content">
		<div class="container">
				<table class = "tab" id="transaction_table">
					<tr>
						<th colspan=5 class="tabhead">TRANSACTIONS</th>
					</tr>
	<%
			if(!rs.next()) {
	%>
					<tr>
						<td colspan=5 align="center">There are no users yet!</td>
					</tr>
	<%
			}
			else {
	%>
					<tr>
						<th>Transaction ID</th>
						<th>Account No.</th>
						<th>Transaction</th>
						<th>Amount</th>
						<th>Date</th>
					</tr>
					
					<tr>
						<td> <%=rs.getInt("id")%> </td>
						<td> <%=rs.getInt("acc_no")%> </td>
						<td> <%=rs.getString("trans_type")%> </td>
						<td> <%=rs.getDouble("trans_amt")%> </td>
						<td> <%=rs.getTimestamp("trans_date")%> </td>
					</tr>
	<%
				while(rs.next()) {
	%>
					<tr>
						<td> <%=rs.getInt("id")%> </td>
						<td> <%=rs.getInt("acc_no")%> </td>
						<td> <%=rs.getString("trans_type")%> </td>
						<td> <%=rs.getDouble("trans_amt")%> </td>
						<td> <%=rs.getTimestamp("trans_date")%> </td>
					</tr>
	<%
				}
			}
	%>
				</table><br><br>
				<center><button class="btn" onclick="ExportToExcel('xlsx')">DOWNLOAD</button></center>
				<br><br>
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