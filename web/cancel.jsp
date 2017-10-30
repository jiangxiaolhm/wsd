<%-- 
    Document   : cancel
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
        <meta http-equiv="Refresh" content="2; url=main.jsp">
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
                String email = user.getEmail(); //get the email as username
                out.println("<h2>" + email + "</h2>");
                Booking userBooking = bookingApp.getActiveBookingByUserID(user.getUserID());
                if (userBooking != null) {
                    // restore flight available seat
                    flightApp.decreaseSeat(userBooking.getFlight().getFlightID(), -userBooking.getSeat());
                    listingApp.decreaseSeat(userBooking.getFlight().getFlightID(), -userBooking.getSeat());
                    bookingApp.changeSeat(userBooking.getUser().getUserID(), -userBooking.getSeat());
                    // cancel user booking.
                    bookingApp.cancelBooking(user.getUserID());
                }
                for (int i = 0; i < users.getList().size(); i++) { //search on all users
                    if (users.getList().get(i).getEmail().equals(email)) {
                        users.removeUser(users.getList().get(i));//remove this user from the user list
                        session.invalidate();
                        userApp.updateUsers(userXmlFilePath, userXsdFilePath, users);
                    }
                }
        %>
                <h2>Cancel membership successful.</h2>
        <%  }else {
                    response.sendRedirect("main.jsp");
            }
        %>

    </body>
</html>
