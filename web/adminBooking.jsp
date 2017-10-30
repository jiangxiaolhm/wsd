<%-- 
    Document   : adminBooking
    Created on : 27/05/2017, 8:05:57 PM
    Author     : ShiWei
--%>

<%@page import="uts.wsd.*"%>
<%@page import="java.util.*"%>
<%@page import="uts.wsd.dto.*"%>
<%@page import="uts.wsd.dao.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin Booking</title>
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
            <%  } else {
                    response.sendRedirect("login.jsp");
                }%>
        </p>
        <h2 align="center">Booking</h2>
        <form method="post" action="adminBookingEdit.jsp">
            <table>
                <%

                    //Bookings bookings = bookingApp.getBookings();
                    Bookings bookings = bookingApp.loadBookings();
                    session.setAttribute("bookings", bookings);
                               if (bookings != null) {
                for (int i = 0; i < bookings.getList().size(); i++) {
                    if (i % 3 == 0 && i != 0)
                        out.println("</tr>");
                    if (i % 3 == 0 )
                        out.println("<tr>");
        %>
            <td>
                <label for="<%=bookings.getList().get(i).getBookingID()%>"><fieldset border="1">
                <ol>Booking ID: <%=bookings.getList().get(i).getBookingID()%>
                    <input type ="radio" id="<%=bookings.getList().get(i).getBookingID()%>" name="edit" value="<%=bookings.getList().get(i).getBookingID()%>" />
                    <ul>
                        <li>User
                            <ul>
                                <li>User ID: <%=bookings.getList().get(i).getUser().getUserID()%></li>
                                <li>Full name: <%=bookings.getList().get(i).getUser().getName()%></li>
                                <li>Email: <%=bookings.getList().get(i).getUser().getEmail()%></li>
                                <li>Date of Birth: <%=DateFormat.HTML_DATE_FORMAT.format(bookings.getList().get(i).getUser().getDOB())%></li>
                                <li>User type: <%=bookings.getList().get(i).getUser().getType()%></li>
                            </ul>
                        </li>
                        <li>Flight
                            <ul>
                                <li>Flight ID: <%=bookings.getList().get(i).getFlight().getFlightID()%></li>
                                <li>From: <%=bookings.getList().get(i).getFlight().getFrom()%></li>
                                <li>To: <%=bookings.getList().get(i).getFlight().getTo()%></li>
                                <li>Departure Date/Time: <%=DateFormat.DATETIME_FORMAT.format(bookings.getList().get(i).getFlight().getdDateTime())%></li>
                                <li>Return Date/Time: <%=DateFormat.DATETIME_FORMAT.format(bookings.getList().get(i).getFlight().getrDateTime())%></li>
                                <li>Price: <%=bookings.getList().get(i).getFlight().getPrice()%></li>
                                <li>Available Seats: <%=bookings.getList().get(i).getFlight().getNumOfSeats()%></li>
                                <li>Type: <%=bookings.getList().get(i).getFlight().getType()%></li>
                            </ul>
                        </li>
                        <li>Seat: <%=bookings.getList().get(i).getSeat()%></li>
                        <li>Description: <%=bookings.getList().get(i).getDescription()%></li>
                    </ul>
                </ol></fieldset></label>
            </td>
        <%          
                }
                out.println("</tr>");
            }
        %>
            </table>
            <p align="center"><input type ="submit" name="Edit" value="Edit"/></p>
        </form>
        <p align="right"><button type="button" name="back" onclick="history.back()">Back</button></p>
    </body>

</html>
