package com.csc3003s.sqlautomark;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Facilitates connection with MySQL database
 *
 * @author MLTZAC001
 */
public class SQL
{

    Connection connection = null;

    /**
     * Constructor method
     */
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

    /**
     * fetches connection
     *
     * @return connection
     */
    public Connection getConnection()
    {
        return connection;
    }
}
