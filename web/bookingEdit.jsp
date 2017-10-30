<%-- 
    Document   : bookingEdit
    Created on : 29/05/2017, 3:53:01 AM
    Author     : Hongming
--%>

<%@page import="uts.wsd.*"%>
<%@page import="uts.wsd.FlightApplication"%>
<%@page import="uts.wsd.dto.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin Booking Delete Page</title>
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
        <p align="right"> 
            <a href="main.jsp">Home</a> 
            |
            <%
                User user = (User) session.getAttribute("user");
                if (user != null) {
            %>
            <%=user.getName()%>
            |
            Customer
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
        <%
            if (request.getParameter("save") != null) {
                if (request.getParameter("seat") != null && !request.getParameter("seat").equals("")) {
                    int seat = Integer.parseInt(request.getParameter("seat"));
                    Booking activeBooking = bookingApp.getActiveBookingByUserID(user.getUserID());
                    if (activeBooking != null) {
                        if (activeBooking.getSeat() != seat) {
                            if (seat-activeBooking.getSeat() <= activeBooking.getFlight().getNumOfSeats()) {
                                flightApp.decreaseSeat(activeBooking.getFlight().getFlightID(), seat-activeBooking.getSeat());
                                listingApp.decreaseSeat(activeBooking.getFlight().getFlightID(), seat-activeBooking.getSeat());
                                bookingApp.changeSeat(activeBooking.getUser().getUserID(), seat-activeBooking.getSeat());
                                if (seat == 0) {
                                    bookingApp.cancelBooking(activeBooking.getUser().getUserID());
                                }
                            }
                        }
                    }
                }
            }
            Booking activeBooking = bookingApp.getActiveBookingByUserID(user.getUserID());
            if (activeBooking != null) {
        %>
        <h1>Booking details</h1>

        <form action="#" method="post">
            <table>
                <ol>Booking ID: <%=activeBooking.getBookingID()%>
                    <ul>  
                        <li>User
                            <ul>
                                <li>User ID: <%=activeBooking.getUser().getUserID()%></li>
                                <li>Full name: <%=activeBooking.getUser().getName()%></li>
                                <li>Email: <%=activeBooking.getUser().getEmail()%></li>
                                <li>Date of Birth: <%=DateFormat.HTML_DATE_FORMAT.format(activeBooking.getUser().getDOB())%></li>
                                <li>User type: <%=activeBooking.getUser().getType()%></li>
                            </ul>
                        </li>
                        <li>Flight
                            <ul>
                                <li>Flight ID: <%=activeBooking.getFlight().getFlightID()%></li>
                                <li>From: <%=activeBooking.getFlight().getFrom()%></li>
                                <li>To: <%=activeBooking.getFlight().getTo()%></li>
                                <li>Departure Date/Time: <%=DateFormat.DATETIME_FORMAT.format(activeBooking.getFlight().getdDateTime())%></li>
                                <li>Return Date/Time: <%=DateFormat.DATETIME_FORMAT.format(activeBooking.getFlight().getrDateTime())%></li>
                                <li>Price: <%=activeBooking.getFlight().getPrice()%></li>
                                <li>Available Seats: <%=activeBooking.getFlight().getNumOfSeats()%></li>
                                <li>Type: <%=activeBooking.getFlight().getType()%></li>
                            </ul>
                        </li>
                        <li>Booking Seat
                            <ul>
                                <input type="number" name="seat" placeholder="Seat" value="<%=activeBooking.getSeat()%>">
                            </ul>
                        </li>
                        <li>Description: <%=activeBooking.getDescription()%></li>
                    </ul>
                </ol>
                <tr><td><input type="submit" name="save" value="Save"></td></tr>
            </table>
        </form>
        <%
            } else {
                out.println("<p>You haven't made a booking.</p>");
            }
        %>
        <p align="right"><button type="button" name="back" onclick="history.back()">Back</button></p>
    </body>
</html>