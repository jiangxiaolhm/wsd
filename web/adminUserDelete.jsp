<%-- 
    Document   : Cancel
    Created on : 26/05/2017, 7:41:29 PM
    Author     : ShiWei
--%>

<%@page import="java.util.*"%>
<%@page import="uts.wsd.dom.*"%>
<%@page import="uts.wsd.dto.*"%>
<%@page import="uts.wsd.*"%>
<%@page import="uts.wsd.dao.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Refresh" content="2; url=adminUser.jsp">
        <title>Cancel</title>
    </head>
<%
    String userXmlFilePath = application.getRealPath("WEB-INF/users.xml");
    String userXsdFilePath = application.getRealPath("WEB-INF/users.xsd");
    String bookingsXmlFilePath = application.getRealPath("WEB-INF/bookings.xml");
    String bookingsXsdFilePath = application.getRealPath("WEB-INF/bookings.xsd");
    String listingsXmlFilePath = application.getRealPath("WEB-INF/listings.xml");
    String listingsXsdFilePath = application.getRealPath("WEB-INF/listings.xsd");
    String flightsXmlFilePath = application.getRealPath("WEB-INF/flights.xml");
    String flightsXsdFilePath = application.getRealPath("WEB-INF/flights.xsd");
%>
<jsp:useBean id="userApp" class="uts.wsd.UserApplication" scope="application">
    <jsp:setProperty name="userApp" property="xmlFilePath" value="<%=userXmlFilePath%>" />
    <jsp:setProperty name="userApp" property="xsdFilePath" value="<%=userXsdFilePath%>" />
</jsp:useBean>
<jsp:useBean id="bookingApp" class="uts.wsd.BookingApplication" scope="application">
    <jsp:setProperty name="bookingApp" property="xmlFilePath" value="<%=bookingsXmlFilePath%>" />
    <jsp:setProperty name="bookingApp" property="xsdFilePath" value="<%=bookingsXsdFilePath%>" />
</jsp:useBean>
<jsp:useBean id="listingApp" class="uts.wsd.ListingApplication" scope="application">
    <jsp:setProperty name="listingApp" property="xmlFilePath" value="<%=listingsXmlFilePath%>" />
    <jsp:setProperty name="listingApp" property="xsdFilePath" value="<%=listingsXsdFilePath%>" />
</jsp:useBean>
<jsp:useBean id="flightApp" class="uts.wsd.FlightApplication" scope="application">
    <jsp:setProperty name="flightApp" property="xmlFilePath" value="<%=flightsXmlFilePath%>" />
    <jsp:setProperty name="flightApp" property="xsdFilePath" value="<%=flightsXsdFilePath%>" />
</jsp:useBean>
<%
    Users users = userApp.loadUsers();
    Bookings bookings = bookingApp.loadBookings();
    Listings listings = listingApp.loadListings();
    Flights flights = flightApp.loadFlights();
%>
    <body>
        <%
            User user = (User) session.getAttribute("user");

            if (user != null) {
                String deleteID = request.getParameter("delete");
                if (deleteID != null) {
                    out.println("<h2>" + deleteID + "</h2>");
                    int userID = Integer.parseInt(deleteID);
                    Booking userBooking = bookingApp.getActiveBookingByUserID(userID);
                    if (userBooking != null) {
                        // restore flight available seat
                        flightApp.decreaseSeat(userBooking.getFlight().getFlightID(), -userBooking.getSeat());
                        listingApp.decreaseSeat(userBooking.getFlight().getFlightID(), -userBooking.getSeat());
                        // cancel user booking.
                        bookingApp.cancelBooking(userID);
                    }
                    for (int i = 0; i < users.getList().size(); i++) {
                        if (users.getList().get(i).getUserID() == userID) {
                            //remove this user from the user list
                            users.removeUser(users.getList().get(i));
                            userApp.updateUsers(userXmlFilePath, userXsdFilePath, users);
        %>
        <h2>Cancel membership successful.</h2>
            <%
                        }
                    }
                } else {
            %>
        <h2>Please select a user.</h2>
        <%
                }
            } else {
                response.sendRedirect("main.jsp");
            }
        %>

    </body>
</html>
