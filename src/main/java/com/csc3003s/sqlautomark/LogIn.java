/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.csc3003s.sqlautomark;

import java.sql.Connection;
import java.sql.*;
import java.util.Properties;
import javax.swing.JOptionPane;

/**
 *
 * @author Zach
 */
public class LogIn
{
    
    private String username;
    private String password;
    
    public LogIn(String username, String password) 
    {
        
        this.username = "";
        this.password = "";
        
        System.out.println("123");
        
        //try
        //{
           /* Connection conn = DriverManager.getConnection("jdbc:mysql://sqlautomark.mysql.database.azure.com:3306/sqlautomarker?verifyServerCertificate=true&useSSL=true&requireSSL=true", "mltzac001@sqlautomark", "SQLauto2018");
            
            Statement stmt = conn.createStatement();
            
            String sql = "select * from users where studentNumber = '" + username + "';";

//
            ResultSet rs = stmt.executeQuery(sql);
            rs.next();
            
            if (password.equals(rs.getString("password")))
            {
                
            }
            System.out.println("user = " + rs.getString("studentNumber"));
            System.out.println("password = " + rs.getString("password"));
            
            System.out.println("YES");
            
        }
        catch (Exception e)
        {
            System.out.println(e);
        }
        */
    }
    
}
