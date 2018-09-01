<%-- 
    Document   : createAssessment
    Created on : 12 Aug 2018, 4:08:51 PM
    Author     : Zach
--%>

<%@page import="java.util.Base64.Decoder"%>
<%@page import="java.util.Base64"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.ResultSetMetaData"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="com.csc3003s.sqlautomark.*"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Assessment</title>
        <link href="quiz.css" rel="stylesheet" type="text/css">

        <link rel='stylesheet prefetch' href='https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css'>
        <link rel='stylesheet prefetch' href='https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css'>

    </head>
    <body>
        <div class="container"> 
            <section id="fancyTabWidget" class="tabs t-tabs">

                <div id="myTabContent" class="tab-content fancyTabContent" aria-live="polite">

                    <%

                        String a = request.getParameter("assessment");
                        String u = request.getParameter("user");
                        String at = request.getParameter("attempt");

                        Decoder decoder = Base64.getDecoder();
                        byte[] as = decoder.decode(a);
                        byte[] us = decoder.decode(u);
                        byte[] att = decoder.decode(at);

                        String assessment = new String(as);
                        String user = new String(us);
                        String attempt = new String(att);

                        ArrayList<Question> questions = new ArrayList<Question>();

                        Connection connection = new SQL().getConnection();
                        Statement statement = connection.createStatement();
                        statement.addBatch("use `sqlautomarker`;");
                        statement.executeBatch();

                        ResultSet rs1 = statement.executeQuery("Select * FROM assessments WHERE assessment_name='" + assessment + "';");
                        String database = "";

                        String attempts = "";
                        while (rs1.next())
                        {
                            database = rs1.getString("question_database");
                            attempts = rs1.getString("attempts");
                        }

                        int intAttempt = Integer.parseInt(attempt);
                        int intAttempts = Integer.parseInt(attempts);

                        if (intAttempt < intAttempts)
                        {
                            new Assessment().updateAssessment(user, assessment, database);
                        }

                        //System.out.println("intAttempt " + intAttempt);
                        //System.out.println("intAttempts " + intAttempts);
                        ArrayList<String> schemas = new ArrayList<String>();

                        statement.addBatch("use `" + database + "`;");
                        statement.executeBatch();

                        ResultSet rs2 = statement.executeQuery("SHOW TABLES;");

                        while (rs2.next())
                        {
                            String st = rs2.getString(1);
                            if (!st.equals("questions"))
                            {
                                schemas.add(st);
                            }
                        }
                    %>
                    <p hidden id="user"><%=user%></p>
                    <p hidden id="assessmet"><%=assessment%></p>
                    <%

                        ResultSet qrs = statement.executeQuery("SELECT * FROM questions;");

                        while (qrs.next())
                        {
                            int questionNumber = Integer.parseInt(qrs.getString("questionNumber"));
                            String question = qrs.getString("question");
                            String expectedAnswer = qrs.getString("expectedAnswer");
                            String category = qrs.getString("category");
                            int marks = Integer.parseInt(qrs.getString("marks"));

                            Question quest = new Question(questionNumber, question, expectedAnswer, category, marks);
                            questions.add(quest);
                        }

                    %>


                    <h2 id="title01">Assessment</h2>
                    <div id="myTabContent" class="container" aria-live="polite" style="overflow:scroll; height:300px; width: 100%">

                        <br><br>
                        <%                                for (String string : schemas)
                            {
                        %><h4><%=string%></h4><%
                            ResultSet rs = statement.executeQuery("SELECT * FROM " + string + ";");
                            ResultSetMetaData rsmd = rs.getMetaData();
                            int columnsNumber = rsmd.getColumnCount();

                            ArrayList<String> col = new ArrayList<String>();

                        %>
                        <table style="table-layout: auto; width: 100%;">

                            <%for (int i = 1; i < columnsNumber + 1; i++)
                                {
                                    String st = rsmd.getColumnName(i);
                                    col.add(st);
                            %>
                            <th style="font-size: 10px"> <%=st%></th>

                            <%
                                }
                                while (rs.next())
                                {
                            %>
                            <tr>
                                <%
                                    for (int i = 0; i < columnsNumber; i++)
                                    {
                                        String ent = rs.getString(col.get(i));
                                %>
                                <td style="font-size: 10px;;"><%=ent%></td>
                                <%

                                    }
                                %>
                            </tr>
                            <%
                                }
                            %>
                            </tr></table>

                        <%--<h6><%=s%></br></h6>--%><br>
                        <%                                }
                        %> 
                        <br>
                        <%                                // }
                        %>
                    </div>

                    <div class="slideshow-container">
                        <%                                statement.addBatch("use `sqlautomarker-individual-records`;");
                            statement.executeBatch();

                            String dbName = user.toUpperCase() + "-" + assessment;
                        %>
                        <p hidden id="dbName"><%=database%></p>
                        <p hidden id="attempt"><%=attempt%></p>
                        <%
                            String qs = "";
                            ResultSet q = statement.executeQuery("SELECT * FROM `" + dbName + "`;");

                            ArrayList<Question> indivQuestions = new ArrayList<Question>();
                            while (q.next())
                            {
                                int qNum = Integer.parseInt(q.getString("questionReference"));
                                qs += q.getString("questionReference") + " ";
                                indivQuestions.add(questions.get(qNum - 1));

                            }
                        %>
                        <p hidden id="qs"><%=qs%></p>
                        <%

                            int count = 1;
                            for (Question quest : indivQuestions)
                            {

                        %>
                        <div class="mySlides" style="word-wrap: break-word;">
                            <%-- <form  action="${pageContext.request.contextPath}/Assessment" method="POST" > --%>
                            <table style="border: none;">
                                <tr>
                                    <td  style="border: none; font-size:20px;  word-wrap: break-word;"><p><%=count + ". " + quest.getQuestion()%></p></td> 
                                    <td style="border: none; width: 20px;  text-align: right; vertical-align: top; font-size: 20px"><p><%="Marks: (" + quest.getMarks() + ")"%></p></td>
                                </tr>
                            </table >
                            <br>
                            <table style="border: none;">
                                <tr>
                                    <td style="border: none;">Type your answer here:</td>
                                </tr>
                            </table>
                            <br>
                            <table style="border: none;">

                                <tr>
                                    <td style=" border: none; height: 200px;"><textarea id="text <%=count%>" style="width: 100%; height: 100%;"></textarea></td>
                                </tr>
                            </table>
                            <br>
                            <table>
                                <tr>
                                    <td  style="text-align: center; border: none;">
                                        <button id ="runQuery<%=count%>" onclick="JavaScript:newTab('text <%=count%>', '<%=database%>');" >Run Query</button>
                                        <%--  <a id ="runQuery<%=count%>" href="JavaScript:newTab('text <%=count%>', '<%=database%>');" >Run Query</a> --%>
                                    </td>
                                </tr>
                            </table>
                            <br><br>
                            <%-- <table>
                                 <tr>
                                     <td style="text-align: center;"><button>Submit</button></td>
                                 </tr>

                                </table>
                                <br><br>

                            <%-- </form>--%>

                        </div>
                        <% count++;
                            }
                        %>

                        <div class="mySlides" style="word-wrap: break-word;">
                            <%-- <form  action="${pageContext.request.contextPath}/Assessment" method="POST" > --%>
                            <br><br> <br><br>
                            <table>
                                <tr>
                                    <td style="border:none; text-align: center;"><button onclick="JavaScript:submit('yes');" style="padding: 15px 32px; margin: 4px 2px;">Submit</button></td>
                                </tr>
                            </table>
                            <br><br>

                            <%-- </form>--%>

                        </div>
                        <br><br>
                        <a class="prev" onclick="plusSlides(-1)">❮</a>
                        <a class="next" onclick="plusSlides(1)">❯</a>

                    </div>

                    <div class="dot-container">
                        <%
                            int x = 1;
                            for (Question qu : indivQuestions)
                            {
                        %><span class="dot" onclick="currentSlide(<%=x%>)"><%=x%></span><%
                                x++;
                            }
                        %>

                        <span class="dot" onclick="currentSlide(<%=x%>)">S</span>
                    </div>

                    <br><br>

                    </body>
                </div>

            </section>
        </div>

    </body>
    <script>
        var slideIndex = 1;
        showSlides(slideIndex);

        function plusSlides(n)
        {
            showSlides(slideIndex += n);
        }

        function currentSlide(n)
        {
            showSlides(slideIndex = n);
        }

        function showSlides(n)
        {
            var i;
            var slides = document.getElementsByClassName("mySlides");
            var dots = document.getElementsByClassName("dot");
            if (n > slides.length)
            {
                slideIndex = 1
            }
            if (n < 1)
            {
                slideIndex = slides.length
            }
            for (i = 0; i < slides.length; i++)
            {
                slides[i].style.display = "none";
            }
            for (i = 0; i < dots.length; i++)
            {
                dots[i].className = dots[i].className.replace(" active", "");
            }
            slides[slideIndex - 1].style.display = "block";
            dots[slideIndex - 1].className += " active";
        }
        function newTab(id, database)
        {

            var s = document.getElementById(id).value;
            var data = btoa(database);

            var ur = btoa(s);

            var url = "runQuery.jsp?database=" + data + "&string=" + ur;
            runQuery(url);

        }

        function runQuery(text)
        {

            popupWindow = window.open(
                    text, 'popUpWindow', 'height=500,width=600,left=10,top=10,resizable=yes,scrollbars=yes,toolbar=no,menubar=no,location=no,directories=no,status=yes')

        }
        function newPopup(url)
        {
            popupWindow = window.open(
                    "viewStudents.jsp", 'popUpWindow', 'height=700,width=600,left=10,top=10,resizable=yes,scrollbars=yes,toolbar=yes,menubar=no,location=no,directories=no,status=yes')
        }

        function submit(url)
        {

            var arr = new Array();
            var x = <%=x - 1%>;

            for (var i = 1; i <= x; i++)
            {
                var s = document.getElementById("text " + i).value;

                arr[i - 1] = "\"" + s + "\"";

            }

            var questions = document.getElementById("qs").innerHTML;
            var dbName = document.getElementById("dbName").innerHTML;
            var ass = document.getElementById("assessmet").innerHTML;
            var us = document.getElementById("user").innerHTML;
            var attempt = document.getElementById("attempt").innerHTML;

            var database = btoa(dbName);
            var q = btoa(questions);
            var data = btoa(arr);
            var assessment = btoa(ass);
            var user = btoa(us);
            var a = btoa(attempt);

            var url = "markAssessment.jsp?set=" + data + "&db=" + database + "&qs=" + q + "&a=" + assessment + "&u=" + user + "&attempt=" + a;
            var nURL = btoa(url)

            mark("markLoading.jsp?redir=" + nURL);

        }

        function mark(arr)
        {

            popupWindow = window.open(arr);

        }

    </script>
</html>
