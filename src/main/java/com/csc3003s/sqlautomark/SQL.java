/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.csc3003s.sqlautomark;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Zach
 */
public class SQL
{

    Connection connection = null;
   

    public SQL()
    {
        try
        {
            connection = DriverManager.getConnection("jdbc:mysql://sqlautomarker.cdtrwjzldbjr.us-east-1.rds.amazonaws.com:3306/?user=mltzac001", "mltzac001", "SQLauto2018");
        }
        catch (SQLException ex)
        {
            ex.printStackTrace();
        }
    }

    public Connection getConnection()
    {
        return connection;

    }
}
