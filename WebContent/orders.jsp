<%@page import="dao.*"%>
<%@page import="java.util.*"%>
<%@page import="connection.DBCon"%>
<%@page import="models.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
    	User auth = (User) request.getSession().getAttribute("auth");
    	if (auth != null) {
    		request.setAttribute("auth", auth);
    	}
    	
    	ArrayList<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart-list");
    	List<Cart> cartProduct = null;
    	
    	if (cart_list != null) {
    		ProductDao pDao = new ProductDao(DBCon.getConnection());
    		int countProducts = pDao.getTotalProductsInCart(cart_list);
    		request.setAttribute("cart_list", countProducts);
    	}
    %>
<!DOCTYPE html>
<html>
<head>
	<title>F0 Store - Orders</title>
	<%@include file="includes/head.jsp" %>
</head>
<body>
	<%@include file="includes/navbar.jsp" %>
	
	<h1>Hello F0 store</h1>
	
	<%@include file="includes/footer.jsp" %>
</body>
</html>