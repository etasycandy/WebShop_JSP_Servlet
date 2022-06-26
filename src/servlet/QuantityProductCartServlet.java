package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Iterator;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import models.Cart;

/**
 * Servlet implementation class QuantityIncDecServlet
 */
@WebServlet("/quantity-pd-cart")
public class QuantityProductCartServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		
		try (PrintWriter out = response.getWriter()) {
			String action = request.getParameter("action");
			String id = request.getParameter("id");
			
			ArrayList<Cart> cart_list = (ArrayList<Cart>) request.getSession().getAttribute("cart-list");
			
			if (action != null && id != null) {
				
				if (action.equals("inc")) {
					for (Cart c:cart_list) {
						if (String.valueOf(c.getId()).equals(id)) {
							int quantity = c.getQuantity();
							quantity++;
							c.setQuantity(quantity);
							response.sendRedirect("cart.jsp");
						}
					}
				}
				
				if (action.equals("dec")) {
					for (Cart c:cart_list) {
						if (String.valueOf(c.getId()).equals(id)) {
							if (c.getQuantity() > 1) {
								int quantity = c.getQuantity();
								quantity--;
								c.setQuantity(quantity);
								break;
							} else {
								cart_list.remove(cart_list.indexOf(c));
								break;
							}
						}
					}
					response.sendRedirect("cart.jsp");
				}
				
				if (action.equals("del") && cart_list != null) {
					for (Cart c:cart_list) {
						if (String.valueOf(c.getId()).equals(id)) {
							cart_list.remove(cart_list.indexOf(c));
							break;
						}
					}
					response.sendRedirect("cart.jsp");
				}
			} else {
				response.sendRedirect("cart.jsp");
			}
		}
	}

}
