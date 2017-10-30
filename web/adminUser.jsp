<%-- 
    Document   : adminUser
    Created on : 27/05/2017, 4:01:10 PM
    Author     : ShiWei
--%>

<%@page import="uts.wsd.*"%>
<%@page import="java.util.*"%>
<%@page import="uts.wsd.dto.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin User</title>
    </head>
    <%  //String filePath = application.getRealPath("WEB-INF/users.xml");
        String xmlFilePath = application.getRealPath("WEB-INF/users.xml");
        String xsdFilePath = application.getRealPath("WEB-INF/users.xsd");
    %>

    <jsp:useBean id="userApp" class="uts.wsd.UserApplication" scope="application">
        <jsp:setProperty name="userApp" property="xmlFilePath" value="<%=xmlFilePath%>" />
        <jsp:setProperty name="userApp" property="xsdFilePath" value="<%=xsdFilePath%>" />
    </jsp:useBean>
    <% //Users users = userApp.loadUsers();%>
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

        <form method="post" action="adminUserDelete.jsp" >
            <table align="center" border="1">
                <h2 align="center">User</h2>
                <tr>
                    <th>ID</th>
                    <th>Email</th>
                    <th>Full name</th>
                    <th>Date of Birth</th>
                    <th>Type</th>
                    <th>Cancel</th>
                </tr>
                <% Users users = userApp.loadUsers();
                    //String email = request.getParameter("email");
                    for (int i = 0; i < users.getList().size(); i++) {
                %>
                <tr>
                    <td>
                        <%=users.getList().get(i).getUserID()%>

                        <!--                        <input type="text" name="ID" placeholder="CANNOT CHANGE" value="">-->
                    </td>
                    <td><%=users.getList().get(i).getEmail()%>
                        <!--                        <input type="text" name="ID" placeholder="CANNOT CHANGE" value="">-->
                    </td>
                    <td><%=users.getList().get(i).getName()%></td>
                    <td><%=DateFormat.HTML_DATE_FORMAT.format(users.getList().get(i).getDOB())%></td>
                    <td><%=users.getList().get(i).getType()%></td>
                    <td> <input type ="radio" name="delete" value="<%=users.getList().get(i).getUserID()%>"/></td>
                </tr>

                <%

//                        int deleteID = Integer.parseInt(request.getParameter("delete"));
//                        out.println("<h1>" + deleteID + "</h1>");
//                        if (users.getList().get(i).getEmail().equals(email)) {
//                            users.removeUser(users.getList().get(i));//remove this user from the user list
//                            //userApp.setUsers(users);
//                            //session.invalidate();
//                            userApp.updateUsers(xmlFilePath, xsdFilePath, users);
//                            //UsersPrinter.html.print(xmlFilePath, out);//used to verify
//                        }
                    }%>

            </table>
            <p align="center"><input type ="submit" name="Delete" value="Delete Membership"/></p>

        </form>
        <form method="get" action="admin.jsp" align="right"><input type="submit" value="Back" /></form>
    </body>
</html>
