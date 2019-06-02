/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package connection;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.RequestDispatcher;

/**
 *
 * @author Team@JavaForum
 */
public class Logout extends HttpServlet {

    String logtype = null;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        logtype = request.getParameter("utype");

        if (logtype.equalsIgnoreCase("admin")) {
            HttpSession session = request.getSession();
            session.setAttribute("ADMIN", null);
            session.removeAttribute("ADMIN");
            session.invalidate();
            RequestDispatcher rd = request.getRequestDispatcher("Login.jsp");
            rd.forward(request, response);
        }
        if (logtype.equalsIgnoreCase("teacher")) {
            HttpSession session = request.getSession();
            session.setAttribute("TEACHER", null);
            session.setAttribute("MSG", null);
            session.removeAttribute("TEACHER");
            session.removeAttribute("MSG");

            session.invalidate();
            RequestDispatcher rd = request.getRequestDispatcher("Login.jsp");
            rd.forward(request, response);
        }
        if (logtype.equalsIgnoreCase("student")) {
            HttpSession session = request.getSession();
            session.setAttribute("STUDENT", null);
            session.setAttribute("MSG", null);
            session.removeAttribute("STUDENT");
            session.removeAttribute("MSG");

            session.invalidate();
            RequestDispatcher rd = request.getRequestDispatcher("Login.jsp");
            rd.forward(request, response);
        }


    }
}
