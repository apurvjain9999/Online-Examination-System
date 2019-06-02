/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Teacher;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.Statement;
import java.sql.ResultSet;
import java.sql.Connection;
import java.sql.PreparedStatement;
import javax.servlet.http.HttpSession;

public class StudentAttendence extends HttpServlet {

    static Connection conn = null;
    Statement st = null;
    PreparedStatement pst = null;
    ResultSet rs = null;
    String id = null;
    String classs = null;
    String date = null;
    String status = null;
    String stime = null;
    String etime = null;


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(true);

        id = request.getParameter("id");
        classs = request.getParameter("cmbclass");
        date = request.getParameter("txtdate");
        status = request.getParameter("cmbstatus");
        stime = request.getParameter("cmbstime");
        etime = request.getParameter("cmbetime");

        if (id != null) {
            try {
                conn = connection.getDBConnection.makeConn();
                String query = "Insert into sattendence(id,classs,date,status,stime,etime)values(?,?,?,?,?,?)";
                // System.out.println("aaaaaaa" + query);
                pst = conn.prepareStatement(query);
                pst.setString(1, id);
                pst.setString(2, classs);
                pst.setString(3, date);
                pst.setString(4, status);
                pst.setString(5, stime);
                pst.setString(6, etime);
             
                int j = 0;
                j = pst.executeUpdate();
                if (j > 0) {
           
                    response.sendRedirect("../Teacher/StudentAttendence.jsp");
                    session.setAttribute("msg", "New StudentAttendence is Successfully Registered!!");
                } else {
                    response.sendRedirect("../Teacher/StudentAttendence.jsp");
                    session.setAttribute("msg", "New StudentAttendence Is Not Ragistered!!");
                }

            } catch (Exception e) {
                e.printStackTrace();
            }

        }

    }
}
