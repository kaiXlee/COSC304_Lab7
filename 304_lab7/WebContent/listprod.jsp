<%@ page import="java.sql.*,java.net.URLEncoder" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<title>YOUR NAME Grocery</title>
</head>
<body>

<h1>Search for the products you want to buy:</h1>

<form method="get" action="listprod.jsp">
<input type="text" name="productName" size="50">
<input type="submit" value="Submit"><input type="reset" value="Reset"> (Leave blank for all products)
</form>

<% // Get product name to search for
String name = request.getParameter("productName");
		
//Note: Forces loading of SQL Server driver
try
{	// Load driver class
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
}
catch (java.lang.ClassNotFoundException e)
{
	out.println("ClassNotFoundException: " +e);
}

// Variable name now contains the search string the user entered
// Use it to build a query and print out the resultset.  Make sure to use PreparedStatement!

// Make the connection
String url = "jdbc:sqlserver://sql04.ok.ubc.ca:1433;DatabaseName=db_jkim;";
String uid = "jkim";
String pw = "37007135";
try ( Connection con = DriverManager.getConnection(url, uid, pw); Statement stmt = con.createStatement();) {	
	ResultSet rst = stmt.executeQuery("SELECT * FROM Product");	
	// Print out the ResultSet
	%>
	<h2>All Products</h2>
	<table><tr><th></th><th>Product Name</th><th>Price</th>
	<%
	while (rst.next()) {	
	%>

	<tr>
	<td><a href="addcart.jsp?id=<productId>&name=<productName>&price=<productPrice>">Add to Cart</a></td>
	<td><% out.print(URLEncoder.encode(rst.getString(2), "Windows-1252")); %></td>
	<td><% NumberFormat currFormat = NumberFormat.getCurrencyInstance(); out.print(currFormat.format(rst.getDouble(5))); %></td>
	</tr>
	<%
	} 
	%>
	</table>
	<%
} 

catch (SQLException ex) { out.println(ex); }

// For each product create a link of the form
// addcart.jsp?id=<productId>&name=<productName>&price=<productPrice>
// Note: As some product names contain special characters, need to encode URL parameter for product name like this: URLEncoder.encode(productName, "Windows-1252")
// Close connection

// Useful code for formatting currency values:
// NumberFormat currFormat = NumberFormat.getCurrencyInstance();
// out.println(currFormat.format(5.0);	// Prints $5.00

	%>
</body>
</html>