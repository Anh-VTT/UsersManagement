<%@page import="fa3w.user.UserDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Send Email</title>
        <link rel="stylesheet" href="css/emailStyle.css"/> 
    </head>
    <body class="email-body">
        <div class="email-container">
            <%
                UserDTO loginUser = (UserDTO) session.getAttribute("LOGIN_USER");
                if (loginUser == null || !"AD".equals(loginUser.getRoleID())) {
                    response.sendRedirect("login.jsp");
                    return;
                }
            %>
            <h1 class="main-title">Send a Test Email</h1>
            
            <form action="MainController" method="POST" class="email-form">
                <div class="form-group">
                    <label for="toEmail" class="form-label">Recipient Email:</label>
                    <input type="email" id="toEmail" name="toEmail" required class="form-input">
                    <input type="submit" name="action" value="SendEmail" class="btn btn-primary"/> 
                </div>
            </form>
            
            <div class="message-section">
                <% String error = (String) request.getAttribute("ERROR");
                    if (error == null) {
                        error = "";
                    }
                %>
                <div class="message error-message"><%= error%></div>
                
                <% String message = (String) request.getAttribute("MESSAGE");
                    if (message == null) {
                        message = "";
                    }
                %>
                <div class="message success-message"><%= message%></div>
            </div>
            
            <a href="admin.jsp" class="back-link">Back to Admin Page</a>
        </div>
    </body>
</html>