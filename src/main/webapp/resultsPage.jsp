<%-- 
    Document   : createAssessment
    Created on : 12 Aug 2018, 4:08:51 PM
    Author     : Zach
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.ResultSetMetaData"%>
<%@page import="java.util.Base64.Decoder"%>
<%@page import="java.util.Base64"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="com.csc3003s.sqlautomark.*"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Results</title>
        <link href="style2.css" rel="stylesheet" type="text/css">

        <link rel='stylesheet prefetch' href='https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css'>
        <link rel='stylesheet prefetch' href='https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css'>

    </head>
    <body >
        <div class="container"> 

            <div id="myTabContent" class="tab-content fancyTabContent" aria-live="polite" >


                <h2 id="title01">Results</h2>
                <br><br>


                <%
                    /*String a = request.getParameter("a");
                    String u = request.getParameter("u");
                    Decoder decoder = Base64.getDecoder();

                    byte[] as = decoder.decode(a);
                    byte[] us = decoder.decode(u);
                    new String(as);
                    String user = new String(us);*/

                    String assessment = "Assignment2";
                    String user = "SBTELV001";
                    String database = "preloaded-option-1";

                    Connection connection = new SQL().getConnection();
                    Statement statement = connection.createStatement();

                    String s = "SELECT q.`questionID`, q.`question`, q.`studentAnswer`, ques.`expectedAnswer`, q.`studentMarks`, ques.`marks` "
                            + "FROM `sqlautomarker-individual-records`.`" + user + "-" + assessment + "` q "
                            + "JOIN `" + database + "`.`questions` ques ON q.questionReference = ques.questionNumber";

                    ResultSet rs = statement.executeQuery(s);
                    ResultSetMetaData rsmd = rs.getMetaData();
                    int columnsNumber = rsmd.getColumnCount();
                    ArrayList<Result> results = new ArrayList<Result>();

                    while (rs.next())
                    {
                        String question = rs.getString("question");
                        String studentAnswer = rs.getString("studentAnswer");
                        String expectedAnswer = rs.getString("expectedAnswer");
                        String qID = rs.getString("questionID");
                        String sMarks = rs.getString("studentMarks");
                        int questionID = 0;
                        int studentMarks = 0;
                        if (qID != null)
                        {
                            questionID = Integer.parseInt(qID);
                        }
                        if (sMarks != null)
                        {
                            studentMarks = Integer.parseInt(sMarks);
                        }

                        int outOf = Integer.parseInt(rs.getString("marks"));

                        Result r = new Result(questionID, question, studentAnswer, expectedAnswer, studentMarks, outOf);
                        results.add(r);
                    }

                    int totMarks = 0;
                    int assignmentTotal = 0;
                    for (Result result : results)
                    {
                        int num = result.getQuestionID();
                        int marks = result.getStudentMarks();
                        int outOf = result.getOutOf();
                        String question = result.getQuestion();
                        String expected = result.getExpectedAnswer();
                        String given = result.getStudentAnswer();
                        assignmentTotal += outOf;
                        totMarks += marks;

                %>
                <p hidden id="user"><%=user%></p>
                <h3>Question <%=num%></h3>

                <%

                    if (marks == outOf)
                    {
                %>
                <h4 style="color: greenyellow;">Correct</h4>

                <%
                }
                else
                {
                %>
                <h4 style="color: red;">Incorrect</h4>
                <h6 style="font-family: 'Courier New';">Question:</h6>
                <h6 style="font-family: 'Courier New';"><%=question%></h6>
                <br>
                <h6 style="font-family: 'Courier New';">Expected Answer:</h6>
                <h6 style="font-family: 'Courier New';"><%=expected%></h6>
                <br>
                <h6 style="font-family: 'Courier New';">Your Answer:</h6>
                <h6 style="font-family: 'Courier New';"><%=given%></h6>
                <br>
                <h6 style="font-family: 'Courier New';">Mark: <%=marks%> out of <%=outOf%></h6>
                <%
                    }
                %>  <br><%
                    }

                %>

                <h4 style="text-align: center;">Total Marks: <%=totMarks + " out of " + assignmentTotal%></h4>

                <button onClick="Javascript: home();">Home</button>

            </div>


        </div>
    </body>
    <script>


        function home()
        {
            var user = document.getElementById("user").innerHTML;
           
            var s = 'studentPortal.jsp?user='+user;
            window.location = s;
        }


    </script>
</html>
