/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Academics;

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.http.HttpSession;

public class otp extends HttpServlet {

    Connection con = null;
    ResultSet rs = null;
    PreparedStatement pst = null;
    String uname = null;
   

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(true);
        uname = request.getParameter("name");
        String otp = request.getParameter("otp");
        String real_otp = session.getAttribute("otp").toString();

        
            try {
              
               
                if(otp.equals(real_otp)){
                    System.err.println("inside valideted true");
                       // session.setAttribute("STUDENT", uname);
                        response.sendRedirect("Student/StudentAccount.jsp");

                   
                } else {

                    session.setAttribute("LOGIN", "Invalid otp");
                    response.sendRedirect("Login.jsp");
                }

            } catch (Exception e) {
                e.printStackTrace();
            }


        }

    
}
