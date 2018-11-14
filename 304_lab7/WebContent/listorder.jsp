<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>

<!DOCTYPE html>
<html>
<head>
<title>Jae Kim's Grocery Order List</title>
</head>
<body>

<h1>Order List</h1>

<%
//Note: Forces loading of SQL Server driver
try{	// Load driver class
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
}
catch (java.lang.ClassNotFoundException e){
	out.println("ClassNotFoundException: " +e);
}

// Useful code for formatting currency values:
// NumberFormat currFormat = NumberFormat.getCurrencyInstance();
// out.println(currFormat.format(5.0);  // Prints $5.00

// Make connection
String url = "jdbc:sqlserver://sql04.ok.ubc.ca:1433;DatabaseName=db_jkim;";
String uid = "jkim";
String pw = "37007135";
try ( Connection con = DriverManager.getConnection(url, uid, pw); Statement stmt = con.createStatement();) {	
	ResultSet rst = stmt.executeQuery("SELECT * FROM Product");	
	out.println(""); 
	while (rst.next()) {	
	out.println(rst.getString(1) + rst.getString(2)); 
	} 
} 

catch (SQLException ex) { out.println(ex); }
// Write query to retrieve all order headers

// For each order in the ResultSet

	// Print out the order header information
	// Write a query to retrieve the products in the order
	//   - Use a PreparedStatement as will repeat this query many times
	// For each product in the order
		// Write out product information 

// Close connection
%>

</body>
</html>

