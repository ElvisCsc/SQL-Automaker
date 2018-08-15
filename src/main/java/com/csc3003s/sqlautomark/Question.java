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
public class Question
{

    private int questionNumber;
    private String question;
    private String expectedAnswer;
    private String category;
    private int marks;

    public int getQuestionNumber()
    {
        return questionNumber;
    }

    public void setQuestionNumber(int questionNumber)
    {
        this.questionNumber = questionNumber;
    }

    public String getQuestion()
    {
        return question;
    }

    public void setQuestion(String question)
    {
        this.question = question;
    }

    public String getExpectedAnswer()
    {
        return expectedAnswer;
    }

    public void setExpectedAnswer(String expectedAnswer)
    {
        this.expectedAnswer = expectedAnswer;
    }

    public String getCategory()
    {
        return category;
    }

    public void setCategory(String category)
    {
        this.category = category;
    }

    public int getMarks()
    {
        return marks;
    }

    public void setMarks(int marks)
    {
        this.marks = marks;
    }

    public Question(int questionNumber, String question, String expectedAnswer, String category, int marks)
    {
        this.questionNumber = questionNumber;
        this.question = question;
        this.expectedAnswer = expectedAnswer;
        this.category = category;
        this.marks = marks;
    }

    @Override
    public String toString()
    {
        return questionNumber+"\t"+question+"\t"+expectedAnswer+"\t"+category+"\t"+marks;
    }

}
