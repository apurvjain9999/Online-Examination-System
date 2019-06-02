/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Teacher;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.sql.Connection;
import java.sql.Statement;
import java.sql.ResultSet;

/**
 *
 * @author Softavate3
 */
public class PasswordMessage1 extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/xml");
        HttpSession session = request.getSession(true);
        String id = (String) session.getAttribute("TEACHER");
        PrintWriter out = response.getWriter();
        String result = null;

        if (id != null) {

            try {
                Connection con = connection.getDBConnection.makeConn();
                Statement st = con.createStatement();
                String sql = "select pwd from teacher where id = '" + id + "'";
                ResultSet rs = st.executeQuery(sql);               
                if (rs.next()) {
                   result = rs.getString(1);

                    out.write("<status><sname>" + result + "</sname></status>");


                }

            } catch (Exception e) {
            }



        }
    }
}
