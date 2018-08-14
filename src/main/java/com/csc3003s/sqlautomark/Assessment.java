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

    public Assessment()
    {
   
    }
    
    public void assign()
    {
        try
        {
            Connection connection = new SQL().getConnection();
            Statement statement = connection.createStatement();
          

            statement.addBatch("use `"+database+"`;");
            statement.executeBatch();
            ResultSet resultset = statement.executeQuery("SELECT * FROM questions;");
            
        }
        catch (Exception e)
        {
        }
    }

    public void createAssessment()
    {
        

        try
        {
            Connection connection = new SQL().getConnection();
            Statement statement = connection.createStatement();

            String s = "SELECT MAX('assessmentID') as max FROM `sqlautomarker`.`assessments`;";
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
            System.out.println(next);

            String create = "INSERT INTO `sqlautomarker`.`assessments` (`assessment_name`, `assessment_type`, `question_database`, `total_questions`, `category_a`, `category_b`, `category_c`, `category_d`, `category_e`, `category_f`, `category_g`, `start_date`, `start_time`, `end_date`, `end_time`, `total_marks`) VALUES ('" + name + "', '" + type + "', '" + database + "', '" + questions + "', '" + catA + "', '" + catB + "', '" + catC + "', '" + catD + "', '" + catE + "', '" + catF + "', '" + catG + "', '" + startDate.toString() + "', '" + startTime.toString() + "', '" + endDate.toString() + "', '" + endTime.toString() + "', '" + totalMarks + "');";
            statement.executeUpdate(create);
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
        createAssessment();

    }

}
