<%-- 
    Document   : createPage
    Created on : Dec 8, 2025, 2:31:22 PM
    Author     : votra
--%>

<%@page import="fa3w.user.UserError"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Create user Page</title>
    </head>
    <body>
        <%
        UserError userError = (UserError) request.getAttribute("USER_ERROR");
        if(userError == null){
            userError = new UserError();
            }
        %>
        
        Create new user
        <form action="MainController" method="POST">
            User ID:<input type="text" name="userID" required=""/><%= userError.getUserIDError() %></br>
            Full Name:<input type="text" name="fullName" required=""/><%= userError.getFullNameError()%></br>
            Role ID:<input type="text" name="roleID" required=""/></br>
            Password:<input type="password" name="password" required=""/></br>
            Confirm:<input type="password" name="confirm" required=""/><%= userError.getConfirmError()%></br>
            <input type="submit" name="action" value="Create"/>
            <input type="reset" value="Reset"/>
            <%= userError.getError() %>
        </form>
    </body>
</html>
