<%-- 
    Document   : Facilitiates the uploading of a file 
    Created on : 10 Aug 2018, 7:31:05 AM
    Author     : Zach
--%>

<%@page import="com.csc3003s.sqlautomark.*"%>
<%@page import="java.nio.file.*"%>
<%@page import="javax.script.*"%>
<%@page import="java.nio.charset.*"%>
<%@page import="javax.script.*"%>
<%@page import="javax.script.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*, javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="org.apache.commons.fileupload.*" %>
<%@ page import="org.apache.commons.fileupload.disk.*" %>
<%@ page import="org.apache.commons.fileupload.servlet.*" %>
<%@ page import="org.apache.commons.io.output.*" %>
<html>
    <body onload="Close()">
        <%
            File file = null;
            int maximumFileSize = 5000 * 1024;
            int maximumMemorySize = 5000 * 1024;

            //sets file path
            String filePath = "C:\\" + "\\Users\\Zach\\Desktop\\SQLautomark\\src\\main\\resources\\";
            String contentType = request.getContentType();

            if ((contentType.indexOf("multipart/form-data") >= 0))
            {
                DiskFileItemFactory factory = new DiskFileItemFactory();
                factory.setSizeThreshold(maximumMemorySize);
                factory.setRepository(new File("c:\\temp"));
                ServletFileUpload upload = new ServletFileUpload(factory);
                upload.setSizeMax(maximumFileSize);
                try
                {
                    List fileItems = upload.parseRequest(request);
                    Iterator i = fileItems.iterator();
                    while (i.hasNext())
                    {
                        FileItem fi = (FileItem) i.next();
                        String name = fi.getName();
                        if (!fi.isFormField())
                        {
                            String fieldName = fi.getFieldName();
                            String fileName = fi.getName();
                            boolean isInMemory = fi.isInMemory();
                            long sizeInBytes = fi.getSize();
                            file = new File(filePath + name);
                            fi.write(file);
                        }
                    }
                    CreateStudents c = new CreateStudents(file);
                }
                catch (Exception ex)
                {
                    System.out.println(ex);
                }
            }
            else
            {
        %>
        <script>
            alert('Error in file upload');
        </script>
        <%
            }
        %>
    </body>
    <script>
        /**
         * close window
         * @returns {undefined} closed window
         */
        function Close()
        {
            alert("Students successfully added");
            window.close();
        }
    </script>
</html>