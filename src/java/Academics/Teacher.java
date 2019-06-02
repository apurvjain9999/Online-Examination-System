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
import java.sql.Statement;
import java.sql.ResultSet;
import java.sql.Connection;
import java.sql.PreparedStatement;
import javax.servlet.http.HttpSession;

public class Teacher extends HttpServlet {

    static Connection conn = null;
    Statement st = null;
    PreparedStatement pst = null;
    ResultSet rs = null;
    String teacherid = null;
    String teachername = null;
    String gender = null;
    String dateofbirth = null;
    String telephone = null;
    String mobile = null;
    String course = null;
    String emailid = null;
    String father = null;
    String occupation = null;
    String presentaddress = null;
    String permanentaddress = null;
    String state = null;
    String city = null;
    String pwd = null;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(true);

        teacherid = request.getParameter("id");
        pwd = request.getParameter("password");
        teachername = request.getParameter("name");
        gender = request.getParameter("cmbgender");
        dateofbirth = request.getParameter("txtdob");
        telephone = request.getParameter("telephone");
        mobile = request.getParameter("mobile");
        course = request.getParameter("course");
        emailid = request.getParameter("email");
        father = request.getParameter("father");
        occupation = request.getParameter("occupation");
        presentaddress = request.getParameter("txtpre");
        permanentaddress = request.getParameter("txtper");
        state = request.getParameter("cmbstate");
        city = request.getParameter("txtcity");
        if (teacherid != null) {
            try {
                conn = connection.getDBConnection.makeConn();
                String query = "Insert into teacher(id,name,pwd,gender,dob,telephone,mobile,course,email,father,occupation,present,permanent,state,city)values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
                // System.out.println("aaaaaaa" + query);
                pst = conn.prepareStatement(query);
                pst.setString(1, teacherid);
                pst.setString(2, teachername);
                pst.setString(3, pwd);
                pst.setString(4, gender);
                pst.setString(5, dateofbirth);
                pst.setString(6, telephone);
                pst.setString(7, mobile);
                pst.setString(8, course);
                pst.setString(9, emailid);
                pst.setString(10, father);
                pst.setString(11, occupation);
                pst.setString(12, presentaddress);
                pst.setString(13, permanentaddress);
                pst.setString(14, state);
                pst.setString(15, city);
                int j = 0;
                j = pst.executeUpdate();
                if (j > 0) {
                    connection.AutoID.updateCampaignId("teacher", teacherid);
                    response.sendRedirect("Admin/Teacher.jsp");
                    session.setAttribute("msg", "New Teacher is Successfully Registered!!");
                } else {
                    response.sendRedirect("Admin/Teacher.jsp");
                    session.setAttribute("msg", "New Teacher Not Ragistered!!");
                }

            } catch (Exception e) {
                e.printStackTrace();
            }

        }

    }
}
