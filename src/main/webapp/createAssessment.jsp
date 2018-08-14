<%-- 
    Document   : createAssessment
    Created on : 12 Aug 2018, 4:08:51 PM
    Author     : Zach
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="com.csc3003s.sqlautomark.*"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Create Assessment</title>
        <link href="style2.css" rel="stylesheet" type="text/css">

        <link rel='stylesheet prefetch' href='https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css'>
        <link rel='stylesheet prefetch' href='https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css'>

    </head>
    <body>
        <div class="container"> 
            <section id="fancyTabWidget" class="tabs t-tabs">

                <div id="myTabContent" class="tab-content fancyTabContent" aria-live="polite">


                    <body>

                        <h2 id="title01">Create Assessment</h2>
                        <br><br>

                        <form  action="${pageContext.request.contextPath}/Assessment" method="POST" >
                            <table id="t01">
                                <tr>
                                    <td>Assessment Name:</td>
                                    <td>
                                        <input id="assessmentName" name="assessmentName" type="text" >
                                    </td> 
                                </tr>
                                <tr>
                                    <td>Select Database:</td>
                                    <td>
                                        <select id="selectDatabase" name="selectDatabase">
                                            <%
                                                Connection connection = new SQL().getConnection();

                                                Statement statement = connection.createStatement();

                                                ResultSet rs = statement.executeQuery("SHOW SCHEMAS");

                                                while (rs.next())
                                                {
                                                    String s = rs.getString("Database");
                                                    if (s.contains("option") || s.contains("questionset"))
                                                    {
                                            %>
                                            <option class="database"><%= rs.getString("Database")%></option>
                                            <%
                                                    }
                                                }
                                            %>
                                        </select>
                                    </td> 
                                </tr>
                                <tr>
                                    <td>Assessment Type:</td>
                                    <td>
                                        <select id="assessmentType" name="assessmentType">
                                            <option id="assignment">Assignment</option>
                                            <option id="closedPrac">Closed Practical</option>
                                        </select>
                                    </td> 
                                </tr>
                            </table>
                            <br><br>     
                            <table id="t01">
                                <tr>
                                    <td>Total Number of Questions:</td>
                                    <td><input type="text" id="numQuestions" name="numQuestions" readonly></td> 
                                </tr>
                                <tr>
                                    <td>Category A: SIMPLE QUERIES      (2 Marks)</td>
                                    <td><INPUT class="cat" id="catA" name="catA" TYPE="NUMBER" MIN="0" MAX="10" STEP="1" VALUE="0" SIZE="6" onchange="update()"></input></td> 
                                </tr>
                                <tr>
                                    <td>Category B: WHERE CONDITIONS      (2 Marks)</td>
                                    <td><INPUT class="cat" id="catB" name="catB" TYPE="NUMBER" MIN="0" MAX="10" STEP="1" VALUE="0" SIZE="6" onchange="update()"></input></td> 
                                </tr>
                                <tr>
                                    <td>Category C: ORDER BY      (3 Marks)</td>
                                    <td><INPUT class="cat" id="catC" name="catC" TYPE="NUMBER" MIN="0" MAX="10" STEP="1" VALUE="0" SIZE="6" onchange="update()"></input></td> 
                                </tr>
                                <tr>
                                    <td>Category D: GROUP BY & HAVING      (3 Marks)</td>
                                    <td><INPUT class="cat" id="catD" name="catD" TYPE="NUMBER" MIN="0" MAX="10" STEP="1" VALUE="0" SIZE="6" onchange="update()"></input></td> 
                                </tr>
                                <tr>
                                    <td>Category E: SUB-QUERIES      (4 Marks)</td>
                                    <td><INPUT class="cat" id="catE" name="catE" TYPE="NUMBER" MIN="0" MAX="10" STEP="1" VALUE="0" SIZE="6" onchange="update()"></input></td> 
                                </tr>
                                <tr>
                                    <td>Category F: SUB-QUERY OPERATORS (ALL, ANY, SOME, EXISTS)       (4 Marks)</td>
                                    <td><INPUT class="cat" id="catF" name="catF" TYPE="NUMBER" MIN="0" MAX="10" STEP="1" VALUE="0" SIZE="6" onchange="update()"></input></td> 
                                </tr>
                                <tr>
                                    <td>Category G: JOINS      (5 Marks)</td>
                                    <td><INPUT class="cat" id="catG" name="catG" TYPE="NUMBER" MIN="0" MAX="10" STEP="1" VALUE="0" SIZE="6" onchange="update()"></input></td> 
                                </tr>
                                <tr>
                                    <td></td>
                                    <td> 
                                        <table>
                                            <tr>
                                                <td>Total Marks:</td>
                                                <td> <input type="text" id="totMarks" name="totMarks" readonly></td> 
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                            <br><br>
                            <table id="t01">
                                <tr>                          
                                    <td>Start date (YYYY/MM/DD):</td>
                                    <td><input type="date" id="startDate" name="startDate" min="2018-01-01"></td> 
                                </tr>
                                <tr>                          
                                    <td>Start time:</td>
                                    <td> <input type="time" id="startTime" name="startTime"></td> 
                                </tr>
                                <tr>                          
                                    <td>End date (YYYY/MM/DD):</td>
                                    <td><input type="date" id="endDate" name="endDate" min="2018-01-01"></td> 
                                </tr>
                                <tr>                          
                                    <td>End time:</td>
                                    <td> <input type="time" id="endTime" name="endTime"></td> 
                                </tr>
                            </table>
                            <br><br>
                            <input type="submit" >
                        </form>
                    </body>
                </div>
            </section>
        </div>

    </body>
    <script>


        function update()
        {
            var tot, cats, catA, catB, catC, catD, catE, catF, catG, label,
                    totMarks, marksA, marksB, marksC, marksD, marksE, marksF, marksG, labelMarks;
            label = document.getElementById("numQuestions");
            cats = document.getElementsByClassName("cat");
            labelMarks = document.getElementById("totMarks");

            catA = document.getElementById("catA").valueOf();

            catB = document.getElementById("catB").valueOf();

            catC = document.getElementById("catC").valueOf();

            catD = document.getElementById("catD").valueOf();

            catE = document.getElementById("catE").valueOf();

            catF = document.getElementById("catF").valueOf();

            catG = document.getElementById("catG").valueOf();

            tot = Number(catA.value) + Number(catB.value) + Number(catC.value) + Number(catD.value) + Number(catE.value) + Number(catF.value) + Number(catG.value);
            label.value = tot.valueOf();
            totMarks = Number(2 * catA.value) + Number(2 * catB.value) + Number(3 * catC.value) + Number(3 * catD.value) + Number(4 * catE.value) + Number(4 * catF.value) + Number(5 * catG.value);
            labelMarks.value = totMarks.valueOf();
        }


    </script>
</html>
