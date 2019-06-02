/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Student;

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

public class StudentAccountUpdate extends HttpServlet {

    Connection con = null;
    ResultSet rs = null;
    PreparedStatement pst = null;
    String studentid = null;
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

        studentid = request.getParameter("txtid");
        dateofbirth = request.getParameter("txtdob");
        telephone = request.getParameter("telephone");
        mobile = request.getParameter("mobile");
        course = request.getParameter("course");
        emailid = request.getParameter("email");
        occupation = request.getParameter("occupation");
        presentaddress = request.getParameter("txtpre");
        state = request.getParameter("cmbstate");
        city = request.getParameter("txtcity");
        if (studentid != null) {
            try {
                con = connection.getDBConnection.makeConn();
                String query = "Update student set dob='" + dateofbirth + "',telephone='" + telephone + "',mobile='" + mobile + "',class = '" + course + "',email='" + emailid + "',occupation='" + occupation + "',present='" + presentaddress + "',state='" + state + "',city='" + city + "' where id='" + studentid + "'";
                pst = con.prepareStatement(query);
                int j = pst.executeUpdate();
                if (j > 0) {
                    response.sendRedirect("/Student/StudentAccount.jsp");
                    session.setAttribute("msg", "data is Updated  successfully!!!");
                } else {
                    response.sendRedirect("/Student/StudentAccount.jsp");
                    session.setAttribute("msg", "data is Not Updated  successfully!!!");
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}
