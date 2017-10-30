<%-- 
    Document   : adminBookingEdit
    Created on : 28/05/2017, 12:10:20 AM
    Author     : ShiWei
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
        String xmlFilePath = application.getRealPath("WEB-INF/bookings.xml");
        String xsdFilePath = application.getRealPath("WEB-INF/bookings.xsd");
    %>

    <jsp:useBean id="bookingApp" class="uts.wsd.BookingApplication" scope="application">
        <jsp:setProperty name="bookingApp" property="xmlFilePath" value="<%=xmlFilePath%>" />
        <jsp:setProperty name="bookingApp" property="xsdFilePath" value="<%=xsdFilePath%>" />
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

        <%
            Bookings bookings = bookingApp.loadBookings();
            String editID = request.getParameter("edit");
            if (editID != null && !editID.equals("")) {
                int bookingID = Integer.parseInt(editID);
                Booking booking = bookingApp.getBookingByBookingID(bookingID);
                if (booking != null) {
                    session.setAttribute("booking", booking);
        %>
        <h1>Booking details</h1>
        <form action="adminBookingAction.jsp" method="POST">
            <table>
                <tr>
                    <td>
                        <ol>Booking ID: <%=booking.getBookingID()%>
                            <ul>  
                                <li>User
                                    <ul>
                                        <li>User ID: <%=booking.getUser().getUserID()%></li>
                                        <li>Full name: <%=booking.getUser().getName()%></li>
                                        <li>Email: <%=booking.getUser().getEmail()%></li>
                                        <li>Date of Birth: <%=DateFormat.HTML_DATE_FORMAT.format(booking.getUser().getDOB())%></li>
                                        <li>User type: <%=booking.getUser().getType()%></li>
                                    </ul>
                                </li>
                                <li>Flight
                                    <ul>
                                        <li>Flight ID: <%=booking.getFlight().getFlightID()%></li>
                                        <li>From: <%=booking.getFlight().getFrom()%></li>
                                        <li>To: <%=booking.getFlight().getTo()%></li>
                                        <li>Departure Date/Time: <%=DateFormat.DATETIME_FORMAT.format(booking.getFlight().getdDateTime())%></li>
                                        <li>Return Date/Time: <%=DateFormat.DATETIME_FORMAT.format(booking.getFlight().getrDateTime())%></li>
                                        <li>Price: <%=booking.getFlight().getPrice()%></li>
                                        <li>Available Seats: <%=booking.getFlight().getNumOfSeats()%></li>
                                        <li>Type: <%=booking.getFlight().getType()%></li>
                                    </ul>
                                </li>
                                <li>Booking Seat
                                    <ul>
                                        <input type="number" name="seat" placeholder="Seat" value="<%=booking.getSeat()%>" <%=booking.getDescription().equals("Canceled")?"disabled":""%> />
                                    </ul>
                                </li>
                                <li>Description 
                                    <ul>
                                        <input type ="radio" name="description" id="Active" value="Active"<%=booking.getDescription().equals("Active") ? "checked" : "disabled"%> />
                                        <label for="Active">Active</label>
                                        <input type ="radio" name="description" id="Canceled" value="Canceled"<%=booking.getDescription().equals("Canceled") ? " checked" : ""%> />
                                        <label for="Canceled">Canceled</label>
                                    </ul>
                                </li>
                            </ul>
                        </ol>
                    </td>
                </tr>
                <tr>
                    <td><input type="submit" name="save" value="Save" <%=booking.getDescription().equals("Canceled")?"disabled":""%> ></td>
                </tr>
            </table>
        </form>
        <p align="right"><button type="button" name="back" onclick="history.back()">Back</button></p>
        <%
                } else {
                    response.sendRedirect("error.jsp");
                }
            } else {
                response.sendRedirect("errorEdit.jsp");
            }
        %>
    </body>
</html>
