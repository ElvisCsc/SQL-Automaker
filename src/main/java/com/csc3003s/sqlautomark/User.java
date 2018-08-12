/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.csc3003s.sqlautomark;

import java.sql.*;

/**
 *
 * @author Zach
 */
public class User
{

    private String name;
    private String userID;
    private String role;

    public String getName()
    {
        return name;
    }

    public String getUserID()
    {
        return userID;
    }

    public String getRole()
    {
        return role;
    }
    

    public User(String name, String userID, String role)
    {
        this.name = name;
        this.userID = userID;
        this.role = role;
        
    }

    @Override
    public String toString()
    {
        return userID+", "+name+", "+role;
    }

   

}
