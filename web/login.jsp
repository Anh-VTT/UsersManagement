<%-- 
    Document   : login
    Created on : Dec 1, 2025, 4:40:03 PM
    Author     : hd
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login Page</title>
    </head>
    <body>
        <h1>Login Information</h1>
        <form action="MainController" method="POST">
            User Id:<input type="text" name="userID" required=""/></br>
            Password:<input type="password" name="password" required=""/></br>
            <input type="submit" name="action" value="Login"/>
            <input type="reset" value="Reset"/>
        </form>
        <%
            String error = (String) request.getAttribute("error");
            if (error == null)
                error = "";
        %>
        <%= error%>
    </body>
</html>
