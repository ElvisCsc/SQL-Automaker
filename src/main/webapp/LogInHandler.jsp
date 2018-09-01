<%-- 
    Document   : LogInHandler
    Created on : 01 Sep 2018, 11:05:01 AM
    Author     : Zach
--%>

<%@page import="javax.script.ScriptEngine"%>
<%@page import="javax.script.ScriptEngineManager"%>
<%@page import="com.csc3003s.sqlautomark.LogIn"%>
<%@page import="java.util.Base64.Decoder"%>
<%@page import="java.util.Base64"%>
<%@page import="java.util.Base64"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Logging In</title>
    </head>
    <body>
        <%
            ScriptEngineManager manager = new ScriptEngineManager();
            ScriptEngine engine = manager.getEngineByName("JavaScript");

            String u = request.getParameter("u");
            String p = request.getParameter("p");

            Decoder decoder = Base64.getDecoder();
            byte[] pass = decoder.decode(p);
            byte[] us = decoder.decode(u);

            String password = new String(pass);
            String user = new String(us);

            LogIn login = new LogIn(user, password);
            int role = login.LogInUser();

            if (role == 0)
            {
                
                response.sendRedirect("./teacherPortal.jsp?u="+user);
            }
            else if (role == 1)
            {
                 response.sendRedirect("./studentPortal.jsp?u="+user);
            }
            else if (role == 2)
            {
                response.sendRedirect("./LogIn.jsp");
            }
            else
            {

            }
        %>
    </body>
</html>
<script>
    function redir(url)
    {

        var x = url;
        window.location = x;
    }

</script>
