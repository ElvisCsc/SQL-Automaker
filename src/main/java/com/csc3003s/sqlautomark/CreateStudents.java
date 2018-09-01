/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.csc3003s.sqlautomark;

import java.io.*;
import java.sql.Connection;
import java.sql.Statement;
import java.util.ArrayList;

/**
 *
 * @author Zach
 */
public class CreateStudents
{

    private File students;
    private Connection connection;
    private ArrayList<User> users;

    public CreateStudents(File students)
    {

        this.students = students;
        this.connection = new SQL().getConnection();
        this.users = new ArrayList<User>();
        readFile();

    }

    private void addToDatabase()
    {
        try
        {

            Statement stmt = connection.createStatement();
            String sql = "";
            for (User user : users)
            {
                sql = "INSERT INTO `sqlautomarker`.`Users` (`UserID`, `Name`, `Role`) VALUES ('" + user.getUserID() +"', '" + user.getName() + "', '" + user.getRole() + "');";
                stmt.addBatch(sql);
            }
            stmt.executeBatch();
            stmt.close();
        }
        catch (Exception e)
        {
            System.out.println(e);
        }

    }

    public void readFile()
    {
        try
        {
            BufferedReader f = new BufferedReader(new FileReader(students));

            String s = f.readLine();
            while (s != null)
            {
                String z[] = s.split(";");
                String name = z[0];
                String y[] = name.split(", ");
                String fname = y[1];
                String sname = y[0];
                name = fname+" "+sname;
                String userID = z[1];
                String role = z[2];
                User u = new User(name, userID, role);
                users.add(u);

                s = f.readLine();
            }
            
            for (User user : users)
            {
                System.out.println(user.toString());
            }
            addToDatabase();
        }
        catch (Exception e)
        {
            System.out.println(e);
        }
    }
}
