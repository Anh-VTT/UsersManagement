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
        <link rel="stylesheet" href="css/loginStyle.css"/>
    </head>
    <body>
        <div class="login-container">
            <h1>Login Information</h1>
            <!--            <form action="MainController" method="POST">
                            User Id:<input type="text" name="userID" required=""/></br>
                            Password:<input type="password" name="password" required=""/></br>
                            <input type="submit" name="action" value="Login"/>
                            <input type="reset" value="Reset"/>
                        </form>
                        <form action="MainController" method="POST">
                            <input type="submit" name="action" value="Create Page"/>
                        </form>-->
            <form action="MainController" method="POST">
                <div class="form-group">
                    <label for="userID">User ID</label>
                    <input type="text" id="userID" name="userID" required placeholder="Enter your user ID">
                </div>

                <div class="form-group">
                    <label for="password">Password</label>
                    <input type="password" id="password" name="password" required placeholder="Enter your password">
                </div>

                <div class="button-group">
                    <input type="submit" name="action" value="Login" class="btn-login">
                    <input type="reset" value="Reset" class="btn-reset">
                </div>
            </form>
            <div class="divider">
                <span>OR</span>
            </div>
            <div class="create-account">
                <a href="MainController?action=Create Page" class="btn-create">Create Page</a>
            </div>
            <div class="error-message" id="errorMessage">
                <%
                    String error = (String) request.getAttribute("ERROR");
                    if (error == null)
                        error = "";
                %>
                <%= error%>

            </div>
        </div>
        <% if (!error.isEmpty()) { %>
        <script>
            // Thêm class 'show' để hiển thị nếu CSS của bạn ẩn nó đi
            document.getElementById('errorMessage').classList.add('show');
        </script>
        <% }%>
    </body>
</html>
