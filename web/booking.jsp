<%-- 
    Document   : booking
    Created on : 27/05/2017, 5:26:16 PM
    Author     : Hongming
--%>

<%@page import="uts.wsd.dto.Flights"%>
<%@page import="uts.wsd.dto.Flight"%>
<%@page import="uts.wsd.DateFormat"%>
<%@page import="java.util.ArrayList"%>
<%@page import="uts.wsd.dto.Booking"%>
<%@page import="uts.wsd.dto.Bookings"%>
<%@page import="uts.wsd.dto.Listings"%>
<%@page import="uts.wsd.dto.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Booking Page</title>
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
    <!-- Navigation -->
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
        <% } else { %> Customer <%}%>
        |
        <a href="booking.jsp">Booking</a>
        | 
        <a href="profile.jsp">Profile</a>            
        |
        <a href="logout.jsp">Logout</a>
        <% } else { %>
        <a href="login.jsp">Login</a>
        |
        <a href="register.jsp">Register</a>
        <%}%>
    </p>
    <%
        if (user == null)
            response.sendRedirect("error.jsp");
        else {
            if (request.getParameter("addListing") != null) {
                String flightIDs[] = request.getParameterValues("flightID");
                if (flightIDs != null) {
                    Flight flight;
                    ArrayList<Flight> flightList = new ArrayList<Flight>();
                    for (int i = 0; i < flightIDs.length; i++) {
                        flight = flightApp.getFlightByFlightID(flightIDs[i]);
                        if (flight != null)
                            flightList.add(flight);
                    }
                    if (flightList.size() > 0 && listingApp.createListing(user, flightList))
                        out.println("<p>You already add a listing successfully.</p>");
                    else
                        out.println("<p>Error, we can't add a listing.</p>");
                } else
                    out.println("<p>Please select flights to make a listing.</p>");
            } else if (request.getParameter("deleteListing") != null) {
                String listingID = request.getParameter("listingID");
                if (listingID != null) {
                    if (listingApp.closeListing(Integer.parseInt(listingID)))
                        out.println("<p>You already delete a listing successfully.</p>");
                    else
                        out.println("<p>Error, we can't delete a listing.</p>");
                } else
                    out.println("<p>Please select a listing for delete.</p>");
            } else if (request.getParameter("makeBooking") != null) {
                String flightID = request.getParameter("flightID");
                if (bookingApp.getActiveBookingByUserID(user.getUserID()) == null) {
                    if (flightID != null) {
                        Flight flight = flightApp.getFlightByFlightID(flightID);
                        if (flight != null) {
                            if (flight.getNumOfSeats() > 0) {
                                if (flightApp.decreaseSeat(flightID, 1) && listingApp.decreaseSeat(flightID, 1)) {
                                    if (bookingApp.createBooking(user, flight)) {
                                        out.println("<p>You already create a booking successfully.</p>");
                                    } else {
                                        flightApp.decreaseSeat(flightID, -1);
                                        listingApp.decreaseSeat(flightID, -1);
                                        out.println("<p>Error, can't create a booking.</p>");
                                    }
                                } else {
                                    out.println("<p>Error, can't decrease number of seats.</p>");
                                }
                            } else {
                                out.println("<p>Sorry, this flight have not enough seats.</p>");
                            }
                        } else {
                            out.println("<p>Error, can't find the flight.</p>");
                        }
                    } else {
                        out.println("<p>Please select a flight to make a booking.</p>");
                    }
                } else {
                    out.println("<p>Sorry, you must cancel current booking to make a new booking.");
                }
            } else if (request.getParameter("cancelBooking") != null) {
                Booking activeBooking = bookingApp.getActiveBookingByUserID(user.getUserID());
                if (activeBooking != null) {
                    flightApp.decreaseSeat(activeBooking.getFlight().getFlightID(), -activeBooking.getSeat());
                    listingApp.decreaseSeat(activeBooking.getFlight().getFlightID(), -activeBooking.getSeat());
                    bookingApp.changeSeat(user.getUserID(), -activeBooking.getSeat());
                    if (bookingApp.cancelBooking(user.getUserID()))
                        out.println("<p>You already cancel the booking successfully.</p>");
                }
            } else if (request.getParameter("editBooking") != null) {
                response.sendRedirect("bookingEdit.jsp");
            }

            Booking activeBooking = bookingApp.getActiveBookingByUserID(user.getUserID());
            if (activeBooking != null) {
    %>
    <p>Existing Booking</p>
    <fieldset border="1" style="width: 50%">
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
                        <li>Available Seat: <%=activeBooking.getFlight().getNumOfSeats()%></li>
                        <li>Type: <%=activeBooking.getFlight().getType()%></li>
                    </ul>
                </li>
                <li>Seat: <%=activeBooking.getSeat()%></li>
                <li>Description: <%=activeBooking.getDescription()%></li>
            </ul>
        </ol>
        <form method="post" action="#">
            <input type="submit" name="editBooking" value="Edit Booking" />
            <input type="submit" name="cancelBooking" value="Cancel Booking" />
        </form>
    </fieldset>
    
        <%  } else {    %>
    <p>Here is not Active Booking</p>
        <%  }   %>
        <%
            Listings activeListings = listings.getActiveListingsByUserID(user.getUserID());
            if (activeListings != null && activeListings.getList().size() > 0)  {
        %>
    <p>Existing Listings</p>
    <form method="post" action="#">
        <input type="submit" name="makeBooking" value="Make a Booking" />
        <input type="submit" name="deleteListing" value="Delete a Listing" />
        <table>
        <%
                for (int i = 0; i < activeListings.getList().size(); i++) {
                    if (i % 3 == 0 && i != 0)
                        out.println("</tr>");
                    if (i % 3 == 0 )
                        out.println("<tr>");
        %>
                <td valign="top">
                    <label for="<%=activeListings.getList().get(i).getListingID()%>">
                        <fieldset border="1">
                            <ol>Listing ID: <%=activeListings.getList().get(i).getListingID()%>
                                <input type ="radio" id="<%=activeListings.getList().get(i).getListingID()%>" name="listingID" value="<%=activeListings.getList().get(i).getListingID()%>"/>
                                <ul>
                    <%
                        for (Flight flight : activeListings.getList().get(i).getFlights()) {
                    %>
                                    <li>Flight ID: <%=flight.getFlightID()%>
                                        <input type ="radio" id="<%=activeListings.getList().get(i).getListingID()+"_"+flight.getFlightID()%>" name="flightID" value="<%=flight.getFlightID()%>"/>
                                        <label for="<%=activeListings.getList().get(i).getListingID()+"_"+flight.getFlightID()%>">
                                            <ul>
                                                <li>From: <%=flight.getFrom()%></li>
                                                <li>To: <%=flight.getTo()%></li>
                                                <li>Departure Date/Time: <%=DateFormat.DATETIME_FORMAT.format(flight.getdDateTime())%></li>
                                                <li>Return Date/Time: <%=DateFormat.DATETIME_FORMAT.format(flight.getrDateTime())%></li>
                                                <li>Price: <%=flight.getPrice()%></li>
                                                <li>Available Seat: <%=flight.getNumOfSeats()%></li>
                                                <li>Type: <%=flight.getType()%></li>
                                            </ul>
                                        </label>
                                    </li>
                    <%  }   %>
                                    <li>Description: <%=activeListings.getList().get(i).getDescription()%></li>
                                </ul>
                            </ol>
                        </fieldset>
                    </label>
                </td>
            <%  }   %>
            </tr>
        </table>
    </form>
        <%  } else {   %>
    <p>You haven't create a list.</p>
        <%  }   %>
    <%  }   %>
    <button type="button" name="back" onclick="history.back()">Back</button>
</body>
</html>
