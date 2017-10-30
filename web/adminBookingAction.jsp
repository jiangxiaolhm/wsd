<%-- 
    Document   : text3
    Created on : 29/05/2017, 3:30:20 AM
    Author     : ShiWei
--%>

<%@page import="uts.wsd.dto.*"%>
<%@page import="uts.wsd.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Refresh" content="2; url=adminBooking.jsp">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin Booking Action</title>
    </head>
<%
    String bookingsXmlFilePath = application.getRealPath("WEB-INF/bookings.xml");
    String bookingsXsdFilePath = application.getRealPath("WEB-INF/bookings.xsd");
    String listingsXmlFilePath = application.getRealPath("WEB-INF/listings.xml");
    String listingsXsdFilePath = application.getRealPath("WEB-INF/listings.xsd");
    String flightsXmlFilePath = application.getRealPath("WEB-INF/flights.xml");
    String flightsXsdFilePath = application.getRealPath("WEB-INF/flights.xsd");
%>
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
    Bookings bookings = bookingApp.loadBookings();
    Listings listings = listingApp.loadListings();
    Flights flights = flightApp.loadFlights();
%>
    <body>
        <%
            Booking booking = (Booking) session.getAttribute("booking");
            String description = request.getParameter("description");
            String strSeat = request.getParameter("seat");
            if (booking != null && booking.getDescription().equals("Active") && description != null && strSeat != null && !strSeat.equals("")) {
                int seat = Integer.parseInt(strSeat); //convert the input of seat from String to int
                if (description.equals("Active") && seat != 0) { //if the booking is active and the seat changes
                    flightApp.decreaseSeat(booking.getFlight().getFlightID(), seat-booking.getSeat());
                    listingApp.decreaseSeat(booking.getFlight().getFlightID(), seat-booking.getSeat());
                    bookingApp.changeSeat(booking.getUser().getUserID(), seat-booking.getSeat());
                    out.println("<p>Booking is changed successfully.</p>");
                } else if (description.equals("Canceled") || seat == 0) {  //if the booking is canceled, set the seat to 0, and return the seats to flights and listings.
                    flightApp.decreaseSeat(booking.getFlight().getFlightID(), -booking.getSeat());
                    listingApp.decreaseSeat(booking.getFlight().getFlightID(), -booking.getSeat());
                    bookingApp.changeSeat(booking.getUser().getUserID(), -booking.getSeat());
                    if (bookingApp.cancelBooking(booking.getUser().getUserID()))
                        out.println("<p>Booking is canceled successfully.</p>");
                } else {
                    response.sendRedirect("error.jsp");
                }
            } else {
                response.sendRedirect("error.jsp");
            }
        %>
    </body>
</html>
