/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.csc3003s.sqlautomark;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

/**
 *
 * @author Zach
 */
public class MarkQuestion
{

    private Connection connection;
    private String database;
    private int mark;
    private String expected;
    private String actual;

    public MarkQuestion(String expected, String actual, int marks, String database,Connection connection)
    {
        this.connection = connection;
        this.database = database;
        this.expected = expected;
        this.actual = actual;
        this.mark = marks;
    }

    public void assignMark(int x)
    {
        
        switch (x)
        {
            case 0:
                mark=mark;
                break;

            case 1:
                mark= (int)mark/2;
                break;

            case 2:
                mark=0;
                break;
        }
    }

    public int markQuestion()
    {
        Connection connection = new SQL().getConnection();

        if (actual.isEmpty()||expected.isEmpty())
        {
            assignMark(2);
        }
        else
        {
            try
        {
            Statement statement = connection.createStatement();

            statement.addBatch("use `" + database + "`");

            statement.executeBatch();

            String s = expected;
            ResultSet rs = statement.executeQuery(s);

            Statement statement1 = connection.createStatement();

            String s1 = actual;
            ResultSet rs1 = statement1.executeQuery(s1);
            ResultSetMetaData rsm1 = rs1.getMetaData();

            int x = compareResultSets(rs, rs1);
            assignMark(x);
            
            

        }
        catch (SQLException e)
        {
            assignMark(1);
            System.out.println(e);
        }
        }
        
        return mark;

    }

    public int compareResultSets(ResultSet resultSet1, ResultSet resultSet2) throws SQLException
    {
        int x = 0;
        ResultSetMetaData rsm = resultSet1.getMetaData();
        int columnsNumber = rsm.getColumnCount();
        ResultSetMetaData rsm2 = resultSet2.getMetaData();
        int columnsNumber2 = rsm2.getColumnCount();
        int row1 = 0;
        int row2 = 0;

        while (resultSet1.next())
        {
            row1++;
        }
        resultSet1.beforeFirst();
        while (resultSet2.next())
        {
            row2++;
        }
        resultSet2.beforeFirst();

        if (row1 != row2)
        {
            x = 2;

        }
        else if (columnsNumber != columnsNumber2)
        {
            x = 2;
        }
        else
        {
            while (resultSet1.next())
            {
                resultSet2.next();

                for (int i = 1; i <= columnsNumber; i++)
                {

                    if (resultSet1.getString(i) == null || resultSet2.getString(i) == null)
                    {
                        if (!(resultSet1.getString(i) == null && resultSet2.getString(i) == null))
                        {
                            x = 2;
                        }
                    }
                    else if (!resultSet1.getString(i).equals(resultSet2.getString(i)))
                    {
                        x = 2;
                    }
                }
            }
        }

        return x;
        
    }
}
