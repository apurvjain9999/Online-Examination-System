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
public class ValidateID extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String result = null;
        String code = null;
        response.setContentType("text/xml");
        PrintWriter out = response.getWriter();
        code = request.getParameter("sess");
        System.out.println("value of "+code);
        Connection con11 = connection.getDBConnection.makeConn();
        if (con11 != null) {

            try {
                Statement st11 = con11.createStatement();
                String sql = "select id from student where id = '" + code + "'";
                ResultSet rs11 = st11.executeQuery(sql);
                result = "f";
                if (rs11.next()) {
                    result = "t";
                }

                out.write("<status><valid>" + result + "</valid></status>");
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}
