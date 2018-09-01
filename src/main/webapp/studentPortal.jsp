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

    <body >
        <div class="container"> 
            <section id="fancyTabWidget" class="tabs t-tabs">

                <div  id="myTabContent" class="tab-content fancyTabContent" aria-live="polite">

                    <%

                        String user = request.getParameter("u").toString();
                    %>
                    <h2 id="title01" style="text-align: center;">Student Portal</h2></br>
                    <h3 id="username" name="username" style="text-align: center;"><%=user%></h3>
                    <br><br>



                    <table  id="t01">
                        <tr  >
                            <td style="width: auto; font-size: small; ">Assessment</td>
                            <td style="width: 120px; font-size: small; ">Type</td>
                            <td style="width: auto; font-size: small; ">Start Date</td>
                            <td style="width: auto; font-size: small; ">End Date</td>
                            <td style="width: 105px; font-size: small; ">Questions</td>
                            <td style="width: 80px; font-size: small; ">Out Of</td>
                            <td style="width: 80px; font-size: small; ">Retries</td>
                            <td style="width: 80px; font-size: small; ">Result</td>
                            <td style="width: 100px; font-size: small; "></td>
                        </tr>

                        <%
                            Connection connection = new SQL().getConnection();

                            Statement statement = connection.createStatement();

                            statement.addBatch("use `sqlautomarker`;");
                            statement.executeBatch();

                            ResultSet rs = statement.executeQuery("SELECT * FROM assessments");
                            int x = 0;

                            while (rs.next())
                            {
                                String name = rs.getString("assessment_name");
                                String type = rs.getString("assessment_type");

                                String startDate = rs.getString("start_date");
                                String startTime = rs.getString("start_time");
                                String start = startDate + " " + startTime;

                                String endDate = rs.getString("end_date");
                                String endTime = rs.getString("end_time");
                                String end = endDate + " " + endTime;

                                String questions = rs.getString("total_questions");
                                String marks = rs.getString("total_marks");

                                int totAttempts = Integer.parseInt(rs.getString("attempts"));

                                Statement statement2 = connection.createStatement();
                                statement2.addBatch("use `marks`;");
                                statement2.executeBatch();

                                String sql = "SELECT attemptsLeft, marks FROM `" + name + "` WHERE studentNumber ='" + user + "'";
                                ResultSet rn = statement2.executeQuery(sql);
                                int attemptsLeft = 0;
                                int mark = 0;
                                rn.next();
                                attemptsLeft = Integer.parseInt(rn.getString("attemptsLeft"));
                                String s = rn.getString("marks");
                                if (s == null)
                                {
                                    mark = 0;
                                }
                                else
                                {
                                    mark = Integer.parseInt(s);
                                }


                        %>
                        <tr>

                            <td style="font-size: small; " name="name" id="name"><%=name%></td>
                            <td style="font-size: small; "><%=type%></td>
                            <td style="font-size: small; "><%=start%></td>
                            <td style="font-size: small; "><%=end%></td>

                            <td style="font-size: small; "><%=questions%></td>
                            <td style="font-size: small; "><%=marks%></td>
                            <td style="font-size: small; "><%=attemptsLeft%></td>
                            <td style="font-size: small; "><%=mark%></td>
                            <td style="font-size: small; "><a id="ref-<%=x%>"  href="JavaScript:newTab('<%=name%>', '<%=user%>','<%=attemptsLeft%>', '<%=totAttempts%>');">Begin</a></td>


                        <p hidden id="<%="attemptsLeft " + x%>"><%=attemptsLeft%></p>
                        <p hidden id="<%="endDate " + x%>"><%=endDate + "T" + endTime + "Z"%></p>
                        <p hidden id="<%="startDate " + x%>"><%=startDate + "T" + startTime + "Z"%></p>

                        </tr>
                        <%

                                x++;
                            }


                        %>


                    </table>
                    <br><br>     



                    <script>


                        window.addEventListener('DOMContentLoaded', function ()
                        {
                            var x = <%=x%>;
                            var today = new Date();
                            for (var i = 0; i < x; i++)
                            {
                                var v = i;
                                var y = 'startDate ' + v;
                                var sDate = document.getElementById(y).innerHTML;
                                var y1 = 'endDate ' + v;
                                var eDate = document.getElementById(y1).innerHTML;
                                var start = new Date(sDate);
                                var end = new Date(eDate);



                                var attempts = document.getElementById("attemptsLeft " + v).innerHTML;

                                if (attempts == 0)
                                {
                                    document.getElementById("ref-" + v).innerHTML = "Closed";
                                    document.getElementById("ref-" + v).removeAttribute('href');
                                }

                                if (end < today)
                                {
                                    document.getElementById("ref-" + v).innerHTML = "Closed";
                                    document.getElementById("ref-" + v).removeAttribute('href');
                                }
                                if (start > today)
                                {
                                    document.getElementById("ref-" + v).innerHTML = "Closed";
                                    document.getElementById("ref-" + v).removeAttribute('href');
                                }

                            }
                            var endDate = document.getElementById("endDate");
                            var end = new Date(endDate);
                        });

                        function newTab(name, user, left, totAttempt)
                        {
                            var url;
                            var l = left;
                            var at = totAttempt;

                            if (l == at)
                            {

                                var attempt = btoa(left);
                                var a = btoa(name);
                                var u = btoa(user);
                                url = "studentAnswers.jsp?assessment=" + a + "&user=" + u + "&attempt=" + attempt;
                                popupWindow = window.open(url);
                            }
                            if (l < at)
                            {
                                var c = confirm('Are you sure you would like to retry the assignment?\nYour current mark will be erased');
                                if (c == true)
                                {
                                    var attempt = btoa(left);
                                    var a = btoa(name);
                                    var u = btoa(user);
                                    url = "studentAnswers.jsp?assessment=" + a + "&user=" + u + "&attempt=" + attempt;
                                    popupWindow = window.open(url);
                                }

                            }


                        }
                    </script>

                </div>
            </section>
        </div>

    </body>
</html>

