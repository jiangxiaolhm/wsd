<%-- 
    Document   : profileAction
    Created on : 25/05/2017, 4:13:09 PM
    Author     : ShiWei
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Date"%>
<%@page import="uts.wsd.dto.*"%>
<%@page import="uts.wsd.*"%>
<%@page import="uts.wsd.dao.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Refresh" content="2; url=main.jsp">
        <title>Profile Action</title>
    </head>
    <body>
        <%  //String filePath = application.getRealPath("WEB-INF/users.xml");
            String xmlFilePath = application.getRealPath("WEB-INF/users.xml");//get the XML file path of users
            String xsdFilePath = application.getRealPath("WEB-INF/users.xsd");//get the XSD file path of users
        %>

        <jsp:useBean id="userApp" class="uts.wsd.UserApplication" scope="application">
            <jsp:setProperty name="userApp" property="xmlFilePath" value="<%=xmlFilePath%>" />
            <jsp:setProperty name="userApp" property="xsdFilePath" value="<%=xsdFilePath%>" />
        </jsp:useBean>

        <%
            Users users = userApp.loadUsers(); //get all users
            User user = (User) session.getAttribute("user"); //get the user session
            if (user != null) {
                String email = user.getEmail();
                String password = request.getParameter("password");
                //String name = request.getParameter("name");
                //String ID = request.getParameter("userID");
                //Date DOB = DateFormat.HTML_DATE_FORMAT.parse(request.getParameter("DOB"));
                //user.setName(name);//not allow user to change the name
                //user.setEmail(email);//Email is used to maintain this account, cannot be changed
                if (password != null && !password.equals("")) {
                    for (int i = 0; i < users.getList().size(); i++) {
                        if (users.getList().get(i).getEmail().equals(email)) {
                            users.getList().get(i).setPassword(password);//allow user to change the password
                            user.setPassword(password);
                            //user.setDOB(DOB);//not allow user to change the DOB
                            
                            userApp.updateUsers(xmlFilePath, xsdFilePath, users);//save the change into the XML
                            //UsersPrinter.html.print(filePath, out);
                        }
                    }
                %> <h2>Details updated.</h2> <%
                } else {
                        %><h2>Password cannot be empty. Please enter the new password.</h2><%
                }
            } else {
                response.sendRedirect("main.jsp");
            }%>
    </body>
</html>
