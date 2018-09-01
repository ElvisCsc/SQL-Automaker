<%-- 
    Document   : markAssessment
    Created on : 16 Aug 2018, 10:42:11 PM
    Author     : Zach
--%>

<%@page import="com.csc3003s.sqlautomark.MarkQuestion"%>
<%@page import="com.csc3003s.sqlautomark.Question"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.csc3003s.sqlautomark.SQL"%>
<%@page import="java.util.Base64.*"%>
<%@page import="java.util.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="quiz.css" rel="stylesheet" type="text/css">
        <title>Results</title>
    </head>
    <body>
        <div class="loader"></div>
        <%
            ArrayList<Question> qus = new ArrayList<Question>();
            String s = request.getParameter("set");
            String database = request.getParameter("db");
            String qs = request.getParameter("qs");
            String u = request.getParameter("u");
            String a = request.getParameter("a");
            String at = request.getParameter("attempt");

            Decoder decoder = Base64.getDecoder();
            byte[] q = decoder.decode(s);
            byte quest[] = decoder.decode(qs);
            byte db[] = decoder.decode(database);
            byte ass[] = decoder.decode(a);
            byte us[] = decoder.decode(u);
            byte att[] = decoder.decode(at);

            String decodedString = new String(q);
            String questions = new String(quest);
            String dbName = new String(db);
            String user = new String(us);
            String assessment = new String(ass);
            String attempt = new String(att);
         %>
         <p hidden id="<%="assessment"%>"><%=assessment%></p>
         <p hidden id="<%="user"%>"><%=user%></p>
        <%

            String ans[] = decodedString.split("\",\"");
            if (ans[0].startsWith("\""))
            {
                ans[0] = ans[0].substring(1);
            }
            if (ans[ans.length - 1].contains("\""))
            {
                ans[ans.length - 1] = ans[ans.length - 1].substring(0, ans[ans.length - 1].length() - 1);
            }

            String z[] = questions.split(" ");
            ArrayList<Integer> x = new ArrayList<Integer>();
            for (int i = 0; i < z.length; i++)
            {
                x.add(new Integer(z[i]));
            }

            Connection connection = new SQL().getConnection();
            Statement statement = connection.createStatement();

            statement.addBatch("use `" + dbName + "`;");
            statement.executeBatch();

            ResultSet qrs = statement.executeQuery("SELECT * FROM questions;");

            while (qrs.next())
            {
                int questionNumber = Integer.parseInt(qrs.getString("questionNumber"));
                String question = qrs.getString("question");
                String expectedAnswer = qrs.getString("expectedAnswer");
                String category = qrs.getString("category");
                int marks = Integer.parseInt(qrs.getString("marks"));

                Question qu = new Question(questionNumber, question, expectedAnswer, category, marks);
                qus.add(qu);
            }

            ArrayList<String> expected = new ArrayList<String>();
            ArrayList<String> given = new ArrayList<String>();
            ArrayList<Integer> marks = new ArrayList<Integer>();

            for (int i = 0; i < ans.length; i++)
            {
                given.add(ans[i]);

            }
            for (Integer number : x)
            {
                expected.add(qus.get(number - 1).getExpectedAnswer() + "");
                marks.add(qus.get(number - 1).getMarks());
            }

            ArrayList<Integer> studentMarks = new ArrayList<Integer>();
            for (int i = 0; i < ans.length; i++)
            {
                MarkQuestion m = new MarkQuestion(expected.get(i), given.get(i), marks.get(i), dbName, connection);
                studentMarks.add(m.markQuestion());
            }

            String name = user + "-" + assessment;
            statement.addBatch("use `sqlautomarker-individual-records`;");
            statement.executeBatch();

            int count = 0;
            for (Integer elem : x)
            {

                String give = given.get(count);
                give = give.replace("'", "\\'");
                give = give.replace("\"", "\\\"");
                System.out.println(give);

                String n = "UPDATE `" + name + "` SET `studentAnswer` = \"" + give + "\", `studentMarks` = '" + studentMarks.get(count) + "' WHERE (`questionReference` = '" + elem + "');";

                statement.addBatch(n);
                count++;
            }

            int totMarks = 0;
            for (Integer elem : studentMarks)
            {
                totMarks += elem.intValue();
            }

            statement.addBatch("INSERT INTO `" + name + "` (`totalMarks`) VALUES ('" + totMarks + "');");
            statement.executeBatch();

            statement.addBatch("use `marks`;");
            statement.executeBatch();

            String m = "SELECT attemptsLeft FROM `" + assessment + "` WHERE studentNumber = '" + user + "';";
            ResultSet r = statement.executeQuery(m);
            r.next();
            int attemptsLeft = Integer.parseInt(r.getString("attemptsLeft"));
            if (attemptsLeft != 0)
            {
                attemptsLeft--;
            }
            else
            {
                attemptsLeft = 0;
            }

            String up = "UPDATE `" + assessment + "` SET `attemptsLeft` = '" + attemptsLeft + "' WHERE (`studentNumber` = '" + user + "');";
            statement.addBatch(up);
            up = "UPDATE `" + assessment + "` SET `marks` = '" + totMarks + "' WHERE (`studentNumber` = '" + user + "');";
            statement.addBatch(up);
            statement.executeBatch();

            System.out.println(attemptsLeft);


        %>

    </body>
</html>
<script>
    window.addEventListener('DOMContentLoaded', function ()
    {
        alert('done');


    });

    function newTab(name, user)
    {

        var a = btoa(name);
        var u = btoa(user);
        var url = "resultsPage.jsp?a=" + a + "&u=" + u;
        popupWindow = window.open(url);
    }

</script>
<style>
    .loader {
        border: 16px solid #f3f3f3;
        border-radius: 50%;
        border-top: 16px solid #3498db;
        width: 120px;
        height: 120px;
        -webkit-animation: spin 2s linear infinite; /* Safari */
        animation: spin 2s linear infinite;
    }

    /* Safari */
    @-webkit-keyframes spin {
        0% { -webkit-transform: rotate(0deg); }
        100% { -webkit-transform: rotate(360deg); }
    }

    @keyframes spin {
        0% { transform: rotate(0deg); }
        100% { transform: rotate(360deg); }
    }
</style>
