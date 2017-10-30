<%-- 
    Document   : main
    Created on : 09/05/2017, 12:57:01 AM
    Author     : ShiWei
--%>

<%@page import="uts.wsd.dto.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Main page</title>
</head>
<%
    session.setAttribute("previousPage", "main.jsp");
    boolean firstTime = true;
    String classType = "";
    String from = "";
    String to = "";
    String dDate = "";
    String rDate = "";
    String minPrice = "";
    String maxPrice = "";
    
    if (request.getParameter("from") == null ||
        request.getParameter("to") == null ||
        request.getParameter("dDate") == null ||
        request.getParameter("rDate") == null ||
        request.getParameter("minPrice") == null ||
        request.getParameter("maxPrice") == null) {
        firstTime = true;
    } else {
        firstTime = false;
        if (request.getParameter("classType") != null)
            classType = request.getParameter("classType");
        from = request.getParameter("from");
        to = request.getParameter("to");
        dDate = request.getParameter("dDate");
        rDate = request.getParameter("rDate");
        minPrice = request.getParameter("minPrice");
        maxPrice = request.getParameter("maxPrice");
    }
    // Validate succesfully.
    if (!classType.equals("") &&
        !from.equals("") &&
        !to.equals("") &&
        !dDate.equals("")) {
        response.sendRedirect("results.jsp?classType="+classType+"&from="+from+"&to="+to+"&dDate="+dDate+"&rDate="+rDate+"&minPrice="+minPrice+"&maxPrice="+maxPrice);
    }
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
    <form method="post" action="#">
        <table align="center">
            <tr>
                <td>Class Type<font color="red">*</font>:</td>
                <td><input type ="radio" name="classType" id="economy" value="Economy"<%=classType.equals("Economy")?" checked":""%> /><label for="economy">Economy</label></td>
                <td><input type ="radio" name="classType" id="business" value="Business"<%=classType.equals("Business")?" checked":""%> /><label for="business">Business</label></td>
                <td><font color="red"><%=!firstTime&classType.equals("")?"Please select a class type.":""%></font></td>
            </tr>
            <tr>
                <td>From City<font color="red">*</font>:</td>
                <td>
                    <input list="from_list" name="from" id="from" style="width: 90%;" value="<%=from%>" />
                    <datalist id="from_list">
                        <option value ="Sydney" />
                        <option value ="Melbourne" />
                        <option value ="Brisbane" />
                        <option value ="Perth" />
                        <option value ="Cairns" />
                        <option value ="Adelaide" />
                        <option value ="Darwin" />
                        <option value ="Canberra" >
                        <option value ="Hobart" />
                        <option value ="Exmouth And Ningallo Reef" />
                        <option value ="Hamilton And Hayman Island" />
                        <option value ="Broome" />
                        <option value ="Gold Coast" />
                    </datalist>
                </td>
                <td>To City<font color="red">*</font>:</td>
                <td> 
                    <input list="to_list" name="to" id="to" style="width: 90%;" value="<%=to%>" />
                    <datalist id="to_list">
                        <option value ="Sydney" />
                        <option value ="Melbourne" />
                        <option value ="Brisbane" />
                        <option value ="Perth" />
                        <option value ="Cairns" />
                        <option value ="Adelaide" />
                        <option value ="Darwin" />
                        <option value ="Canberra" />
                        <option value ="Hobart" />
                        <option value ="Exmouth And Ningallo Reef" />
                        <option value ="Hamilton And Hayman Island" />
                        <option value ="Broome" />
                        <option value ="Gold Coast" />
                    </datalist>
                </td>
            </tr>
            <tr>
                <td></td>
                <td><font color="red"><%=!firstTime&from.equals("")?"Please enter a from city.":""%></font></td>
                <td></td>
                <td><font color="red"><%=!firstTime&to.equals("")?"Please enter a to city.":""%></td>
            </tr>
            <tr>
                <td>Departure Date<font color="red">*</font>:</td>
                <td><input type="date" name="dDate" id="d_date" style="width: 90%;" value="<%=dDate%>" /></td>
                <td>Return Date:</td>
                <td><input type="date" name="rDate" id="r_date" style="width: 90%;" value="<%=rDate%>" /></td>
            </tr>
            <tr>
                <td></td>
                <td><font color="red"><%=!firstTime&dDate.equals("")?"Please enter a departure date.":""%></td>
            </tr>
            <tr>
                <td>Min Price:</td>
                <td><input type="number" name="minPrice" id="min_price" style="width: 90%;" placeholder="0" value="<%=minPrice%>" /></td>
                <td>Max Price:</td>
                <td><input type="number" name="maxPrice" id="max_price" style="width: 90%;" placeholder="9999" value="<%=maxPrice%>" /></td>
            </tr>
            <tr>
                <td colspan="4" align="center"><input type="submit" value="Search"></td>
            </tr>
        </table>            
    </form>
</body>
</html>