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

/**
 *
 * @author Owner
 */
public class Student extends HttpServlet {

    static Connection conn = null;
    Statement st = null;
    PreparedStatement pst = null;
    ResultSet rs = null;
    String studentid = null;
    String pwd = null;
    String studentname = null;
    String classs = null;
    String section = null;
    String gender = null;
    String dateofbirth = null;
    String telephone = null;
    String mobile = null;   
    String emailid = null;
    String father = null;
    String occupation = null;
    String presentaddress = null;
    String permanentaddress = null;
    String state = null;
    String city = null;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(true);
        studentid = request.getParameter("txtid");
        pwd = request.getParameter("txtpassword");
        studentname = request.getParameter("name");
        classs = request.getParameter("class");
        section = request.getParameter("section");
        gender = request.getParameter("cmbgender");
        dateofbirth = request.getParameter("txtdob");
        telephone = request.getParameter("telephone");
        mobile = request.getParameter("mobile");     
        emailid = request.getParameter("email");
        father = request.getParameter("father");
        occupation = request.getParameter("occupation");
        presentaddress = request.getParameter("txtpre");
        permanentaddress = request.getParameter("txtper");
        state = request.getParameter("cmbstate");
        city = request.getParameter("txtcity");
        if (studentid != null) {
            try {
                conn = connection.getDBConnection.makeConn();
                String query = "Insert into student(id,pwd,name,class,section,gender,dob,telephone,mobile,email,father,occupation,present,permanent,state,city)values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
               
                pst = conn.prepareStatement(query);
                pst.setString(1, studentid);
                pst.setString(2, pwd);
                pst.setString(3, studentname);              
                pst.setString(4, classs);
                pst.setString(5, section);
                pst.setString(6, gender);
                pst.setString(7, dateofbirth);
                pst.setString(8, telephone);
                pst.setString(9, mobile);              
                pst.setString(10, emailid);
                pst.setString(11, father);
                pst.setString(12, occupation);
                pst.setString(13, presentaddress);
                pst.setString(14, permanentaddress);
                pst.setString(15, state);
                pst.setString(16, city);
                int j = 0;
                j = pst.executeUpdate();
                if (j > 0) {

                    connection.AutoID.updateCampaignId("student", studentid);
                    session.setAttribute("MSG", "New Student is Registered !!");
                    response.sendRedirect("Admin/Student.jsp");
                } else {
                    session.setAttribute("MSG", "New Student Not Registered!!");
                    response.sendRedirect("Admin/Student.jsp");
                }

            } catch (Exception e) {
                e.printStackTrace();
            }

        }

    }
}
