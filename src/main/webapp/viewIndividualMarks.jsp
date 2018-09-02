<%-- 
    Document   : teacher_portal
    Created on : 08 Aug 2018, 8:08:08 PM
    Author     : MLTZAC001
--%>

<%@page import="java.util.Base64.*"%>
<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@page import="com.csc3003s.sqlautomark.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html >
    <head>
        <meta charset="UTF-8">
        <title>
            Marks
        </title>
        <link rel='stylesheet prefetch' href='https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css'>
        <link rel='stylesheet prefetch' href='https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css'>
        <link href="./css/indivMarks.css" rel="stylesheet" type="text/css">
    </head>

    <body>
        <div class="container"> 
            <section id="fancyTabWidget" class="tabs t-tabs">
                <div  id="myTabContent" class="tab-content fancyTabContent" aria-live="polite">
                    <%
                        //initiates connection with MySQL database server
                        Connection connection = new SQL().getConnection();
                        Statement statement = connection.createStatement();

                        //fetches all parameters
                        String u = request.getParameter("u");
                        String a = request.getParameter("assessment");

                        //decodes the strings
                        Decoder decoder = Base64.getDecoder();
                        byte[] us = decoder.decode(u);
                        byte[] as = decoder.decode(a);
                        String assessment = new String(us);
                        String name = new String(as);

                        statement.addBatch("use `sqlautomarker`;");
                        statement.executeBatch();

                        //fetches name of question database
                        String d = "SELECT question_database from assessments WHERE assessment_name ='" + assessment + "';";
                        ResultSet rs = statement.executeQuery(d);
                        rs.next();
                        String database = rs.getString("question_database");
                    %>
                    <%--hidden variable--%>
                    <p hidden id="assessment_name"><%=assessment%></p>
                    <h2 id="title01" style="text-align: center;">
                        View Marks
                    </h2>
                    <h3 id="username" name="username" style="text-align: center;">
                        <%=assessment + ": " + name%>
                    </h3>
                    <br>
                    <br>
                    <table>
                        <tr>
                            <td style="width: 15px;">
                                #
                            </td>
                            <td>
                                Question
                            </td>
                            <td>
                                Given Answer
                            </td>
                            <td>
                                Expected Answer
                            </td>
                            <td style="width: 25px;">
                                Mark
                            </td>
                            <td style="width: 10px;">
                                Of
                            </td>
                        </tr>
                        <%
                            //fetches necessary information 
                            String sq = "SELECT u.questionID, u.question,q.expectedAnswer,u.studentAnswer, u.studentMarks, q.marks FROM `sqlautomarker-individual-records`.`" + name + "-" + assessment + "` u JOIN `" + database + "`.`questions` q ON q.questionNumber=u.questionReference;";

                            ResultSet r = statement.executeQuery(sq);

                            //traverses result set
                            while (r.next())
                            {

                                //fetches necessary parameters
                                String questionID = r.getString("questionID");
                                String question = r.getString("question");
                                String expectedAnswer = r.getString("expectedAnswer");
                                String studentAnswer = r.getString("studentAnswer");
                                String studentMarks = r.getString("studentMarks");
                                String marks = r.getString("marks");
                        %>
                        <tr>
                            <%--populate table cells--%>
                            <td>
                                <%=questionID%>
                            </td>
                            <td>
                                <%=question%>
                            </td>
                            <td>
                                <%=studentAnswer%>
                            </td>
                            <td>
                                <%=expectedAnswer%>
                            </td>
                            <td>
                                <%=studentMarks%>
                            </td>
                            <td>
                                <%=marks%>
                            </td>
                        </tr>
                        <%
                            }
                        %>
                    </table>
                    <br>   
                    <center>
                        <button id="b1" class="button" onclick="Javascript: mark()();">
                            Return to Marks
                        </button>
                    </center>
                    <center>
                        <button id="b1" class="button" onclick="Javascript: home();">
                            Home
                        </button>
                    </center>
                    <script>
                        /**
                         * redirects user to the mark overview page
                         * @returns mark overview page
                         */
                        function mark()
                        {
                            var x = document.getElementById("assessment_name").innerHTML;
                            var url = "ViewMarks.jsp?a=" + btoa(x);
                            window.location = url;
                        }

                        /**
                         * redirects user to the teacher portal
                         * @returns teacher portal
                         */
                        function home()
                        {
                            var url = "teacherPortal.jsp?";
                           window.location = url;
                        }
                    </script>
                </div>
            </section>
        </div>
    </body>
</html>