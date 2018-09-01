<%-- 
    Document   : teacherPortal
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

                        <a id="tab0" href="#Overview" role="tab" aria-controls="Overview" aria-selected="true" data-toggle="tab" tabindex="0">
                            <span class="fa fa-desktop"></span>
                            <span class="hidden-xs">Overview</span>
                        </a>

                    </li>

                    <li class="tab fancyTab">

                        <a id="tab1" href="#Create" role="tab" aria-controls="Create" aria-selected="true" data-toggle="tab" tabindex="0" onclick="JavaScript:newTab('');">
                            <span class="fa fa-firefox"></span>
                            <span class="hidden-xs">Create</span>
                        </a>

                    </li>

                    <li class="tab fancyTab">

                        <a id="tab2" href="#Data" role="tab" aria-controls="Data" aria-selected="true" data-toggle="tab" tabindex="0">
                            <span class="fa fa-envira"></span>
                            <span class="hidden-xs">Data</span>
                        </a>

                    </li>

                    <li class="tab fancyTab">

                        <a id="tab3" href="#Students" role="tab" aria-controls="Students" aria-selected="true" data-toggle="tab" tabindex="0" onclick="openTab(event, 'Student Overview')">
                            <span class="fa fa-mortar-board"></span>
                            <span class="hidden-xs">Students</span>
                        </a>

                    </li> 

                    <li class="tab fancyTab">

                        <a id="tab4" href="#Marks" role="tab" aria-controls="Marks" aria-selected="true" data-toggle="tab" tabindex="0">
                            <span class="fa fa-stack-overflow"></span>
                            <span class="hidden-xs">Marks</span>
                        </a>

                    </li>


                </ul>
                <div id="myTabContent" class="tab-content fancyTabContent" aria-live="polite">
                    <div class="tab-pane  fade active in" id="Overview" role="tabpanel" aria-labelledby="tab0" aria-hidden="true" tabindex="0">
                        <div>
                            <div  class="row">

                                <table class="table" id="t02"  >
                                    <tr>
                                        <td > <Button class="button" id="b1" onclick="move('Add Students')">Add Students</Button></td>
                                        <td >  <Button class="button" id="b1" onclick="move('View Students')">View Students</Button></td>
                                        <td > <Button class="button" id="b1" onclick="move('Remove Students')">Remove Students</Button></td>
                                    </tr>
                                </table>
                                <br>
                                <table class="table" id="t02"   >
                                    <tr>
                                        <td> <Button class="button" id="b1">Create Assessment</Button></td>
                                        <td >  <Button class="button" id="b1">Upload New Questions</Button></td>
                                        <td > <Button class="button" id="b1">View Results</Button></td>
                                    </tr>
                                </table>



                            </div>

                        </div>
                    </div>

                    <div class="tab-pane  fade" id="Data" role="tabpanel" aria-labelledby="tab2" aria-hidden="true" tabindex="0">
                        <div class="row">
                            <div class="col-md-12">
                                <h2>This is the content of tab three.</h2>
                                <p>*** ENTER TEXT HERE ***</p>
                            </div>
                        </div>
                    </div>
                    <div class="tab-pane  fade" id="Students" role="tabpanel" aria-labelledby="tab3" aria-hidden="true" tabindex="0">
                        <div class="row">
                            <div class="col-md-12">
                                <center><h2>Students</h2></center>



                                <div class="tab">
                                    <button id="student_overview" class="tablinks" onclick="openTab(event, 'Student Overview')" id="defaultOpen">Student Overview</button>
                                    <button id="add_student" class="tablinks" onclick="openTab(event, 'Add Students')">Add Students</button>
                                    <button id="remove_student" class="tablinks" onclick="openTab(event, 'Remove Students')">Remove Students</button>
                                </div>

                                <div id="Student Overview" class="tabcontent">
                                    <h3>Student Overview </h3> 
                                    <a id="view_students"  href="JavaScript:newPopup('/javascript/examples/sample_popup.cfm');" target="popup" ></a>
                                    <br><br>
                                    <form  action="">
                                        <input  id="viewStudents" type="button" value="View Students" onclick="viewStudent()"/>
                                    </form>
                                    <br><br>
                                    <form action="">
                                        <input type="submit" value="Add Students" />
                                    </form>
                                    <br><br>
                                    <form action="">
                                        <input type="submit" value="Remove Students" />
                                    </form>


                                </div>

                                <div id="Add Students" class="tabcontent">
                                    <h3>Add Students</h3>
                                    <form id = "addStudent" action="fileupload.jsp" method="post" enctype="multipart/form-data"  target="_blank">
                                        <input id = "file" type="file" name="file" size="50" />
                                        <br><br>
                                        <%-- <input  id="submitStudent" onclick="submit()" type="submit" value="Upload File" /> --%>
                                        <button class="button" id="b1" onclick="submit()">Upload File</button>

                                    </form>



                                </div>

                                <div id="Remove Students" class="tabcontent">
                                    <h3>Remove Students</h3>
                                    <p>INSERT CONTENT HERE</p>
                                </div>

                                <script type="text/javascript">

                                    document.getElementById("Overview").click();


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

                                    function newPopup(url)
                                    {
                                        popupWindow = window.open(
                                                "viewStudents.jsp", 'popUpWindow', 'height=700,width=600,left=10,top=10,resizable=yes,scrollbars=yes,toolbar=yes,menubar=no,location=no,directories=no,status=yes')
                                    }

                                    function viewStudent()
                                    {
                                        window.location = document.getElementById('view_students').href;
                                    }

                                    function submit()
                                    {
                                        if (document.getElementById("file").files.length == 0)
                                        {
                                            alert("no files selected");
                                        }
                                    }

                                </script>

                            </div>
                        </div>
                    </div>
                    <div class="tab-pane  fade" id="Marks" role="tabpanel" aria-labelledby="tab4" aria-hidden="true" tabindex="0">
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

        <script>

            function move(link)
            {
                alert(link);
                if (link == 'Remove Students')
                {
                    document.getElementById("tab3").click();
                    document.getElementById("remove_student").click();
                }
                if (link == 'View Students')
                {
                    viewStudent();
                }


            }
            function newTab(name)
            {
                var url = "createAssessment.jsp?";
                popupWindow = window.open(url);

            }
        </script>
        <script src='http://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js'></script>
        <script src='https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js'></script>

        <script src="../AppData/Local/Temp/Rar$DRa23848.1403/js/index.js"></script>

    </body>
</html>

