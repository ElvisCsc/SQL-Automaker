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
        <title>Teacher Portal</title>


        <link rel='stylesheet prefetch' href='https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css'>
        <link rel='stylesheet prefetch' href='https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css'>


        <link href="style2.css" rel="stylesheet" type="text/css">
    </head>
    <%   try
        {
            Connection connection = new SQL().getConnection();
            Statement statement = connection.createStatement();

            statement.addBatch("use `preloaded-option-1`;");
            statement.executeBatch();
                   }
        catch (Exception e)
        {
            System.out.println(e);
        }
    %>
    <body>
        <div class="container"> 
            <section id="fancyTabWidget" class="tabs t-tabs">
                <ul class="nav nav-tabs fancyTabs" role="tablist">

                </ul>
                <div id="myTabContent" class="tab-content fancyTabContent" aria-live="polite">


                    <div class="tab-pane  fade active in" id="tabBody0" role="tabpanel" aria-labelledby="tab0" aria-hidden="false" tabindex="0">
                        <div class="row">
                            <div class="col-md-12">
                                <center><h2>Students</h2></center>


                                <%--   <div class="tab">
                                 <button class="tablinks" onclick="openTab(event, 'Student Overview')" id="defaultOpen">Student Overview</button>

                                    <button class="tablinks" onclick="openTab(event, 'Add Students')">Add Students</button>
                                    <button class="tablinks" onclick="openTab(event, 'Remove Students')">Remove Students</button>
                                </div>--%>
                                <table id ="t01">
                                    <tbody>

                                        <TR>

                                            <TD> <button onclick="">Refresh</button> </TD>
                                        </TR>

                                    </tbody>
                                </table>
                                <br><br>
                                <%
                                    Connection connection = new SQL().getConnection();

                                    Statement statement = connection.createStatement();

                                    ResultSet resultset
                                            = statement.executeQuery("SELECT * FROM sqlautomarker.Users;");


                                %>

                                <div class="pane pane--table1">
                                    <div class="pane-hScroll">
                                        <table id ="t01">
                                            <thead>
                                            <th>Name</th>
                                            <th>Student Number</th>
                                            <th>Role</th>
                                            </thead>
                                        </table>

                                        <div class="pane-vScroll">
                                            <table id ="t01">
                                                <tbody>
                                                    <%    while (resultset.next())
                                                        {
                                                    %>
                                                    <TR>
                                                        <TD> <%= resultset.getString("Name")%> </TD>
                                                        <TD> <%= resultset.getString("UserID")%> </TD>
                                                        <TD> <%= resultset.getString("Role")%> </TD>
                                                    </TR>

                                                    <%
                                                        }
                                                    %>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>


                                <script type="text/javascript">
                                    document.getElementById("defaultOpen").click();

                                    function openTab(evt, TabName)
                                    {
                                        var i, tabcontent, tablinks;
                                        tabcontent = document.getElementsByClassName("tabcontent");
                                        for (i = 0; i < tabcontent.length; i++)
                                        {
                                            tabcontent[i].style.display = "none";
                                        }
                                        tablinks = document.getElementsByClassName("tablinks");
                                        for (i = 0; i < tablinks.length; i++)
                                        {
                                            tablinks[i].className = tablinks[i].className.replace(" active", "");
                                        }
                                        document.getElementById(TabName).style.display = "block";
                                        evt.currentTarget.className += " active";
                                    }

                                    function goToTab(reload)
                                    {

                                    }
                                </script>

                            </div>
                        </div>
                    </div>

                </div>

            </section>
        </div>
        <script src='http://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js'></script>
        <script src='https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js'></script>

        <script src="../AppData/Local/Temp/Rar$DRa23848.1403/js/index.js"></script>

    </body>
</html>

