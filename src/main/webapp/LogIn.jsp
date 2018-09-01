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
        <title>Log In</title>
        <link rel="stylesheet" type="text/css" href="style.css">   
        <link href="login.css" rel="stylesheet" type="text/css">
    </head>
    <body >
        <div class="login-box">
            <img src="avatar.png" class="avatar">
            <h1>Login</h1>
            <form action="LogIn.jsp" method="post">
                <p style="font-size: medium">Username</p>
                <input type="text" name="username" id="username" placeholder="Enter Username">
                <p style="font-size: medium">Password</p>
                <input type="password" name="password" id="password" placeholder="Enter Password">
                <input type="button" name="submit" value="Login" onclick="Javascript: newTab();">
                <%--a href="#">Forget Password</a--%>    
            </form>
        </div>
    </body>
</html>

<script>
    function newTab()
    {
        var user = document.getElementById("username").value;
        var password = document.getElementById("password").value;

        if (user == '' || password == '')
        {
            alert('incorrect');

        }
        else
        {
            var u = btoa(user);
            var p = btoa(password);
            var url = "LogInHandler.jsp?u=" + u + "&p=" + p;
            redir(url);
        }

    }

    function redir(url)
    {

        var x = url;
        window.location = x;
    }

</script>
