<%-- 
    Document   : Shopping
    Created on : Dec 10, 2025, 3:13:36 PM
    Author     : votra
--%>

<%@page import="fa3w.user.UserDTO"%>
<%@page import="java.util.List"%>
<%@page import="fa3w.product.ProductDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Fitchew Farm</title>
        <link rel="stylesheet" href="css/shoppingStyle.css"/> 
    </head>
    <body class="shopping-body">
        <div class="shopping-container">
            <%
                UserDTO loginUser = (UserDTO) session.getAttribute("LOGIN_USER");
                if (loginUser == null || !"US".equals(loginUser.getRoleID())) {
                    response.sendRedirect("login.jsp");
                    return;
                }
                String search = request.getParameter("search");
                if (search == null)
                    search = "";
            %>
            <h1 class="main-title">WELCOME TO FITCHEW FARM</h1>

            <form action="MainController" class="search-form">
                <div class="form-group">
                    <label for="searchName">Name:</label> 
                    <input type="text" id="searchName" name="search" value="<%= search%>" required="" class="search-input"/>
                </div>

                <input type="submit" name="action" value="Search Product" class="btn btn-primary"/>
                <input type="submit" name="action" value="View Cart" class="btn btn-secondary"/>
            </form>

            <%
                List<ProductDTO> list = (List<ProductDTO>) request.getAttribute("LIST_PRODUCT");
                if (list != null && list.size() > 0) {
            %>

            <table class="product-table">
                <thead class="table-head">
                    <tr>
                        <th>No</th>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Price</th>
                        <th>Quantity</th>
                        <th>Add</th>
                    </tr>
                </thead>
                <tbody class="table-body">
                    <%
                        int count = 1;
                        for (ProductDTO product : list) {
                    %>
                <form action="MainController" method="POST">
                    <tr class="table-row">
                        <td class="cell-no"><%= count++%></td>
                        <td class="cell-id">
                            <input type="text" name="id" value="<%= product.getId()%>" readonly="" class="input-id"/>
                        </td>
                        <td class="cell-name"><%= product.getName()%></td>
                        <td class="cell-price"><%= product.getPrice()%></td>
                        <td class="cell-quantity-stock"><%= product.getQuantity()%></td>
                        <td class="cell-add">
                            <input type="number" name="quantity" value="1" required="" min="1" class="input-quantity"/>
                            <input type="hidden" name="search" value="<%= search%>" required=""/>
                            <input type="submit" name="action" value="Add" class="btn btn-add" />
                        </td>
                    </tr>
                </form>
                <%
                    }
                %>
                </tbody>
            </table>
            
            <%
                }
                // Hiển thị thông báo lỗi/thông báo
                String error = (String) request.getAttribute("ERROR");
                if (error == null) {
                    error = "";
                }
            %>
            <div class="message error-message"><%= error%></div>

            <%
                String message = (String) request.getAttribute("MESSAGE");
                if (message == null) {
                    message = "";
                }
            %>
            <div class="message success-message"><%= message%></div>

        </div>
    </body>
</html>