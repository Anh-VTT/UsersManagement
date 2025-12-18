<%-- 
    Document   : admin
    Created on : Dec 2, 2025, 3:36:51 PM
    Author     : hd
--%>

<%@page import="java.util.List"%>
<%@page import="fa3w.user.UserDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Administrator Page</title>
        <link rel="stylesheet" href="css/adminStyle.css"/>
    </head>
    <body>
        <%
            UserDTO loginUser = (UserDTO) session.getAttribute("LOGIN_USER");
            if (loginUser == null || !"AD".equals(loginUser.getRoleID())) {
                response.sendRedirect("login.jsp");
                return;
            }
            String search = request.getParameter("search");
            if (search == null)
                search = "";
        %>
        <div class="admin-container">
            <!-- Header Section -->
            <div class="header-section">
                <div class="welcome-text">Welcome: <%= loginUser.getFullName()%></div>
                <div class="logout-group">
                    <form action="MainController" method="POST" style="margin: 0;">
                        <input type="submit" name="action" value="Logout" class="btn-logout"/>
                    </form>
                    <a href="MainController?action=Logout" class="logout-link">Logout</a>
                </div>
            </div>

            <!-- Send Email Link -->
            <a href="MainController?action=Send Email" class="send-email-link">Send Email</a>

            <!-- Search Section -->
            <form action="MainController" class="search-section">
                <span class="search-label">Search</span>
                <input type="text" name="search" value="<%= search%>" required="" class="search-input"/>
                <input type="submit" name="action" value="Search" class="btn-search"/>
            </form>

            <!-- Table Container -->
            <%
                List<UserDTO> listUser = (List<UserDTO>) request.getAttribute("LIST_USER");
                if (listUser != null) {
                    if (listUser.size() > 0) {
            %>
            <div class="table-container">
                <table class="data-table">
                    <thead>
                        <tr>
                            <th class="col-no">No</th>
                            <th>User ID</th>
                            <th>Full Name</th>
                            <th>Role ID</th>
                            <th>Password</th>
                            <th>Update</th>
                            <th>Delete</th>
                        </tr>
                    </thead>
                    <tbody class="table-body">
                        <%
                            int count = 1;
                            for (UserDTO user : listUser) {
                        %>
                        <tr>
                    <form action="MainController" method="POST" style="display: contents;">
                        <td class="row-no"><%= count++%></td>
                        <td class="row-userid">
                            <input type="text" name="userID" value="<%= user.getUserID()%>" readonly="" class="table-input"/>
                        </td>
                        <td class="row-fullname">
                            <input type="text" name="fullName" value="<%= user.getFullName()%>" required="" class="table-input"/>
                        </td>
                        <td class="row-roleid">
                            <input type="text" name="roleID" value="<%= user.getRoleID()%>" required="" class="table-input"/>
                        </td>
                        <td class="row-password"><%= user.getPassword()%></td>
                        <td class="row-update">
                            <input type="submit" name="action" value="Update" class="btn-update"/>
                            <input type="hidden" name="search" value="<%= search%>"/>
                        </td>
                        <td class="row-delete">
                            <a href="MainController?action=Delete&userID=<%= user.getUserID()%>&search=<%= search%>" class="btn-delete">Delete</a>
                        </td>
                    </form>
                    </tr>
                    <%
                        }
                    %>
                    </tbody>
                </table>
            </div>
            <%
                    }
                }
            %>

            <!-- Error Message -->
            <%
                String error = (String) request.getAttribute("ERROR");
                if (error != null && !error.isEmpty()) {
            %>
            <div class="error-message"><%= error%></div>
            <%
                }
            %>
        </div>
    </body>
</html>
