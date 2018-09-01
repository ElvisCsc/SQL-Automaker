package com.csc3003s.sqlautomark;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
import java.io.IOException;
import java.sql.*;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Zach
 */
@WebServlet("/Assessment")
public class Assessment extends HttpServlet
{

    private int ID;
    private String name;
    private String type;
    private String database;
    private int questions;
    private int totalMarks;
    private int catA;
    private int catB;
    private int catC;
    private int catD;
    private int catE;
    private int catF;
    private int catG;
    private LocalDate startDate;
    private LocalTime startTime;
    private LocalDate endDate;
    private LocalTime endTime;
    private HttpServletRequest request;
    private HttpServletResponse resp;

    private int attempts;
    private ArrayList<Question> question;
    private ArrayList<String> students;

    private Connection connection;

    public Assessment()
    {

    }

    public void assign()
    {
        try
        {

            Statement statement = connection.createStatement();

            statement.addBatch("use `" + database + "`;");
            statement.executeBatch();
            ResultSet resultset = statement.executeQuery("SELECT * FROM questions;");

            while (resultset.next())
            {
                int questionNumber = Integer.parseInt(resultset.getString("questionNumber"));
                String question = resultset.getString("question");
                String expectedAnswer = resultset.getString("expectedAnswer");
                String category = resultset.getString("category");
                int marks = Integer.parseInt(resultset.getString("marks"));

                Question q = new Question(questionNumber, question, expectedAnswer, category, marks);
                this.question.add(q);
            }

            //`sqlautomarker-individual-records`
            statement.addBatch("use `sqlautomarker-individual-records`;");
            statement.executeBatch();

            Statement statement2 = connection.createStatement();

            for (String student : students)
            {
                String create = "CREATE TABLE `sqlautomarker-individual-records`.`" + student + "-" + name + "` ("
                        + "`questionID` INT NOT NULL AUTO_INCREMENT,"
                        + "`database` VARCHAR(45) NULL,"
                        + "`questionReference` INT NULL,"
                        + "`question` VARCHAR(1000) NULL,"
                        + "`studentAnswer` VARCHAR(500) NULL,"
                        + "`studentMarks` INT NULL,"
                        + "`category` VARCHAR(1) NULL,"
                        + "`totalMarks` INT NULL,"
                        + "PRIMARY KEY (`questionID`));";
                statement2.addBatch(create);
                statement2.executeBatch();

                ArrayList<Question> q = new ArrayList<Question>();

                statement.addBatch("use `" + database + "`;");
                statement.executeBatch();

                ArrayList<Integer> A = new ArrayList<Integer>();
                ArrayList<Integer> B = new ArrayList<Integer>();
                ArrayList<Integer> C = new ArrayList<Integer>();
                ArrayList<Integer> D = new ArrayList<Integer>();
                ArrayList<Integer> E = new ArrayList<Integer>();
                ArrayList<Integer> F = new ArrayList<Integer>();
                ArrayList<Integer> G = new ArrayList<Integer>();

                if (catA != 0)
                {
                    String catA = "SELECT questionNumber FROM questions WHERE category='A'"
                            + "ORDER BY RAND()"
                            + "LIMIT " + this.catA + ";";

                    ResultSet rs = statement.executeQuery(catA);

                    while (rs.next())
                    {
                        A.add(Integer.parseInt(rs.getString("questionNumber")));
                    }
                }
                if (catB != 0)
                {
                    String catB = "SELECT questionNumber FROM questions WHERE category='B'"
                            + "ORDER BY RAND()"
                            + "LIMIT " + this.catB + ";";

                    ResultSet rs = statement.executeQuery(catB);

                    while (rs.next())
                    {
                        B.add(Integer.parseInt(rs.getString("questionNumber")));
                    }
                }
                if (catC != 0)
                {
                    String catC = "SELECT questionNumber FROM questions WHERE category='C'"
                            + "ORDER BY RAND()"
                            + "LIMIT " + this.catC + ";";

                    ResultSet rs = statement.executeQuery(catC);

                    while (rs.next())
                    {
                        C.add(Integer.parseInt(rs.getString("questionNumber")));
                    }
                }
                if (catD != 0)
                {
                    String catD = "SELECT questionNumber FROM questions WHERE category='D'"
                            + "ORDER BY RAND()"
                            + "LIMIT " + this.catD + ";";

                    ResultSet rs = statement.executeQuery(catD);

                    while (rs.next())
                    {
                        D.add(Integer.parseInt(rs.getString("questionNumber")));
                    }
                }
                if (catE != 0)
                {
                    String catE = "SELECT questionNumber FROM questions WHERE category='E'"
                            + "ORDER BY RAND()"
                            + "LIMIT " + this.catE + ";";

                    ResultSet rs = statement.executeQuery(catE);

                    while (rs.next())
                    {
                        E.add(Integer.parseInt(rs.getString("questionNumber")));
                    }
                }
                if (catF != 0)
                {
                    String catF = "SELECT questionNumber FROM questions WHERE category='F'"
                            + "ORDER BY RAND()"
                            + "LIMIT " + this.catF + ";";

                    ResultSet rs = statement.executeQuery(catF);

                    while (rs.next())
                    {
                        F.add(Integer.parseInt(rs.getString("questionNumber")));
                    }
                }
                if (catG != 0)
                {
                    String catG = "SELECT questionNumber FROM questions WHERE category='G'"
                            + "ORDER BY RAND()"
                            + "LIMIT " + this.catG + ";";

                    ResultSet rs = statement.executeQuery(catG);

                    while (rs.next())
                    {
                        G.add(Integer.parseInt(rs.getString("questionNumber")));
                    }
                }

                for (int i = 0; i < this.catA; i++)
                {
                    String sql = "INSERT INTO `sqlautomarker-individual-records`.`" + student + "-" + name + "` "
                            + "(`database`, `questionReference`,`question` , `studentAnswer` ,`studentMarks`, `category`) "
                            + "VALUES ('" + database + "', '" + (A.get(i) + 1) + "', '" + question.get(A.get(i)).getQuestion() + "', null, null, '" + question.get(A.get(i)).getCategory() + "');";
                    statement2.addBatch(sql);
                }
                for (int i = 0; i < catB; i++)
                {
                    String sql = "INSERT INTO `sqlautomarker-individual-records`.`" + student + "-" + name + "` "
                            + "(`database`, `questionReference`,`question` , `studentAnswer` ,`studentMarks`, `category`) "
                            + "VALUES ('" + database + "', '" + (B.get(i) + 1) + "', '" + question.get(B.get(i)).getQuestion() + "', null, null, '" + question.get(B.get(i)).getCategory() + "');";
                    statement2.addBatch(sql);
                }
                for (int i = 0; i < catC; i++)
                {
                    String sql = "INSERT INTO `sqlautomarker-individual-records`.`" + student + "-" + name + "` "
                            + "(`database`, `questionReference`,`question` , `studentAnswer` ,`studentMarks`, `category`) "
                            + "VALUES ('" + database + "', '" + (C.get(i) + 1) + "', '" + question.get(C.get(i)).getQuestion() + "', null, null, '" + question.get(C.get(i)).getCategory() + "');";
                    statement2.addBatch(sql);
                }
                for (int i = 0; i < catD; i++)
                {
                    String sql = "INSERT INTO `sqlautomarker-individual-records`.`" + student + "-" + name + "` "
                            + "(`database`, `questionReference`,`question` , `studentAnswer` ,`studentMarks`, `category`) "
                            + "VALUES ('" + database + "', '" + (D.get(i) + 1) + "', '" + question.get(D.get(i)).getQuestion() + "', null, null, '" + question.get(D.get(i)).getCategory() + "');";
                    statement2.addBatch(sql);
                }
                for (int i = 0; i < catE; i++)
                {
                    String sql = "INSERT INTO `sqlautomarker-individual-records`.`" + student + "-" + name + "` "
                            + "(`database`, `questionReference`,`question` , `studentAnswer` ,`studentMarks`, `category`) "
                            + "VALUES ('" + database + "', '" + (E.get(i) + 1) + "', '" + question.get(E.get(i)).getQuestion() + "', null, null, '" + question.get(E.get(i)).getCategory() + "');";
                    statement2.addBatch(sql);
                }
                for (int i = 0; i < catF; i++)
                {
                    String sql = "INSERT INTO `sqlautomarker-individual-records`.`" + student + "-" + name + "` "
                            + "(`database`, `questionReference`,`question` , `studentAnswer` ,`studentMarks`, `category`) "
                            + "VALUES ('" + database + "', '" + (F.get(i) + 1) + "', '" + question.get(F.get(i)).getQuestion() + "', null, null, '" + question.get(F.get(i)).getCategory() + "');";
                    statement2.addBatch(sql);
                }
                for (int i = 0; i < catG; i++)
                {
                    String sql = "INSERT INTO `sqlautomarker-individual-records`.`" + student + "-" + name + "` "
                            + "(`database`, `questionReference`,`question` , `studentAnswer` ,`studentMarks`, `category`) "
                            + "VALUES ('" + database + "', '" + (G.get(i) + 1) + "', '" + question.get(G.get(i)).getQuestion() + "', null, null, '" + question.get(G.get(i)).getCategory() + "');";
                    statement2.addBatch(sql);
                }

                statement2.executeBatch();

            }

        }
        catch (Exception e)
        {
            System.out.println(e);
        }

    }

    public void reassign()
    {

    }

    public void createSummary()
    {
        Connection connection = new SQL().getConnection();
        try
        {
            Statement statement = connection.createStatement();

            statement.addBatch("use `marks`;");
            statement.executeBatch();

            String create = "CREATE TABLE `marks`.`" + this.name + "` ("
                    + "  `studentNumber` VARCHAR(9) NOT NULL,"
                    + "  `attemptsLeft` INT NOT NULL,"
                    + "  `marks` double DEFAULT NULL,"
                    + "  PRIMARY KEY (`studentNumber`));";

            statement.addBatch(create);
            statement.executeBatch();

            for (String student : students)
            {
                String sql = "INSERT INTO `marks`.`" + name + "` "
                        + "(`studentNumber`, `attemptsLeft`) "
                        + "VALUES ('" + student + "', '" + attempts + "');";
                statement.addBatch(sql);
            }

            statement.executeBatch();
        }
        catch (Exception e)
        {
            System.out.println(e);
        }
    }

    public void fetchStudents()
    {
        try
        {
            Statement statement = connection.createStatement();

            statement.addBatch("use `sqlautomarker`;");
            statement.executeBatch();
            ResultSet resultset = statement.executeQuery("SELECT * FROM Users WHERE Role='Student';");

            while (resultset.next())
            {
                String name = resultset.getString("UserID");
                students.add(name);
            }
        }
        catch (Exception e)
        {
            System.out.println(e);
        }

    }

    public void updateAssessment(String user, String Assessment, String database)
    {
        ArrayList<Question> quest = new ArrayList<Question>();
        try
        {
            Connection connection = new SQL().getConnection();
            Statement statement = connection.createStatement();

            statement.addBatch("use `sqlautomarker`;");
            statement.executeBatch();

            String as = "SELECT * FROM assessments WHERE assessment_name = '" + Assessment + "';";

            ResultSet r = statement.executeQuery(as);
            r.next();

            int a = Integer.parseInt(r.getString("category_a"));

            int b = Integer.parseInt(r.getString("category_b"));
            int c = Integer.parseInt(r.getString("category_c"));
            int d = Integer.parseInt(r.getString("category_d"));
            int e = Integer.parseInt(r.getString("category_e"));
            int f = Integer.parseInt(r.getString("category_f"));
            int g = Integer.parseInt(r.getString("category_g"));
           

            statement.addBatch("use `sqlautomarker-individual-records`;");
            statement.executeBatch();

            String drop = "DROP TABLE `sqlautomarker-individual-records`.`" + user + "-" + Assessment + "`;";
            statement.addBatch(drop);
            statement.executeBatch();

            statement.addBatch("use `" + database + "`;");
            statement.executeBatch();
            ResultSet resultset = statement.executeQuery("SELECT * FROM questions;");

            while (resultset.next())
            {
                int questionNumber = Integer.parseInt(resultset.getString("questionNumber"));
                String question = resultset.getString("question");
                String expectedAnswer = resultset.getString("expectedAnswer");
                String category = resultset.getString("category");
                int marks = Integer.parseInt(resultset.getString("marks"));

                Question q = new Question(questionNumber, question, expectedAnswer, category, marks);
                quest.add(q);
            }

            //`sqlautomarker-individual-records`
            statement.addBatch("use `sqlautomarker-individual-records`;");
            statement.executeBatch();

            Statement statement2 = connection.createStatement();

            String create = "CREATE TABLE `sqlautomarker-individual-records`.`" + user + "-" + Assessment + "` ("
                    + "`questionID` INT NOT NULL AUTO_INCREMENT,"
                    + "`database` VARCHAR(45) NULL,"
                    + "`questionReference` INT NULL,"
                    + "`question` VARCHAR(1000) NULL,"
                    + "`studentAnswer` VARCHAR(500) NULL,"
                    + "`studentMarks` INT NULL,"
                    + "`category` VARCHAR(1) NULL,"
                    + "`totalMarks` INT NULL,"
                    + "PRIMARY KEY (`questionID`));";
            statement2.addBatch(create);
            statement2.executeBatch();

            ArrayList<Question> q = new ArrayList<Question>();

            statement.addBatch("use `" + database + "`;");
            statement.executeBatch();

            ArrayList<Integer> A = new ArrayList<Integer>();
            ArrayList<Integer> B = new ArrayList<Integer>();
            ArrayList<Integer> C = new ArrayList<Integer>();
            ArrayList<Integer> D = new ArrayList<Integer>();
            ArrayList<Integer> E = new ArrayList<Integer>();
            ArrayList<Integer> F = new ArrayList<Integer>();
            ArrayList<Integer> G = new ArrayList<Integer>();

            if (a != 0)
            {
                String catA = "SELECT questionNumber FROM questions WHERE category='A'"
                        + "ORDER BY RAND()"
                        + "LIMIT " + a + ";";

                ResultSet rs = statement.executeQuery(catA);

                while (rs.next())
                {
                    A.add(Integer.parseInt(rs.getString("questionNumber")));
                }
            }
            if (b != 0)
            {
                String catB = "SELECT questionNumber FROM questions WHERE category='B'"
                        + "ORDER BY RAND()"
                        + "LIMIT " + b + ";";

                ResultSet rs = statement.executeQuery(catB);

                while (rs.next())
                {
                    B.add(Integer.parseInt(rs.getString("questionNumber")));
                }
            }
            if (c != 0)
            {
                String catC = "SELECT questionNumber FROM questions WHERE category='C'"
                        + "ORDER BY RAND()"
                        + "LIMIT " + c + ";";

                ResultSet rs = statement.executeQuery(catC);

                while (rs.next())
                {
                    C.add(Integer.parseInt(rs.getString("questionNumber")));
                }
            }
            if (d != 0)
            {
                String catD = "SELECT questionNumber FROM questions WHERE category='D'"
                        + "ORDER BY RAND()"
                        + "LIMIT " + d + ";";

                ResultSet rs = statement.executeQuery(catD);

                while (rs.next())
                {
                    D.add(Integer.parseInt(rs.getString("questionNumber")));
                }
            }
            if (e != 0)
            {
                String catE = "SELECT questionNumber FROM questions WHERE category='E'"
                        + "ORDER BY RAND()"
                        + "LIMIT " + e + ";";

                ResultSet rs = statement.executeQuery(catE);

                while (rs.next())
                {
                    E.add(Integer.parseInt(rs.getString("questionNumber")));
                }
            }
            if (f != 0)
            {
                String catF = "SELECT questionNumber FROM questions WHERE category='F'"
                        + "ORDER BY RAND()"
                        + "LIMIT " + f + ";";

                ResultSet rs = statement.executeQuery(catF);

                while (rs.next())
                {
                    F.add(Integer.parseInt(rs.getString("questionNumber")));
                }
            }
            if (g != 0)
            {
                String catG = "SELECT questionNumber FROM questions WHERE category='G'"
                        + "ORDER BY RAND()"
                        + "LIMIT " + g + ";";

                ResultSet rs = statement.executeQuery(catG);

                while (rs.next())
                {
                    G.add(Integer.parseInt(rs.getString("questionNumber")));
                }
            }

            for (int i = 0; i < a; i++)
            {
                String sql = "INSERT INTO `sqlautomarker-individual-records`.`" + user + "-" + Assessment + "` "
                        + "(`database`, `questionReference`,`question` , `studentAnswer` ,`studentMarks`, `category`) "
                        + "VALUES ('" + database + "', '" + (A.get(i) + 1) + "', '" + quest.get(A.get(i)).getQuestion() + "', null, null, '" + quest.get(A.get(i)).getCategory() + "');";
                statement2.addBatch(sql);
            }
            for (int i = 0; i < b; i++)
            {
                String sql = "INSERT INTO `sqlautomarker-individual-records`.`" + user + "-" + Assessment + "` "
                        + "(`database`, `questionReference`,`question` , `studentAnswer` ,`studentMarks`, `category`) "
                        + "VALUES ('" + database + "', '" + (B.get(i) + 1) + "', '" + quest.get(B.get(i)).getQuestion() + "', null, null, '" + quest.get(B.get(i)).getCategory() + "');";
                statement2.addBatch(sql);
            }
            for (int i = 0; i < c; i++)
            {
                String sql = "INSERT INTO `sqlautomarker-individual-records`.`" + user + "-" + Assessment + "` "
                        + "(`database`, `questionReference`,`question` , `studentAnswer` ,`studentMarks`, `category`) "
                        + "VALUES ('" + database + "', '" + (C.get(i) + 1) + "', '" + quest.get(C.get(i)).getQuestion() + "', null, null, '" + quest.get(C.get(i)).getCategory() + "');";
                statement2.addBatch(sql);
            }
            for (int i = 0; i < d; i++)
            {
                String sql = "INSERT INTO `sqlautomarker-individual-records`.`" + user + "-" + Assessment + "` "
                        + "(`database`, `questionReference`,`question` , `studentAnswer` ,`studentMarks`, `category`) "
                        + "VALUES ('" + database + "', '" + (D.get(i) + 1) + "', '" + quest.get(D.get(i)).getQuestion() + "', null, null, '" + quest.get(D.get(i)).getCategory() + "');";
                statement2.addBatch(sql);
            }
            for (int i = 0; i < e; i++)
            {
                String sql = "INSERT INTO `sqlautomarker-individual-records`.`" + user + "-" + Assessment + "` "
                        + "(`database`, `questionReference`,`question` , `studentAnswer` ,`studentMarks`, `category`) "
                        + "VALUES ('" + database + "', '" + (E.get(i) + 1) + "', '" + quest.get(E.get(i)).getQuestion() + "', null, null, '" + quest.get(E.get(i)).getCategory() + "');";
                statement2.addBatch(sql);
            }
            for (int i = 0; i < f; i++)
            {
                String sql = "INSERT INTO `sqlautomarker-individual-records`.`" + user + "-" + Assessment + "` "
                        + "(`database`, `questionReference`,`question` , `studentAnswer` ,`studentMarks`, `category`) "
                        + "VALUES ('" + database + "', '" + (F.get(i) + 1) + "', '" + quest.get(F.get(i)).getQuestion() + "', null, null, '" + quest.get(F.get(i)).getCategory() + "');";
                statement2.addBatch(sql);
            }
            for (int i = 0; i < g; i++)
            {
                String sql = "INSERT INTO `sqlautomarker-individual-records`.`" + user + "-" + Assessment + "` "
                        + "(`database`, `questionReference`,`question` , `studentAnswer` ,`studentMarks`, `category`) "
                        + "VALUES ('" + database + "', '" + (G.get(i) + 1) + "', '" + quest.get(G.get(i)).getQuestion() + "', null, null, '" + quest.get(G.get(i)).getCategory() + "');";
                statement2.addBatch(sql);
            }

            statement2.executeBatch();

        }
        catch (Exception e)
        {
            System.out.println(e);
        }

    }

    public void createAssessment()
    {

        try
        {
            Connection connection = new SQL().getConnection();
            Statement statement = connection.createStatement();
            String create = "INSERT INTO `sqlautomarker`.`assessments` (`assessment_name`, `assessment_type`, `question_database`, `total_questions`, `category_a`, `category_b`, `category_c`, `category_d`, `category_e`, `category_f`, `category_g`, `start_date`, `start_time`, `end_date`, `end_time`, `total_marks`, `attempts`) VALUES ('" + name + "', '" + type + "', '" + database + "', '" + questions + "', '" + catA + "', '" + catB + "', '" + catC + "', '" + catD + "', '" + catE + "', '" + catF + "', '" + catG + "', '" + startDate.toString() + "', '" + startTime.toString() + "', '" + endDate.toString() + "', '" + endTime.toString() + "', '" + totalMarks + "', '" + attempts + "');";
            statement.executeUpdate(create);
            assign();
        }

        catch (Exception e)
        {
            System.out.println(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse resp) throws ServletException, IOException
    {
        this.request = request;
        this.resp = resp;
        int ID;
        this.name = request.getParameter("assessmentName");
        this.type = request.getParameter("assessmentType");
        this.database = request.getParameter("selectDatabase");
        this.questions = Integer.parseInt(request.getParameter("numQuestions"));
        this.totalMarks = Integer.parseInt(request.getParameter("totMarks"));
        this.catA = Integer.parseInt(request.getParameter("catA"));
        this.catB = Integer.parseInt(request.getParameter("catB"));
        this.catC = Integer.parseInt(request.getParameter("catC"));
        this.catD = Integer.parseInt(request.getParameter("catD"));
        this.catE = Integer.parseInt(request.getParameter("catE"));
        this.catF = Integer.parseInt(request.getParameter("catF"));
        this.catG = Integer.parseInt(request.getParameter("catG"));
        this.attempts = Integer.parseInt(request.getParameter("attempts"));
        this.startDate = LocalDate.parse(request.getParameter("startDate"));
        this.startTime = LocalTime.parse(request.getParameter("startTime"));
        this.endDate = LocalDate.parse(request.getParameter("endDate"));
        this.endTime = LocalTime.parse(request.getParameter("endTime"));

        this.question = new ArrayList<Question>();
        this.students = new ArrayList<String>();

        this.connection = new SQL().getConnection();

        fetchStudents();
        createAssessment();
        createSummary();
        this.resp.sendRedirect("teacherPortal.jsp?");

    }

}
