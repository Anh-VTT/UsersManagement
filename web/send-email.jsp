<%@page import="fa3w.user.UserDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Send Email</title>
    </head>
    <body>
        <h1>Send a Test Email</h1>
        <%
            UserDTO loginUser = (UserDTO) session.getAttribute("LOGIN_USER");
            if (loginUser == null || !"AD".equals(loginUser.getRoleID())) {
                response.sendRedirect("login.jsp");
                return;
            }

        %>
        <form action="MainController" method="POST">
            <label for="toEmail">Recipient Email:</label>
            <input type="email" id="toEmail" name="toEmail" required>
            <!--<button type="submit">Gửi</button>-->
            <input type="submit" name="action" value="SendEmail"/> 
        </form>
        <br>
        
        <%        String error = (String) request.getAttribute("ERROR");
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
        </br>
        <a href="admin.jsp">Back to Admin Page</a>
    </body>
</html>
