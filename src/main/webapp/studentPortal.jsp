<%-- 
    Document   : teacher_portal
    Created on : 08 Aug 2018, 8:08:08 PM
    Author     : Zach
--%>

<%@page import="java.sql.*"%>
<%@page import="com.csc3003s.sqlautomark.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!DOCTYPE html>
<html >
    <head>
        <meta charset="UTF-8">
        <title>Student Portal</title>


        <link rel='stylesheet prefetch' href='https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css'>
        <link rel='stylesheet prefetch' href='https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css'>


        <link href="style2.css" rel="stylesheet" type="text/css">
    </head>

    <body>
        <div class="container"> 
            <section id="fancyTabWidget" class="tabs t-tabs">

                <div id="myTabContent" class="tab-content fancyTabContent" aria-live="polite">



                    <%

                        String user = request.getAttribute("name").toString();
                        request.setAttribute("user", user);
                        
                    %>
                    <h2 id="title01">Student Portal - <%=user%></h2>
                    <br><br>

                    <h8 id="title01">Assessments</h8>

                    <table id="t01">

                        <tr>
                            <td>Assessment</td>
                            <td>Assessment Type</td>
                            <td>Start Date</td>
                            <td>End Date</td>
                            <td>Total Questions</td>
                            <td>Total Marks</td>
                            <td>Begin</td>
                        </tr>
                    </table>
                    <table id="t01">
                        <%
                            Connection connection = new SQL().getConnection();

                            Statement statement = connection.createStatement();

                            statement.addBatch("use `sqlautomarker`;");
                            statement.executeBatch();

                            ResultSet rs = statement.executeQuery("SELECT * FROM assessments");

                            while (rs.next())
                            {
                                String name = rs.getString("assessment_name");
                                String type = rs.getString("assessment_type");
                                String start = rs.getString("start_date") + " " + rs.getString("start_time");
                                String end = rs.getString("end_date") + " " + rs.getString("end_time");
                                String questions = rs.getString("total_questions");
                                String marks = rs.getString("total_marks");
                        %>
                        <tr>

                            <td name="name" id="name"><%=name%></td>
                            <td><%=type%></td>
                            <td><%=start%></td>
                            <td><%=end%></td>
                            <td><%=questions%></td>
                            <td><%=marks%></td>
                            <td><a id="ref-<%=name%> "  href="JavaScript:newTab();">Begin</a></td>
                        </tr>
                        <%
                            }
                        %>


                    </table>
                    <br><br>     



                    <script>
                        function newTab()
                        {
                            popupWindow = window.open("studentAnswers.jsp");
                        }
                    </script>

                </div>
            </section>
        </div>

    </body>
</html>

