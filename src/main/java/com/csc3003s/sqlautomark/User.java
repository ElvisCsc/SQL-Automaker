package com.csc3003s.sqlautomark;

import java.sql.*;

/**
 * Class to handle users
 *
 * @author Zach
 */
public class User
{

    private String name;
    private String userID;
    private String role;

    /**
     * fetches user's name
     *
     * @return name
     */
    public String getName()
    {
        return name;
    }

    /**
     * gets user user ID
     *
     * @return user ID
     */
    public String getUserID()
    {
        return userID;
    }

    /**
     * fetches role of user
     *
     * @return role
     */
    public String getRole()
    {
        return role;
    }

    /**
     * Constructor method
     *
     * @param name name
     * @param userID user ID
     * @param role role
     */
    public User(String name, String userID, String role)
    {
        this.name = name;
        this.userID = userID;
        this.role = role;

    }

    /**
     * fetches string representation of object
     *
     * @return string representation of object
     */
    @Override
    public String toString()
    {
        return userID + ", " + name + ", " + role;
    }

}
