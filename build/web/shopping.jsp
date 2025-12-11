<%-- 
    Document   : Shopping
    Created on : Dec 10, 2025, 3:13:36 PM
    Author     : votra
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
    </head>
    <body>
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
        <h1>WELCOME TO FITCHEW FARM</h1>
        <form action="MainController">
            Name: <input type="text" name="search" value="<%= search%>" required=""/>
            <input type="submit" name="action" value="Search Product"/>
        </form>
        <%
            List<ProductDTO> list = (List<ProductDTO>) request.getAttribute("LIST_PRODUCT");
            if (list != null && list.size() > 0) {
        %>
        <table border="1">
            <thead>
                <tr>
                    <th>No</th>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Price</th>
                    <th>Quantity</th>
                    <th>Add</th>
                </tr>
            </thead>
            <tbody>
                <%
                    int count = 1;
                    for (ProductDTO product : list) {


                %>
            <form action="MainController" method="POST">
                <tr>
                    <td><%= count++%></td>
                    <td>
                        <input type="text" name="id" value="<%= product.getId()%>" readonly=""/>
                    </td>
                    <td><%= product.getName()%></td>
                    <td><%= product.getPrice()%></td>
                    <td><%= product.getQuantity()%></td>
                    <!--them san pham vao gio hang-->
                    <td>
                        <input type="number" name="quantity" value="1" required=""/>
                        <input type="hidden" name="search" value="<%= search%>" required=""/>
                        <input type="submit" name="action" value="Add" />
                    </td>
                </tr>
            </form>

            <%                        }
            %>
        </tbody>
    </table>

    <%
        }
        String error = (String) request.getAttribute("ERROR");
        if (error == null) {
            error = "";
        }
    %>
    <%= error%>
    
    <%
        
        String message = (String) request.getAttribute("MESSAGE");
        if (message == null) {
            message = "";
        }
    %>
    <%= message%>
</body>
</html>
