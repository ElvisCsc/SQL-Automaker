<%-- 
    Document   : createAssessment
    Created on : 12 Aug 2018, 4:08:51 PM
    Author     : Zach
--%>

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
                        String assessment = request.getParameter("assessment");
                        String user = request.getParameter("user");
                        ArrayList<Question> questions = new ArrayList<Question>();

                        Connection connection = new SQL().getConnection();
                        Statement statement = connection.createStatement();
                        statement.addBatch("use `sqlautomarker`;");
                        statement.executeBatch();

                        ResultSet rs1 = statement.executeQuery("Select * FROM assessments WHERE assessment_name='" + assessment + "';");
                        String database = "";

                        while (rs1.next())
                        {
                            database = rs1.getString("question_database");
                        }

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

                    <body>

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

                            %><table style="table-layout: auto; width: 100%;">

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
                                %><tr><%
                                    for (int i = 0; i < columnsNumber; i++)
                                    {
                                        String ent = rs.getString(col.get(i));
                                    %><td style="font-size: 10px;;"><%=ent%></td><%

                                            }
                                    %></tr><%
                                        }
                                    %>
                                </tr></table>

                            <%
                                /*String s = string + "(";
                                for (int i = 1; i < columnsNumber + 1; i++)
                                {
                                    s += rsmd.getColumnName(i);
                                    if (i != columnsNumber)
                                    {
                                        s += ", ";
                                    }
                                }
                                s += ")";*/
                            %><%--<h6><%=s%></br></h6>--%><% /*
                                while (rs.next())
                                {
                                    s = "(";
                                    for (int i = 1; i <= columnsNumber; i++)
                                    {
                                        s += rs.getString(i);
                                        if (i != columnsNumber)
                                        {
                                            s += ",\t";
                                        }
                                    }
                                    s += ")";*/
                            %> 
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

                                ResultSet q = statement.executeQuery("SELECT * FROM `" + dbName + "`;");

                                // ResultSet rs2 = statement.executeQuery("SHOW TABLES;");
                                ArrayList<Question> indivQuestions = new ArrayList<Question>();
                                while (q.next())
                                {
                                    int qNum = Integer.parseInt(q.getString("questionReference"));
                                    indivQuestions.add(questions.get(qNum - 1));

                                }

                                int count = 1;
                                for (Question quest : indivQuestions)
                                {

                            %>
                            <div class="mySlides" style="word-wrap: break-word;">
                                <%-- <form  action="${pageContext.request.contextPath}/Assessment" method="POST" > --%>
                                <table style="border: none;">
                                    <tr style="height: 50px;">
                                    <td style="font-size: 20px; border: none; overflow-wrap: break-word"><%=count + ". " + quest.getQuestion()%></td> 
                                    <td style="width: 20px; border: none; text-align: right;"><%="Marks: (" + quest.getMarks()+")"%></td>
                                    </tr>
                                </table >
                                <table style="border: none;">
                                    <th style="text-align: center;border: none;">Type your answer here:</th>
                                    <tr>

                                        <td><textarea id="text <%=count%>" style="width: 100%;">text here</textarea></td>
                                    </tr>
                                </table>
                                <table>
                                    <tr>
                                        <td></td>
                                        <td  style="text-align: center;">
                                            <button id ="runQuery<%=count%>" onclick="JavaScript:newTab('text <%=count%>', '<%=database%>');" >Run Query</button>
                                            <%--  <a id ="runQuery<%=count%>" href="JavaScript:newTab('text <%=count%>', '<%=database%>');" >Run Query</a> --%>
                                        </td>
                                    </tr>
                                </table>
                                <br><br>
                                <table>
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


                            <a class="prev" onclick="plusSlides(-1)">❮</a>
                            <a class="next" onclick="plusSlides(1)">❯</a>

                        </div>

                        <div class="dot-container">
                            <%
                                int x = 1;
                                for (Question qu : indivQuestions)
                                {
                            %><span class="dot" onclick="currentSlide(<%=x%>)"></span><%
                                    x++;
                                }
                            %>

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

    </script>
</html>
