/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Academics;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.sql.Connection;
import java.sql.Statement;
import java.sql.ResultSet;

/**
 *
 * @author Softavate3
 */
public class Fetch extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/xml");

        PrintWriter out = response.getWriter();
        System.out.println("aaaaaaaaaaaaaaabbbbbbbbbaaaaaaaaaa");
        String pid = request.getParameter("sess");
        System.out.println("pid"+pid);
        String result=null;
        String id=null;
        String name=null;
        try {
            Connection con11 = connection.getDBConnection.makeConn();
            Statement st11 = con11.createStatement();
            String sql = "select sub_id,sub_name from subject where sub_id ='" + pid + "'";
            System.out.println(sql);
            ResultSet rs11 = st11.executeQuery(sql);
            result = "";
            if (rs11.next()) {
                id=rs11.getString(1);
                name = rs11.getString(2);


            }
            result = id + ":~" + name + ":~";
            con11.close();
            st11.close();

        } catch (Exception e) {

        }


        out.write("<status><valid>" + result + "</valid></status>");
        response.setHeader("Cache-Control", "no-cache");
        response.setHeader("Pragma", "no-cache");
        //..... heap memory control.....
        Runtime r = Runtime.getRuntime();
        r.freeMemory();
        r.gc();

    }
}
