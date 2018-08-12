//package com.csc3003s.sqlautomark;


import java.io.*;
import java.util.Iterator;
import java.util.List;
import java.util.logging.*;
import javax.servlet.*;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.*;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

class FileUploadHandler 
{
    
    HttpServletRequest request;
    public FileUploadHandler()
    {
        System.out.println("invoked&*********");
    }

    

    protected void uploadFile() throws ServletException, IOException
    {
        System.out.println("wwjdnedjcnsk");
    /*   File file;
    int maxFileSize = 5000 * 1024;
    int maxMemSize = 5000 * 1024;
    String filePath = "C:\\UsersZach\\Desktop\\SQLautomark\\src\\main\\resources\\";
    String contentType = request.getContentType();
    if ((contentType.indexOf("multipart/form-data") >= 0))
    {
        DiskFileItemFactory factory = new DiskFileItemFactory();
        factory.setSizeThreshold(maxMemSize);
        factory.setRepository(new File("c:\\temp"));
        ServletFileUpload upload = new ServletFileUpload(factory);
        upload.setSizeMax(maxFileSize);
        try
        {
            List fileItems = upload.parseRequest(request);
            Iterator i = fileItems.iterator();
            while (i.hasNext())
            {
                FileItem fi = (FileItem) i.next();
                if (!fi.isFormField())
                {
                    String fieldName = fi.getFieldName();
                    String fileName = fi.getName();
                    boolean isInMemory = fi.isInMemory();
                    long sizeInBytes = fi.getSize();
                    file = new File(filePath + "yourFileName");
                    fi.write(file);
                    System.out.println("Uploaded Filename: " + filePath + fileName + "<br>");
                }
            }
        }
        catch (Exception ex)
        {
            System.out.println(ex);
        }
    }
    else
    {
        System.out.println("Error in file upload.");
    }*/
    }


    protected void doGet(HttpServletRequest request, HttpServletResponse resp) throws ServletException, IOException
    {
        File file;
    int maxFileSize = 5000 * 1024;
    int maxMemSize = 5000 * 1024;
    String filePath = "C:\\UsersZach\\Desktop\\SQLautomark\\src\\main\\resources\\";
    String contentType = request.getContentType();
    if ((contentType.indexOf("multipart/form-data") >= 0))
    {
        DiskFileItemFactory factory = new DiskFileItemFactory();
        factory.setSizeThreshold(maxMemSize);
        factory.setRepository(new File("c:\\temp"));
        ServletFileUpload upload = new ServletFileUpload(factory);
        upload.setSizeMax(maxFileSize);
        try
        {
            List fileItems = upload.parseRequest(request);
            Iterator i = fileItems.iterator();
            while (i.hasNext())
            {
                FileItem fi = (FileItem) i.next();
                if (!fi.isFormField())
                {
                    String fieldName = fi.getFieldName();
                    String fileName = fi.getName();
                    boolean isInMemory = fi.isInMemory();
                    long sizeInBytes = fi.getSize();
                    file = new File(filePath + "yourFileName");
                    fi.write(file);
                    System.out.println("Uploaded Filename: " + filePath + fileName + "<br>");
                }
            }
        }
        catch (Exception ex)
        {
            System.out.println(ex);
        }
    }
    else
    {
        System.out.println("Error in file upload.");
    }  }

    
}
