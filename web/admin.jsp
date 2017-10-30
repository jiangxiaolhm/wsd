<%-- 
    Document   : admin
    Created on : 27/05/2017, 7:27:25 PM
    Author     : ShiWei
--%>

<%@page import="uts.wsd.dto.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin</title>
    </head>
    <%  //String filePath = application.getRealPath("WEB-INF/users.xml");
        String xmlFilePath = application.getRealPath("WEB-INF/users.xml");
        String xsdFilePath = application.getRealPath("WEB-INF/users.xsd");
    %>

    <jsp:useBean id="userApp" class="uts.wsd.UserApplication" scope="application">
        <jsp:setProperty name="userApp" property="xmlFilePath" value="<%=xmlFilePath%>" />
        <jsp:setProperty name="userApp" property="xsdFilePath" value="<%=xsdFilePath%>" />
    </jsp:useBean>
    <body>
        <p align="right"> 
            <a href="main.jsp">Home</a> 
            |
            <%
                User user = (User) session.getAttribute("user");
                if (user != null && user.getType().equals("Admin")) {
            %>

            <%=user.getName()%>
            |
            <a href="admin.jsp">Admin</a>
            |
            <a href="booking.jsp">Booking</a>
            | 
            <a href="profile.jsp">Profile</a>            
            |
            <a href="logout.jsp">Logout</a>
            <%} else {
                    response.sendRedirect("login.jsp");
                }%>
        </p>
        <p align="center">
            <a href="adminUser.jsp">Manage Users</a>
            |
            <a href="adminBooking.jsp">Manage Bookings</a>
        </p>
        
        <p align="right"><button type="button" name="back" onclick="history.back()">Back</button></p>
        
    </body>
</html>
