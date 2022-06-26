<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.*"%>
<%@page import="dao.ProductDao"%>
<%@page import="connection.DBCon"%>
<%@page import="models.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
	    DecimalFormat dcf = new DecimalFormat("#.##");
		request.setAttribute("dcf", dcf);
		
    	User auth = (User) request.getSession().getAttribute("auth");
    	if (auth != null) {
    		request.setAttribute("auth", auth);
    	}
    	
    	ProductDao pd = new ProductDao(DBCon.getConnection());
    	List<Product> products = pd.getAllProducts(); 
    	
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
	<title>F0 Store</title>
	<%@include file="includes/head.jsp" %>
</head>
<body>
	<%@include file="includes/navbar.jsp" %>
	
	<div class="container">
		<div class="card-header my-3">All products</div>
		<div class="row">
		<%
			if (!products.isEmpty()) {
				for(Product p:products) { %>
					<div class="col-md-3 mb-3">
						<div class="card w-100" style="width: 18rem;">
							<img class="card-img-top" src="images/<%= p.getImage() %>" alt="Card image cap">
						  	<div class="card-body">
						    	<h5 class="card-title"><%= p.getName() %></h5>
						    	<h6 class="price">Price: $<%= dcf.format(p.getPrice()) %></h6>
						    	<h6 class="Category">Category: <%= p.getCategory() %></h6>
						    	<div class="mt-3 d-flex justify-content-between">
						    		<a href="add-to-cart?id=<%= p.getId() %>" class="btn btn-success">Add to cart</a>
						    		<a href="order-now?quantity=1&id=<%= p.getId() %>" class="btn btn-primary">Buy now</a>
						    	</div>
						  	</div>
						</div>
					</div>
				<%}
			}
		%>
		</div>
	</div>
	
	<%@include file="includes/footer.jsp" %>
</body>
</html>