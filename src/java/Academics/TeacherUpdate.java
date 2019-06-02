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
import java.sql.ResultSet;
import java.sql.PreparedStatement;
import javax.servlet.http.HttpSession;

public class TeacherUpdate extends HttpServlet {

    Connection con = null;
    ResultSet rs = null;
    PreparedStatement pst = null;
    String teacherid = null;
    String teachername = null;
    String classs = null;
    String section = null;
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

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(true);

        teacherid = request.getParameter("txtid");
        System.out.println("bbbbbbb" + teacherid);
        teachername = request.getParameter("name");
        classs = request.getParameter("class");
        section = request.getParameter("section");
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
                con = connection.getDBConnection.makeConn();
                String query = "Update teacher set name='" + teachername + "',gender='" + gender + "',dob='" + dateofbirth + "',telephone='" + telephone + "',mobile='" + mobile + "',course = '" + course + "',email='" + emailid + "',father='" + father + "',occupation='" + occupation + "',present='" + presentaddress + "',permanent='" + permanentaddress + "',state='" + state + "',city='" + city + "' where id='" + teacherid + "'";
                pst = con.prepareStatement(query);
                int j = pst.executeUpdate();
                if (j > 0) {
                    response.sendRedirect("/Admin/TeacherList.jsp");
                    session.setAttribute("msg", "data is Updated  successfully!!!");
                } else {
                    response.sendRedirect("/Admin/TeacherList.jsp");
                    session.setAttribute("msg", "data is Not Updated  successfully!!!");
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}
