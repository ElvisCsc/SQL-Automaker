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
Statement stmt2 = connection.createStatement();
            
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            
            
            String sql = "SELECT * FROM sqlautomarker.Users WHERE UserID='"+username+"';";
            ResultSet rs = stmt.executeQuery(sql);
            
            
            String sql2 = "SELECT Password FROM sqlautomarker.Password where UserID='"+username+"';";
            ResultSet rs2 = stmt2.executeQuery(sql2);
            
            while(rs.next()&&rs2.next())
            {
                if (rs2.getString("Password").equals(password))
                    {
                        System.out.println("match");
                        if (rs.getString("Role").equals("Lecturer"))
                            {
                                 response.sendRedirect("\\teacherPortal.jsp");
                                 
                            }
                        if (rs.getString("Role").equals("Student"))
                            {
                                
                            }
                    }
                else
                {
                    System.out.println("no match");
                }
            }
            //rs.next();

            
            // response.setStatus(response.SC_MOVED_TEMPORARILY);
            // response.setHeader("Location", site); 
            // System.out.println("YES");
            //  System.out.println(username);
            //System.out.println(password);
           

        %>

    </body>
</html>
