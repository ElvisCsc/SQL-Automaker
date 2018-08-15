<%-- 
    Document   : createAssessment
    Created on : 12 Aug 2018, 4:08:51 PM
    Author     : Zach
--%>

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
        <title>Create Assessment</title>
        <link href="style2.css" rel="stylesheet" type="text/css">

        <link rel='stylesheet prefetch' href='https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css'>
        <link rel='stylesheet prefetch' href='https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css'>

    </head>
    <body>
        <div class="container"> 
            <section id="fancyTabWidget" class="tabs t-tabs">

                <div id="myTabContent" class="tab-content fancyTabContent" aria-live="polite">

                    <%

                        String user = request.getAttribute("name").toString();
                    
                        
                    %>

                    <body>

                        <h2 id="title01">Assessment</h2>
                        <br><br>
                        <%
                            
                            Connection connection = new SQL().getConnection();

                            Statement statement = connection.createStatement();

                            ResultSet rs = statement.executeQuery("SELECT * FROM `preloaded-option-1`.department;");

                            
                            ResultSetMetaData rsmd = rs.getMetaData();
                            int columnsNumber = rsmd.getColumnCount();

                            String s = "table(";
                            for (int i = 1; i < columnsNumber + 1; i++)
                            {
                                s += rsmd.getColumnName(i);
                                if (i != columnsNumber)
                                {
                                    s += ", ";
                                }
                            }
                            s += ")";

                        %>
                    <db><%=s%></r></db>
                        <%

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
                                s += ")";
                                System.out.println(s);
                        %>
                    <db><%=s%></br></db>
                        <%
                            }

                        %>

                    <form  action="${pageContext.request.contextPath}/Assessment" method="POST" >
                        <table id="t01">
                            <tr>
                                <td><h6>Question here</h6></td> 
                            </tr>
                            <tr>
                                <td>Assessment Name:</td>
                                <td>
                                    <input id="assessmentName" name="assessmentName" type="text" >
                                </td> 
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

                        <input type="submit" >
                    </form>

                    </body>
                </div>

            </section>
        </div>

    </body>
    <script>


        function newPopup(url)
        {
            popupWindow = window.open(
                    "viewStudents.jsp", 'popUpWindow', 'height=700,width=600,left=10,top=10,resizable=yes,scrollbars=yes,toolbar=yes,menubar=no,location=no,directories=no,status=yes')
        }

    </script>
</html>
