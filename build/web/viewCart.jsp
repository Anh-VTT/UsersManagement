<%-- 
    Document   : viewCart
    Created on : Dec 11, 2025, 2:26:39 PM
    Author     : votra
--%>

<%@page import="fa3w.user.UserDTO"%>
<%@page import="fa3w.product.Cart"%>
<%@page import="fa3w.product.ProductDTO"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Farm Cart Page</title>
        <link rel="stylesheet" href="css/viewCartStyle.css"/> 
    </head>
    <body class="cart-body">
        <div class="cart-container">
            <%
                UserDTO loginUser = (UserDTO) session.getAttribute("LOGIN_USER");
                if (loginUser == null || !"US".equals(loginUser.getRoleID())) {
                    response.sendRedirect("login.jsp");
                    return;
                }
            %>
            <h1 class="main-title">List product in shopping cart</h1>

            <%
                String successMessage = (String) request.getAttribute("SUCCESS_MESSAGE");
                if (successMessage != null) {
            %>
                <div class="message success-message"><%= successMessage %></div>
            <%
                }

                String errorMessage = (String) request.getAttribute("ERROR");
                if (errorMessage != null) {
            %>
                <div class="message error-message"><%= errorMessage %></div>
            <%
                }
            
                Map<String, String> stockErrors = (Map<String, String>) request.getAttribute("CHECKOUT_ERROR");
                if (stockErrors != null) {
            %>
                <div class="message error-message">Could not process checkout due to stock issues:</div>
                <ul class="error-list">
            <%
                    for(String message : stockErrors.values()) {
            %>
                        <li><%= message %></li>
            <%
                    }
            %>
                </ul>
            <%
                }
            %>

            <%
                Cart cart = (Cart) session.getAttribute("CART");
                if (cart != null && cart.getCart().size() > 0) {
            %>
            
            <table class="product-table">
                <thead class="table-head">
                    <tr>
                        <th>No</th>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Price</th>
                        <th>Quantity</th>
                        <th>Total</th>
                        <th colspan="2">Action</th>
                    </tr>
                </thead>
                <tbody class="table-body">
                    <%
                        int count = 1;
                        double total = 0;
                        for (ProductDTO product : cart.getCart().values()) {
                            total += product.getQuantity() * product.getPrice();
                    %>
                    <form action="MainController" method="POST">
                        <tr class="table-row">
                            <td class="cell-no"><%= count++%></td>
                            <td><%= product.getId()%></td>
                            <td><%= product.getName()%></td>
                            <td><%= product.getPrice()%></td>
                            <td class="cell-quantity">
                                <input type="number" name="quantity" value="<%= product.getQuantity()%>" min="1" required="" class="input-quantity"/>
                            </td>
                            <td class="cell-total"><%= product.getPrice() * product.getQuantity()%>$</td>
                            <td class="cell-action">
                                <input type="hidden" name="id" value="<%= product.getId()%>" />
                                <input type="submit" name="action" value="Edit" class="btn btn-edit" />
                            </td>
                            <td class="cell-action">
                                <input type="submit" name="action" value="Remove" class="btn btn-remove" />
                            </td>
                        </tr>
                    </form>
                    <%
                        }
                    %>
                </tbody>
            </table>
            
            <div class="cart-summary">
                <div class="total-display">Total: <span class="total-value"><%= total%></span></div>
                <form action="MainController" method="POST" class="checkout-form">
                    <input type="submit" name="action" value="Checkout" class="btn btn-checkout"/>
                </form>
            </div>
            
            <%
            } else {
            %>
                <div class="empty-cart-message"><%= "empty!!"%></div>
            <%
                }
            %>
            <a href="shopping.jsp" class="btn-link add-more-link">Add more</a>
        </div>
    </body>
</html>