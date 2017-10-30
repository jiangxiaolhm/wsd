<%-- 
    Document   : results
    Created on : May 16, 2017, 11:31:31 AM
    Author     : Hongming
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Random"%>
<%@page import="uts.wsd.DateFormat"%>
<%@page import="uts.wsd.dto.Listing"%>
<%@page import="uts.wsd.dto.Listings"%>
<%@page import="uts.wsd.dto.Flight"%>
<%@page import="uts.wsd.dto.Flights"%>
<%@page import="uts.wsd.dto.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Results Page</title>
</head>
<% 
    String previousPage = "results.jsp";
    if (request.getQueryString() != null)
        previousPage += '?' + request.getQueryString();
    session.setAttribute("previousPage", previousPage);
    String flightsXmlFilePath = application.getRealPath("WEB-INF/flights.xml");
    String flightsXsdFilePath = application.getRealPath("WEB-INF/flights.xsd");
%>
<jsp:useBean id="flightApp" class="uts.wsd.FlightApplication" scope="application">
    <jsp:setProperty name="flightApp" property="xmlFilePath" value="<%=flightsXmlFilePath%>" />
    <jsp:setProperty name="flightApp" property="xsdFilePath" value="<%=flightsXsdFilePath%>" />
</jsp:useBean>

<%
    Flights flights = flightApp.loadFlights();
%>
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
    <h2>Results</h2>
    <%
        if (request.getParameter("classType") == null||
            request.getParameter("from") == null ||
            request.getParameter("to") == null ||
            request.getParameter("dDate") == null ||
            request.getParameter("rDate") == null ||
            request.getParameter("minPrice") == null ||
            request.getParameter("maxPrice") == null) {
            response.sendRedirect("error.jsp");
        } else {
            String classType = request.getParameter("classType");
            String from = request.getParameter("from");
            String to = request.getParameter("to");

            Date dDateTime = DateFormat.HTML_DATE_FORMAT.parse(request.getParameter("dDate"));
            Date rDateTime = null;
            if (!request.getParameter("rDate").equals(""))
                rDateTime = DateFormat.HTML_DATE_FORMAT.parse(request.getParameter("rDate"));

            int minPrice = 0;
            if (!request.getParameter("minPrice").equals(""))
                minPrice = Integer.parseInt(request.getParameter("minPrice"));

            int maxPrice = 9999;
            if (!request.getParameter("maxPrice").equals(""))
                maxPrice = Integer.parseInt(request.getParameter("maxPrice"));

            ArrayList<Flight> results = flights.searchFlights(from, to, dDateTime, rDateTime, classType, minPrice, maxPrice);
            if (results.size() > 0) {
    %>
    <form method="post" action="booking.jsp">
        <table border="1">
            <tr>
                <th>Flight ID</th>
                <th>From</th>
                <th>To</th>
                <th>Departure Date/Time</th>
                <th>Return Date/Time</th>
                <th>Price</th>
                <th>Seat</th>
                <th>Type</th>
                <th>Select</th>
            </tr>
            <%  for (Flight f : results) {  %>
            <tr>
                <td><%=f.getFlightID()%></td>
                <td><%=f.getFrom()%></td>
                <td><%=f.getTo()%></td>
                <td><%=DateFormat.DATETIME_FORMAT.format(f.getdDateTime())%></td>
                <td><%=DateFormat.DATETIME_FORMAT.format(f.getrDateTime())%></td>
                <td><%=f.getPrice()+"AU$"%></td>
                <td><%=f.getNumOfSeats()%></td>
                <td><%=f.getType()%></td>
                <td align="center">
                    <input type="checkbox" name="flightID" value=<%="\""+f.getFlightID()+"\""%><%=session.getAttribute("user")!=null?"":" disabled"%> />
                </td>
            </tr>
            <%  }   %>
        </table>
        <input type="submit" name="addListing" value="Add a Listing" <%=session.getAttribute("user")!=null?"":" disabled"%> />
    </form>
            <%  if (session.getAttribute("user") == null) {%>
    <p><font color="red">Please login to add listing</font></p>
            <%  }   %>
        <%  } else {    %>
    <h1>No Flight Found.</h1>
        <%  }  %> 
    <%  }   %>
    <p align="right"><button type="button" name="back" onclick="history.back()">Back</button></p>
</body>
</html>
