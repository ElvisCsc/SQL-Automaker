/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.csc3003s.sqlautomark;

/**
 *
 * @author Zach
 */
public class Result
{
    private int questionID;
    private String question;
    private String studentAnswer;
    private String expectedAnswer;
    private int studentMarks;
    private int outOf;

    public Result(int questionID, String question, String studentAnswer, String expectedAnswer, int studentMarks, int outOf)
    {
        this.questionID = questionID;
        this.question = question;
        this.studentAnswer = studentAnswer;
        this.expectedAnswer = expectedAnswer;
        this.studentMarks = studentMarks;
        this.outOf = outOf;
    }

    public int getQuestionID()
    {
        return questionID;
    }

    public void setQuestionID(int questionID)
    {
        this.questionID = questionID;
    }

    public String getQuestion()
    {
        return question;
    }

    public void setQuestion(String question)
    {
        this.question = question;
    }

    public String getStudentAnswer()
    {
        return studentAnswer;
    }

    public void setStudentAnswer(String studentAnswer)
    {
        this.studentAnswer = studentAnswer;
    }

    public String getExpectedAnswer()
    {
        return expectedAnswer;
    }

    public void setExpectedAnswer(String expectedAnswer)
    {
        this.expectedAnswer = expectedAnswer;
    }

    public int getStudentMarks()
    {
        return studentMarks;
    }

    public void setStudentMarks(int studentMarks)
    {
        this.studentMarks = studentMarks;
    }

    public int getOutOf()
    {
        return outOf;
    }

    public void setOutOf(int outOf)
    {
        this.outOf = outOf;
    }
    
    
    
    
}
