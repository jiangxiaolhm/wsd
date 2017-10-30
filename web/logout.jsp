<%-- 
    Document   : logout
    Created on : 24/05/2017, 10:05:02 PM
    Author     : ShiWei
--%>

<%@page import="uts.wsd.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Refresh" content="2; url=main.jsp">
        <title>Logout</title>
    </head>
    
    <body>
        <%
            session.invalidate();//set the user session to invalidate to logout
        %>

        <h2>You have been logged out.</h2>
        
    </body>
</html>
