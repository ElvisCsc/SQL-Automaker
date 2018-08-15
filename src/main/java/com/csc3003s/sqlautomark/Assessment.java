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

    private ArrayList<Question> question;
    private ArrayList<String> students;

    public Assessment()
    {

    }

    public void assign()
    {
        try
        {
            Connection connection = new SQL().getConnection();
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
                        + "`question` VARCHAR(500) NULL,"
                        + "`studentAnswer` VARCHAR(500) NULL,"
                        + "`studentMarks` INT NULL,"
                        + "`totalMarks` INT NULL,"
                        + "`category` VARCHAR(1) NULL,"
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
                            + "(`database`, `questionReference`,`question` , `studentAnswer` ,`studentMarks`, `totalMarks`, `category`) "
                            + "VALUES ('" + database + "', '" + A.get(i) + "', '" + question.get(A.get(i)).getQuestion() + "', null, null, '" + question.get(A.get(i)).getMarks() + "', '" + question.get(A.get(i)).getCategory() + "');";
                    statement2.addBatch(sql);
                }
                for (int i = 0; i < catB; i++)
                {
                    String sql = "INSERT INTO `sqlautomarker-individual-records`.`" + student + "-" + name + "` "
                            + "(`database`, `questionReference`,`question` , `studentAnswer` ,`studentMarks`, `totalMarks`, `category`) "
                            + "VALUES ('" + database + "', '" + B.get(i) + "', '" + question.get(B.get(i)).getQuestion() + "', null, null, '" + question.get(B.get(i)).getMarks() + "', '" + question.get(B.get(i)).getCategory() + "');";
                    statement2.addBatch(sql);
                }
                for (int i = 0; i < catC; i++)
                {
                    String sql = "INSERT INTO `sqlautomarker-individual-records`.`" + student + "-" + name + "` "
                            + "(`database`, `questionReference`,`question` , `studentAnswer` ,`studentMarks`, `totalMarks`, `category`) "
                            + "VALUES ('" + database + "', '" + C.get(i) + "', '" + question.get(C.get(i)).getQuestion() + "', null, null, '" + question.get(C.get(i)).getMarks() + "', '" + question.get(C.get(i)).getCategory() + "');";
                    statement2.addBatch(sql);
                }
                for (int i = 0; i < catD; i++)
                {
                    String sql = "INSERT INTO `sqlautomarker-individual-records`.`" + student + "-" + name + "` "
                            + "(`database`, `questionReference`,`question` , `studentAnswer` ,`studentMarks`, `totalMarks`, `category`) "
                            + "VALUES ('" + database + "', '" + D.get(i) + "', '" + question.get(D.get(i)).getQuestion() + "', null, null, '" + question.get(D.get(i)).getMarks() + "', '" + question.get(D.get(i)).getCategory() + "');";
                    statement2.addBatch(sql);
                }
                for (int i = 0; i < catE; i++)
                {
                    String sql = "INSERT INTO `sqlautomarker-individual-records`.`" + student + "-" + name + "` "
                            + "(`database`, `questionReference`,`question` , `studentAnswer` ,`studentMarks`, `totalMarks`, `category`) "
                            + "VALUES ('" + database + "', '" + E.get(i) + "', '" + question.get(E.get(i)).getQuestion() + "', null, null, '" + question.get(E.get(i)).getMarks() + "', '" + question.get(E.get(i)).getCategory() + "');";
                    statement2.addBatch(sql);
                }
                for (int i = 0; i < catF; i++)
                {
                    String sql = "INSERT INTO `sqlautomarker-individual-records`.`" + student + "-" + name + "` "
                            + "(`database`, `questionReference`,`question` , `studentAnswer` ,`studentMarks`, `totalMarks`, `category`) "
                            + "VALUES ('" + database + "', '" + F.get(i) + "', '" + question.get(F.get(i)).getQuestion() + "', null, null, '" + question.get(F.get(i)).getMarks() + "', '" + question.get(F.get(i)).getCategory() + "');";
                    statement2.addBatch(sql);
                }
                for (int i = 0; i < catG; i++)
                {
                    String sql = "INSERT INTO `sqlautomarker-individual-records`.`" + student + "-" + name + "` "
                            + "(`database`, `questionReference`,`question` , `studentAnswer` ,`studentMarks`, `totalMarks`, `category`) "
                            + "VALUES ('" + database + "', '" + G.get(i) + "', '" + question.get(G.get(i)).getQuestion() + "', null, null, '" + question.get(G.get(i)).getMarks() + "', '" + question.get(G.get(i)).getCategory() + "');";
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

    public void fetchStudents()
    {
        try
        {
            Connection connection = new SQL().getConnection();
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

    public void createAssessment()
    {

        try
        {
            Connection connection = new SQL().getConnection();
            Statement statement = connection.createStatement();

            /*String s = "SELECT MAX('assessmentID') as max FROM `sqlautomarker`.`assessments`;";
            ResultSet rs = statement.executeQuery(s);
            int next = 0;
            while (rs.next())
            {
                String res = rs.getString("max");
                if (res == null)
                {
                    next = 1;
                }
                else
                {
                    next = Integer.parseInt(res) + 1;
                }
            }
            System.out.println(next);*/
            String create = "INSERT INTO `sqlautomarker`.`assessments` (`assessment_name`, `assessment_type`, `question_database`, `total_questions`, `category_a`, `category_b`, `category_c`, `category_d`, `category_e`, `category_f`, `category_g`, `start_date`, `start_time`, `end_date`, `end_time`, `total_marks`) VALUES ('" + name + "', '" + type + "', '" + database + "', '" + questions + "', '" + catA + "', '" + catB + "', '" + catC + "', '" + catD + "', '" + catE + "', '" + catF + "', '" + catG + "', '" + startDate.toString() + "', '" + startTime.toString() + "', '" + endDate.toString() + "', '" + endTime.toString() + "', '" + totalMarks + "');";
            statement.executeUpdate(create);
            assign();
        }

        catch (Exception e)
        {
            System.out.println(e);
        }
    }

    public void assignQuestions()
    {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse resp) throws ServletException, IOException
    {
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

        this.startDate = LocalDate.parse(request.getParameter("startDate"));
        this.startTime = LocalTime.parse(request.getParameter("startTime"));
        this.endDate = LocalDate.parse(request.getParameter("endDate"));
        this.endTime = LocalTime.parse(request.getParameter("endTime"));

        this.question = new ArrayList<Question>();
        this.students = new ArrayList<String>();

        fetchStudents();
        createAssessment();

    }

}
