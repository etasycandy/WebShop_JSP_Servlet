<%@page import="java.text.DecimalFormat"%>
<%@page import="dao.*"%>
<%@page import="java.util.*"%>
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
    	
    	ArrayList<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart-list");
    	List<Cart> cartProduct = null;
    	
    	if (cart_list != null) {
    		ProductDao pDao = new ProductDao(DBCon.getConnection());
    		cartProduct = pDao.getCartProducts(cart_list);
    		int countProducts = pDao.getTotalProductsInCart(cart_list);
    		double total = pDao.getTotalPriceCart(cart_list);
    		request.setAttribute("cart_list", countProducts);
    		request.setAttribute("total", total);
    	}
    %>
<!DOCTYPE html>
<html>
<head>
	<title>F0 Store - Cart</title>
	<%@include file="includes/head.jsp" %>
	<style type="text/css">
		.table tbody td{
			vertical-align: middle;
		}
		.btn-incre, .btn-decre{
			box-shadow: none;
			font-size: 25px;
		}
		.fa-minus-square{
			color: #dc3545;
		}
		.fa-plus-square{
			color: #28a745;
		}
		.btn:active{
			box-shadow:none;
		}
		.btn:focus{
			box-shadow:none;
		}
	</style>
</head>
<body>
	<%@include file="includes/navbar.jsp" %>
	
	<div class="container">
		<div class="d-flex py-3">
			<h3>Total price: $ ${ (total > 0) ? dcf.format(total) : 0 }</h3>
			<a href="check-out" class="mx-3 btn btn-primary">Check out</a>
		</div>
		
		<table class="table table-light table-hover">
			<thead>
				<tr class="text-center">
					<th class="col-3" scope="col">Name</th>
					<th class="col-3" scope="col">Category</th>
					<th class="col-2" scope="col">Price</th>
					<th class="col-3" scope="col">Quantity</th>
					<th class="col-1" scope="col">Action</th>
				</tr>
			</thead>
			
			<tbody>
				<%
					if (cart_list != null){
						for (Cart c:cartProduct) { %>
							<tr class="text-center">
								<td class="col-3"><%= c.getName() %></td>
								<td class="col-3"><%= c.getCategory() %></td>
								<td class="col-2"><%= dcf.format(c.getPrice()) %>$</td>
								<td class="col-3">
									<div class="d-flex justify-content-center align-items-center">
										<a href="quantity-pd-cart?action=dec&id=<%= c.getId() %>" class="btn btn-sm btn-decre">
											<i class="fas fa-minus-square"></i>
										</a>
										<input type="text" name="quantity" class="form-control text-center w-25" value="<%= c.getQuantity() %>" readonly>
										<a href="quantity-pd-cart?action=inc&id=<%= c.getId() %>" class="btn btn-sm btn-incre">
											<i class="fas fa-plus-square"></i>
										</a>
									</div>
								</td>
								<td class="col-1">
									<a href="quantity-pd-cart?action=del&id=<%= c.getId() %>" class="btn btn-sm btn-danger">
										<i class="fas fa-times"></i>
									</a>
								</td>
							</tr>
						<%}
					}
				%>
			</tbody>
		</table>
	</div>
	
	<%@include file="includes/footer.jsp" %>
</body>
</html>