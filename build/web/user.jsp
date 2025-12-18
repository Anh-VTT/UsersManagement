<%-- 
    Document   : user
    Created on : Dec 2, 2025, 3:36:44 PM
    Author     : hd
--%>

<%@page import="fa3w.user.UserDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>User Page</title>
        <link rel="stylesheet" href="css/userStyle.css"/> 
    </head>
    <body class="user-body">
        
        <div class="user-container">
            <h1 class="main-title">Login user's information</h1>
            <%
                UserDTO loginUser = (UserDTO) session.getAttribute("LOGIN_USER");
                if (loginUser == null || !"US".equals(loginUser.getRoleID())) {
                    response.sendRedirect("login.jsp");
                    return;
                }
            %>
            
            <div class="user-info-section">
                <div class="info-item">User ID:<span class="info-value"><%= loginUser.getUserID()%></span></div>
                <div class="info-item">Full Name:<span class="info-value"><%= loginUser.getFullName()%></span></div>
                <div class="info-item">Role ID:<span class="info-value"><%= loginUser.getRoleID()%></span></div>
                <div class="info-item">Password:<span class="info-value"><%= loginUser.getPassword()%></span></div>
            </div>

            <div class="button-group">
                <a href="MainController?action=Shopping Page" class="btn btn-link primary-link">Fitchew Shop</a>
                
                <form action="MainController" method="POST" class="form-btn">
                    <input type="submit" name="action" value="Shopping Page" class="btn btn-secondary"/>
                </form>
                
                <form action="MainController" method="POST" class="form-btn">
                    <input type="submit" name="action" value="Logout" class="btn btn-primary"/>
                </form>
                
                <a href="MainController?action=Logout" class="btn btn-link primary-link">Logout</a>
            </div>
        </div>
    </body>
</html>