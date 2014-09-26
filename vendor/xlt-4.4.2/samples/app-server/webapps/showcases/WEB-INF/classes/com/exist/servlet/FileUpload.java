package com.exist.servlet;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@SuppressWarnings( "serial" )
public class FileUpload extends HttpServlet
{
    @SuppressWarnings( "unchecked" )
    protected void doGet( HttpServletRequest req, HttpServletResponse resp ) throws ServletException, IOException
    {
        PrintWriter outp = resp.getWriter();

        /*
         * if initParam deleteFiles = true you can do either do step 1 or step 2
         *
         */
        // Step 1 --- modify the code inside the for loop in your desired
        /*
        ArrayList files = (ArrayList) req.getAttribute( "org.mortbay.servlet.MultiPartFilter.files" );
        for ( int x = 0; x < files.size(); x++ )
        {
            File file1 = (File) files.get( x );
            File outputFile = new File( "outputfile" + ( x + 1 ) );
            file1.renameTo( outputFile );
        }
         */

        StringBuffer buff = new StringBuffer();

        File file1 = (File) req.getAttribute( "userfile1" );

        if( file1 == null || !file1.exists() )
        {
            buff.append( "File does not exist" );
        }
        else if( file1.isDirectory())
        {
            buff.append( "File is a directory" );
        }
        else
        {
            File outputFile = new File( "webapps//showcases//upload//uploads//"+req.getParameter( "userfile1" ) );
            file1.renameTo( outputFile );
            buff.append( "File successfully uploaded." );
        }

		resp.setContentType( "text/html" );

		outp.write( "<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Strict//EN\"\"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd\">\n" );
        outp.write( "<html xmlns=\"http://www.w3.org/1999/xhtml\">\n" );
        outp.write( "<head> \n");
        outp.write( "<meta http-equiv=\"content-type\" content=\"text/html; charset=windows-1250\" />\n" );
        outp.write( "<title>FileUpload page</title></head>\n" );
        outp.write( "<body>" );
        outp.write( "<h2>" + buff.toString() + "</h2>\n" );
        outp.write( "</body>\n" );
        outp.write( "</html>\n" );
    }

    protected void doPost( HttpServletRequest req, HttpServletResponse resp ) throws ServletException, IOException
    {
        doGet( req, resp );
    }

}