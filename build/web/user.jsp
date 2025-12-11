<%-- 
    Document   : user
    Created on : Dec 2, 2025, 3:36:44 PM
    Author     : hd
--%>

<%@page import="fa3w.user.UserDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>User Page</title>
    </head>
    <body>
        <h1>Login user's information</h1>
        <%
            UserDTO loginUser = (UserDTO) session.getAttribute("LOGIN_USER");
            if (loginUser == null || !"US".equals(loginUser.getRoleID())) {
                response.sendRedirect("login.jsp");
                return;
            }

        %>
        User ID:<%= loginUser.getUserID()%></br>
        Full Name:<%= loginUser.getFullName()%></br>
        Role ID:<%= loginUser.getRoleID()%></br>
        Password:<%= loginUser.getPassword()%></br>
        <a href="MainController?action=Shopping Page">Fitchew Shop</a>
        <form action="MainController" method="POST">
            <input type="submit" name="action" value="Shopping Page"/>
        </form>
    </body>
</html>
