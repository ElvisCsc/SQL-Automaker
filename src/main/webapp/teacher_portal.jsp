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

    <body>
        <div class="container"> 
            <section id="fancyTabWidget" class="tabs t-tabs">
                <ul class="nav nav-tabs fancyTabs" role="tablist">

                    <li class="tab fancyTab active">
                        <div class="arrow-down"><div class="arrow-down-inner"></div></div>	
                        <a id="tab0" href="#tabBody0" role="tab" aria-controls="tabBody0" aria-selected="true" data-toggle="tab" tabindex="0"><span class="fa fa-desktop"></span><span class="hidden-xs">Overview</span></a>
                        <div class="whiteBlock"></div>
                    </li>

                    <li class="tab fancyTab">
                        <div class="arrow-down"><div class="arrow-down-inner"></div></div>
                        <a id="tab1" href="#tabBody1" role="tab" aria-controls="tabBody1" aria-selected="true" data-toggle="tab" tabindex="0"><span class="fa fa-firefox"></span><span class="hidden-xs">Create</span></a>
                        <div class="whiteBlock"></div>
                    </li>

                    <li class="tab fancyTab">
                        <div class="arrow-down"><div class="arrow-down-inner"></div></div>
                        <a id="tab2" href="#tabBody2" role="tab" aria-controls="tabBody2" aria-selected="true" data-toggle="tab" tabindex="0"><span class="fa fa-envira"></span><span class="hidden-xs">Data</span></a>
                        <div class="whiteBlock"></div>
                    </li>

                    <li class="tab fancyTab">
                        <div class="arrow-down"><div class="arrow-down-inner"></div></div>
                        <a id="tab3" href="#tabBody3" role="tab" aria-controls="tabBody3" aria-selected="true" data-toggle="tab" tabindex="0"><span class="fa fa-mortar-board"></span><span class="hidden-xs">Students</span></a>
                        <div class="whiteBlock"></div>
                    </li> 

                    <li class="tab fancyTab">
                        <div class="arrow-down"><div class="arrow-down-inner"></div></div>
                        <a id="tab4" href="#tabBody4" role="tab" aria-controls="tabBody4" aria-selected="true" data-toggle="tab" tabindex="0"><span class="fa fa-stack-overflow"></span><span class="hidden-xs">Capture</span></a>
                        <div class="whiteBlock"></div>
                    </li>

                    <li class="tab fancyTab">
                        <div class="arrow-down"><div class="arrow-down-inner"></div></div>
                        <a id="tab5" href="#tabBody5" role="tab" aria-controls="tabBody5" aria-selected="true" data-toggle="tab" tabindex="0"><span class="fa fa-question-circle"></span><span class="hidden-xs">Order</span></a>
                        <div class="whiteBlock"></div>
                    </li>
                </ul>
                <div id="myTabContent" class="tab-content fancyTabContent" aria-live="polite">
                    <div class="tab-pane  fade active in" id="tabBody0" role="tabpanel" aria-labelledby="tab0" aria-hidden="false" tabindex="0">
                        <div>
                            <div class="row">

                                <div class="col-md-12">
                                    <h2>This is the content of tab one.</h2>
                                    <p>*** ENTER TEXT HERE ***</p>

                                </div>

                            </div>
                        </div>
                    </div>
                    <div class="tab-pane  fade" id="tabBody1" role="tabpanel" aria-labelledby="tab1" aria-hidden="true" tabindex="0">
                        <div class="row">

                            <div class="col-md-12">
                                <h2>Create new assessment</h2>
                                <p>*** ENTER TEXT HERE ***</p>
                            </div>
                        </div>
                    </div>
                    <div class="tab-pane  fade" id="tabBody2" role="tabpanel" aria-labelledby="tab2" aria-hidden="true" tabindex="0">
                        <div class="row">
                            <div class="col-md-12">
                                <h2>This is the content of tab three.</h2>
                                <p>*** ENTER TEXT HERE ***</p>
                            </div>
                        </div>
                    </div>
                    <div class="tab-pane  fade" id="tabBody3" role="tabpanel" aria-labelledby="tab3" aria-hidden="true" tabindex="0">
                        <div class="row">
                            <div class="col-md-12">
                                <center><h2>Students</h2></center>



                                <div class="tab">
                                    <button class="tablinks" onclick="openTab(event, 'Student Overview')" id="defaultOpen">Student Overview</button>
                                    <button class="tablinks" onclick="openTab(event, 'Add Students')">Add Students</button>
                                    <button class="tablinks" onclick="openTab(event, 'Remove Students')">Remove Students</button>
                                </div>

                                <div id="Student Overview" class="tabcontent">
                                    <h3>Student Overview </h3> 
                                    <button onclick=""target="_blank">Refresh</button>
                                            <%
                                                Connection connection = new SQL().getConnection();

                                                Statement statement = connection.createStatement();

                                                // String command = "INSERT INTO Employees (ID, Name) VALUES (1, 'Joe')";
                                                // statement.executeUpdate(command);
                                                //command = "INSERT INTO Employees (ID, Name) VALUES (2, 'Yin')";
                                                //statement.executeUpdate(command);
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
                                                            <TD> <%= resultset.getString("User ID")%> </TD>
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
                                </div>

                                <div id="Add Students" class="tabcontent">
                                    <h3>Add Students</h3>
                                    <form id = "addStudent" action="fileupload.jsp" method="post" enctype="multipart/form-data"  target="_blank">
                                        <input id = "file" type="file" name="file" size="50" />
                                        <br />
                                        <%-- <input  id="submitStudent" onclick="submit()" type="submit" value="Upload File" /> --%>
                                        <button id="submitStudent" onclick="submit()" type="submit">Upload File</button>
                                    </form>


                                    <p id = "p11">INSERT CONTENT HERE</p> 

                                </div>

                                <div id="Remove Students" class="tabcontent">
                                    <h3>Remove Students</h3>
                                    <p>INSERT CONTENT HERE</p>
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

                                </script>

                            </div>
                        </div>
                    </div>
                    <div class="tab-pane  fade" id="tabBody4" role="tabpanel" aria-labelledby="tab4" aria-hidden="true" tabindex="0">
                        <div class="row">
                            <div class="col-md-12">
                                <h2>This is the content of tab five.</h2>
                                <p>*** ENTER TEXT HERE *** </p>
                            </div>
                        </div>
                    </div>
                    <div class="tab-pane  fade" id="tabBody5" role="tabpanel" aria-labelledby="tab5" aria-hidden="true" tabindex="0">
                        <div class="row">
                            <div class="col-md-12">
                                <h2>This is the content of tab six.</h2>
                                <p>*** ENTER TEXT HERE ***</p>
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

