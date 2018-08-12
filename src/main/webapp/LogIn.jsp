<%-- 
    Document   : LogIn
    Created on : 02 Aug 2018, 4:21:43 PM
    Author     : Zach
--%>

<%@page import="com.csc3003s.sqlautomark.SQL"%>
<%@page import="java.sql.*"%>
<%@page import="com.csc3003s.sqlautomark.LogIn"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Redirect...</title>
    </head>
    <body>


        <%

            Connection connection = new SQL().getConnection();
            Statement stmt = connection.createStatement();

            String username = request.getParameter("username");
            String password = request.getParameter("password");
            //String sql = "INSERT INTO `sqlautomarker`.`Users` (`StudentNumber`, `Password`) VALUES ('"+username+"', '123456');";

//
          // stmt.executeUpdate(sql);
            //rs.next();

            
            // response.setStatus(response.SC_MOVED_TEMPORARILY);
            // response.setHeader("Location", site); 
            // System.out.println("YES");
            //  System.out.println(username);
            //System.out.println(password);
            response.sendRedirect("\\teacher_portal.jsp");

        %>

    </body>
</html>
