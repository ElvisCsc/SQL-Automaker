<%-- 
    Document   : markAssessment
    Created on : 16 Aug 2018, 10:42:11 PM
    Author     : Zach
--%>

<%@page import="com.csc3003s.sqlautomark.MarkQuestion"%>
<%@page import="com.csc3003s.sqlautomark.Question"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.csc3003s.sqlautomark.SQL"%>
<%@page import="java.util.Base64.*"%>
<%@page import="java.util.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="quiz.css" rel="stylesheet" type="text/css">
        <title>Results</title>
    </head>
    <body onload="Javascript: redir('yes');">

        <div class="loader"></div>
        <h2>Marking assessment...</h2>
        <h3>Please do not exit this page</h3>
        <%
            String s = request.getParameter("redir");

            Decoder decoder = Base64.getDecoder();
            byte[] q = decoder.decode(s);
            String st = new String(q);
        %>
        <p hidden id="red" name="red"><%=st%></p>



    </body>
</html>
<script>
    function redir(url)
    {

       var s = '<%=st%>';
       window.location = s;
    }


</script>
<style>

    h2{
        color: white;
         vertical-align: middle;
        text-align: center;

    }
    h3{
        color: white;
        vertical-align: middle;
        text-align: center;
    }
    .loader {

        position: absolute;
        left: 50%;
        top: 50%;
        z-index: 1;
        width: 150px;
        height: 150px;
        margin: -75px 0 0 -75px;
        border: 16px solid #f3f3f3;
        border-radius: 50%;
        border-top: 16px solid #3498db;
        width: 120px;
        height: 120px;
        -webkit-animation: spin 2s linear infinite;
        animation: spin 2s linear infinite;
    }

    /* Safari */
    @-webkit-keyframes spin {
        0% { -webkit-transform: rotate(0deg); }
        100% { -webkit-transform: rotate(360deg); }
    }

    @keyframes spin {
        0% { transform: rotate(0deg); }
        100% { transform: rotate(360deg); }
    }
</style>
