<%-- 
    Document   : LogIn
    Created on : 02 Aug 2018, 4:21:43 PM
    Author     : Zach
--%>

<%@page import="java.sql.*"%>
<%@page import="com.csc3003s.sqlautomark.LogIn"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>


        <%

            Connection conn = DriverManager.getConnection("jdbc:mysql://sqlautomarker.cdtrwjzldbjr.us-east-1.rds.amazonaws.com:3306/?user=mltzac001", "mltzac001", "SQLauto2018");

            Statement stmt = conn.createStatement();

            String username = request.getParameter("username");
            String password = request.getParameter("password");
            String sql = "INSERT INTO `sqlautomarker`.`Users` (`StudentNumber`, `Password`) VALUES ('MLTZAC001', '123456');";

//
            stmt.executeUpdate(sql);
            //rs.next();

            String site = new String("http://www.photofuntoos.com");
            // response.setStatus(response.SC_MOVED_TEMPORARILY);
            // response.setHeader("Location", site); 
            // System.out.println("YES");
            //  System.out.println(username);
            //System.out.println(password);
            response.sendRedirect("/teacher_portal.html");

        %>

    </body>
</html>
