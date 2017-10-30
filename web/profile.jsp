<%-- 
    Document   : profile
    Created on : 25/05/2017, 3:45:51 PM
    Author     : ShiWei
--%>

<%@page import="java.util.Date"%>
<%@page import="uts.wsd.dto.*"%>
<%@page import="uts.wsd.*"%>
<%@page import="uts.wsd.dao.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Profile</title>
    </head>
    
    <body>
        <p align="right"> 
            <a href="main.jsp">Home</a> 
            |
            <%
                User user = (User) session.getAttribute("user");
                if (user != null) {
            %>

                <%=user.getName()%>
            |
                <% if (user.getType() != null && user.getType().equals("Admin")) {%>
                <a href="admin.jsp">Admin</a>
                <% } else {%> Customer <%}%>
            |
            <a href="booking.jsp">Booking</a>
            | 
            <a href="profile.jsp">Profile</a>            
            |
            <a href="logout.jsp">Logout</a>
             <%} else {%>
            <a href="login.jsp">Login</a>
            |
            <a href="register.jsp">Register</a>
                    <%}%>
        </p>

        <%
            if (user != null) {
                if (user.getEmail() != null) {
        %>

        <h1>My Account</h1>

        <form action="profileAction.jsp" method="POST">

            <table>
                <tr>
                    <td>User ID:</td>
                    <td><%= user.getUserID()%></td>
                </tr>
                <tr>
                    <td>Email:</td>
                    <td><%= user.getEmail()%></td>
                </tr>
                <tr>
                    <td>Full name:</td>
                    <td><%= user.getName()%></td>
                </tr>
                <tr>
                    <td>DOB:</td>
                    <td><%= DateFormat.HTML_DATE_FORMAT.format(user.getDOB())%></td>
                </tr>    
                <tr>
                    <td>Password:</td>
                    <td><input type="password" value="<%= user.getPassword()%>" name="password"></td>
                </tr>               
                <tr>
                    <td></td>
                    <td><input type="submit" value="Save"></td>
                    <td><a href="cancel.jsp">Cancel membership</a></td>
                </tr>
                
            </table>
        </form>
                
        <p align="right"><button type="button" name="back" onclick="history.back()">Back</button></p>

        <%  } else {
                    response.sendRedirect("login.jsp");//the user has not been logged in
                }
            } else {
                response.sendRedirect("login.jsp");//no such user exists
            }%>

    </body>
</html>
