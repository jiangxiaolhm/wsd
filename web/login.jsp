<%-- 
    Document   : login
    Created on : 25/05/2017, 11:25:23 PM
    Author     : ShiWei
--%>

<%@page import="uts.wsd.dto.*"%>
<%@page import="uts.wsd.*"%>
<%@page import="uts.wsd.dao.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login</title>
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

            if (request.getParameter("email") == null
                    || request.getParameter("password") == null) {
                        firstTime = true; //check whether the email and password is null, if yes, then the user hasn't input anything
            } else {
                        firstTime = false; //the user has input something
                        if (request.getParameter("email") != null) {
                                email = request.getParameter("email");
                        }
                        password = request.getParameter("password");
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
                    <td>Username:</td>
                    <td>
                        <input type="text" name="email" placeholder="Email" value="<%=email%>">
                    </td>
                    <td>
                        <font color="red"><%=!firstTime & email.equals("") ? "Please enter the user name." : ""%></font>
                    </td>
                </tr>
                
                <tr>
                    <td>Password:</td>
                    <td>
                        <input type="password" name="password" placeholder="Password" value="<%=password%>">
                    </td>
                    <td>
                        <font color="red"><%=!firstTime & password.equals("") ? "Please enter the password." : ""%>
                    </td>
                </tr>
                
                <tr>
                    <td></td>
                    <td><input type="submit" value="Login"></td>
                </tr>     
                
                <%
                    if (!email.equals("")
                            && !password.equals("")) {
                        Users users = userApp.loadUsers();
                        User user = users.login(email, password);//check whether the email and password is matched
                        
                        if (user != null) {
                            session.setAttribute("user", user); //if the password is correct, set the user into session
                            String previousPage = (String)session.getAttribute("previousPage");
                                if (previousPage == null)
                                    previousPage = "main.jsp";
                                response.sendRedirect(previousPage);
                        } else { //if the password and username cannot match
                %>    

                <tr>
                    <td></td>
                    <td><font color="red"><%=user == null ? "Please check the username and password." : ""%></td>
                </tr>
                
                <%       }
                    }
                %>
            </table>
            
        </form>
            
        <p align="right"><button type="button" name="back" onclick="history.back()">Back</button></p>
        
    </body>
</html>
