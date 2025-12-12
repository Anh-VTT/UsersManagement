<%-- 
    Document   : viewCart
    Created on : Dec 11, 2025, 2:26:39 PM
    Author     : votra
--%>

<%@page import="fa3w.user.UserDTO"%>
<%@page import="fa3w.product.Cart"%>
<%@page import="fa3w.product.ProductDTO"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Farm Cart Page</title>
    </head>
    <body>
        <%
            UserDTO loginUser = (UserDTO) session.getAttribute("LOGIN_USER");
            if (loginUser == null || !"US".equals(loginUser.getRoleID())) {
                response.sendRedirect("login.jsp");
                return;
            }
        %>
        <h1>List product in shopping cart</h1>
        <%
            Cart cart = (Cart) session.getAttribute("CART");
            if (cart != null && cart.getCart().size() > 0) {
        %>
        <table border="1">
            <thead>
                <tr>
                    <th>No</th>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Price</th>
                    <th>Quantity</th>
                    <th>Total</th>
                    <th>Edit</th>
                    <th>Remove</th>
                </tr>
            </thead>
            <tbody>
                <%
                    int count = 1;
                    double total = 0;
                    for (ProductDTO product : cart.getCart().values()) {
                        total += product.getQuantity() * product.getPrice();

                %>
            <form action="MainController" method="POST">
                <tr>
                    <td><%= count++%></td>
                    <td><%= product.getId()%></td>
                    <td><%= product.getName()%></td>
                    <td><%= product.getPrice()%></td>
                    <td>
                        <input type="number" name="quantity" value="<%= product.getQuantity()%>" min="1" required=""/>
                    </td>
                    <td><%= product.getPrice() * product.getQuantity()%>$</td>
                    <td>
                        <input type="hidden" name="id" value="<%= product.getId()%>" />
                        <input type="submit" name="action" value="Edit" />
                    </td>
                    <td>
                        <input type="submit" name="action" value="Remove" />
                    </td>
                </tr>
            </form>

            <%                    }
            %>
        </tbody>
    </table>
    Total:<%= total%>
    <%
    } else {
    %>
    <%= "empty!!"%>
    <%
        }
    %>
    <a href="shopping.jsp">Add more</a>
</body>
</html>
