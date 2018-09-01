/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.csc3003s.sqlautomark;

import java.io.IOException;
import java.sql.Connection;
import java.sql.*;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.Properties;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.swing.JOptionPane;

/**
 *
 * @author Zach
 */
public class LogIn extends HttpServlet
{

    private String username;
    private String password;
    private int role;

    public LogIn(String username, String password)
    {
        this.username = username;
        this.password = password;
        this.role = 2;
    }

    public int LogInUser()
    {

        try
        {

            Connection connection = new SQL().getConnection();
            Statement stmt = connection.createStatement();
            Statement stmt2 = connection.createStatement();

            String sql = "SELECT * FROM sqlautomarker.Users WHERE UserID='" + username + "';";
            ResultSet rs = stmt.executeQuery(sql);

            String sql2 = "SELECT Password FROM sqlautomarker.Password where UserID='" + username + "';";
            ResultSet rs2 = stmt2.executeQuery(sql2);
            while (rs.next())
            {
                rs2.next();
                String p = rs2.getString("Password");
                String role = rs.getString("Role");

                if (p.equals(password))
                {

                    if (role.equals("Lecturer"))
                    {
                        this.role = 0;

                    }
                    if (role.equals("Student"))
                    {
                        this.role = 1;
                    }
                }
                else
                {

                    this.role = 2;
                }

            }

        }
        catch (Exception e)
        {
            System.out.println(e);
        }
        return this.role;
    }

    public int getRole()
    {
        int r = role;
        return r;
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse resp) throws ServletException, IOException
    {
        System.out.println("WKJDKNJSDCKEDN");
        //this.resp.sendRedirect("teacherPortal.jsp?");

    }
}
