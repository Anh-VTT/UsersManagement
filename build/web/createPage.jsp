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
        <link rel="stylesheet" href="css/createPageStyle.css"/>
    </head>
    <body>
        <%
            UserError userError = (UserError) request.getAttribute("USER_ERROR");
            if (userError == null) {
                userError = new UserError();
            }
        %>

        <div class="create-container">
            <h1 class="page-title">Create new user</h1>

            <form action="MainController" method="POST">
                <div class="form-group">
                    <label class="form-label">User ID:</label>
                    <input type="text" name="userID" required="" class="form-input"/>
                    <span class="error-text"><%= userError.getUserIDError()%></span>
                </div>

                <div class="form-group">
                    <label class="form-label">Full Name:</label>
                    <input type="text" name="fullName" required="" class="form-input"/>
                    <span class="error-text"><%= userError.getFullNameError()%></span>
                </div>

                <div class="form-group">
                    <label class="form-label">Role ID:</label>
                    <input type="text" name="roleID" required="" class="form-input"/>
                </div>

                <div class="form-group">
                    <label class="form-label">Password:</label>
                    <input type="password" name="password" required="" class="form-input"/>
                </div>

                <div class="form-group">
                    <label class="form-label">Confirm:</label>
                    <input type="password" name="confirm" required="" class="form-input"/>
                    <span class="error-text"><%= userError.getConfirmError()%></span>
                </div>

                <div class="button-group">
                    <input type="submit" name="action" value="Create" class="btn-create"/>
                    <input type="reset" value="Reset" class="btn-reset"/>
                </div>

                <%
                    String generalError = userError.getError();
                    if (generalError != null && !generalError.isEmpty()) {
                %>
                <div class="general-error"><%= generalError%></div>
                <%
                    }
                %>
            </form>
        </div>
    </body>
</html>
