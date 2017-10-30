<%-- 
    Document   : Register
    Created on : 26/05/2017, 12:33:19 AM
    Author     : ShiWei
--%>

<%@page import="uts.wsd.dom.UsersPrinter"%>
<%@page import="java.util.*"%>
<%@page import="uts.wsd.dto.*"%>
<%@page import="uts.wsd.*"%>
<%@page import="uts.wsd.dao.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Register</title>
    </head>
    <%  //String filePath = application.getRealPath("WEB-INF/users.xml");
        String xmlFilePath = application.getRealPath("WEB-INF/users.xml");//get the XML file path of users
        String xsdFilePath = application.getRealPath("WEB-INF/users.xsd");//get the XSD file path of users
    %>

    <jsp:useBean id="userApp" class="uts.wsd.UserApplication" scope="application">
        <jsp:setProperty name="userApp" property="xmlFilePath" value="<%=xmlFilePath%>" />
        <jsp:setProperty name="userApp" property="xsdFilePath" value="<%=xsdFilePath%>" />
    </jsp:useBean>

    <body>
        <%
            boolean firstTime = true;
            String email = "";
            String password = "";
            String name = "";
            String DOB = "";

            if (request.getParameter("name") == null
                    || request.getParameter("email") == null
                    || request.getParameter("password") == null
                    || request.getParameter("DOB") == null) {
                firstTime = true; //check whether all data is null
            } else {
                firstTime = false;
                if (request.getParameter("email") != null) {
                    email = request.getParameter("email");
                }
                name = request.getParameter("name");
                password = request.getParameter("password");
                DOB = request.getParameter("DOB");
            }
        %>

        <p align="right"> 
            <a href="main.jsp">Home</a> 
            |
            <a href="login.jsp">Login</a>
            |
            <a href="register.jsp">Register</a>
        </p>

        <form method="post" action="#">
            <table align="center">
                <tr>
                    <td>Full Name:</td>
                    <td><input type="text" name="name" placeholder="Full Name" value="<%=name%>"></td>
                    <td><font color="red"><%=!firstTime & name.equals("") ? "Please enter the full name." : ""%></font></td>
                </tr>
                <tr>
                    <td>Email:</td>
                    <td><input type="text" name="email" placeholder="Email" value="<%=email%>"></td>
                    <td><font color="red"><%=!firstTime & email.equals("") ? "Please enter the email." : ""%></font></td>
                </tr>
                <tr>
                    <td>Password :</td>
                    <td><input type="password" name="password" placeholder="Password" value="<%=password%>"></td>
                    <td><font color="red"><%=!firstTime & password.equals("") ? "Please enter the password." : ""%></font></td>
                </tr>
                <tr>
                    <td>Date of Birth:</td>
                    <td><input type="date" name="DOB" placeholder="Date of Birth" value="<%=DOB%>"></td>
                    <td><font color="red"><%=!firstTime & DOB.equals("") ? "Please enter the date of birth." : ""%></font></td>
                </tr>
                <tr>
                    <td></td>
                    <td><input type="submit" value="Register"></td>
                </tr>
                <%
                    if (!email.equals("")
                            && !name.equals("")
                            && !password.equals("")
                            && !DOB.equals("")) {
                        Users users = userApp.loadUsers();
                        boolean existed = false;
                        for (int i = 0; i < users.getList().size(); i++) {
                            if (users.getList().get(i).getEmail().equals(email)) {//check whether the username has been used
                %>    

                <tr>
                    <td></td>
                    <td><font color="red"><%=users.getUser(email) != null ? i + "The email address has been used." : ""%></td>
                </tr>

                <%
                            existed = true;
                            break;
                            }
                        }
                        if (!existed) {
                            int userID = (new Random()).nextInt(999999); //to get user ID randomly
                            String type = "Customer";
                            User user = new User(userID, name, email, DateFormat.HTML_DATE_FORMAT.parse(DOB), password, type);
                            users.addUser(user); //add new user into the user list

                        if (!userApp.updateUsers(xmlFilePath, xsdFilePath, users)) {//check whether the input data in validate to XSD
                            users.removeUser(user);
                            //out.println("false");
                %>
                <tr>
                    <td></td>
                    <td><font color="red">Invalid email address, please enter the validate email address.</td>
                </tr>
                <%
                            } else {
                                session.setAttribute("user", user);//set the attribute of user into the session
                                String previousPage = (String)session.getAttribute("previousPage");
                                if (previousPage == null)
                                    previousPage = "main.jsp";
                                response.sendRedirect(previousPage);
                            }
                            //UsersPrinter.html.print(filePath, out);
                        }
                    }
                %>
            </table>            
        </form>
        <p align="right"><button type="button" name="back" onclick="history.back()">Back</button></p>
    </body>
</html>
