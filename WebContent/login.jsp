<%@page import="connection.DBCon"%>
<%@page import="dao.*"%>
<%@page import="java.util.*"%>
<%@page import="models.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
    	User auth = (User) request.getSession().getAttribute("auth");
    	if (auth != null) {
    		response.sendRedirect("index.jsp");
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
	<title>F0 Store - Login</title>
	<%@include file="includes/head.jsp" %>
</head>
<body>
	<%@include file="includes/navbar.jsp" %>
	
	<div class="container">
		<div class="card w-50 mx-auto my-5">
			<div class="card-header text-center">User login</div>
			
			<div class="card-body">
				<form action="login" method="post">
					<div class="form-group">
						<label>Email: </label>
						<input type="email" class="form-control" name="login-email" placeholder="Enter your email..." required>
					</div>
					
					<div class="form-group my-3">
						<label>Password: </label>
						<input type="password" class="form-control" name="login-password" placeholder="******" required>
					</div>
					
					<div class="text-center">
						<button type="submit" class="btn btn-primary">Login</button>
					</div>
				</form>
			</div>
		</div>
	</div>
	
	<%@include file="includes/footer.jsp" %>
</body>
</html>