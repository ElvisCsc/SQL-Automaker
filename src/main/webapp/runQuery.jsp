<%-- 
    Document   : runQuery
    Created on : 16 Aug 2018, 12:08:31 PM
    Author     : Zach
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="com.csc3003s.sqlautomark.SQL"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.Base64.Decoder"%>
<%@page import="java.util.Base64"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="quiz.css" rel="stylesheet" type="text/css">
        <title>Query</title>
    </head>
    <body>
        <div class="container"> 

            <section id="fancyTabWidget" class="tabs t-tabs">

                <div id="myTabContent" class="tab-content fancyTabContent" aria-live="polite">


                    <%
                        String s = request.getParameter("string");
                        String d = request.getParameter("database");

                        Decoder decoder = Base64.getDecoder();
                        byte[] q = decoder.decode(s);
                        byte[] data = decoder.decode(d);

                        String database = new String(data);
                        String decodedString = new String(q);

                        System.out.println(database);
                        System.out.println(decodedString);

                        Connection connection = new SQL().getConnection();

                        Statement statement = connection.createStatement();

                        statement.addBatch("use `" + database + "`;");
                        statement.executeBatch();

                        try
                        {
                  
                            ResultSet rs = statement.executeQuery(decodedString);
                            ResultSetMetaData rsm = rs.getMetaData();

                            int columnsNumber = rsm.getColumnCount();
                            ArrayList<String> col = new ArrayList<String>();

                    %><table style="table-layout: fixed; width: 100%;">

                        <%for (int i = 1; i < columnsNumber + 1; i++)
                            {
                                String st = rsm.getColumnLabel(i);
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
                            %><td><%=ent%></td><%

                                }
                            %></tr><%
                                }
                            %>
                        </tr></table><%
                        }
                        catch (SQLException e)
                        {
                            System.out.println(e);
                        %>
                        <h1 style="text-align: center">SQL Error</h1>
                    <%
                        }
                    %>
                    <br><br>
                    <div>
                        <table style="border: 0px none;"> 
                            <td style="text-align: center; border: 0px none;"> <button onclick="closeWindow()">Close</button>
                        </table>
                    </div>
                </div>
            </section>

        </div>
    </body>
    <script>
        function closeWindow()
        {
            close();
        }
    </script>
</html>
