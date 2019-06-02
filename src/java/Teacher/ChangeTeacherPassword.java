
package Teacher;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.PreparedStatement;
import javax.servlet.http.HttpSession;
public class ChangeTeacherPassword extends HttpServlet {

    Connection con = null;
    ResultSet rs = null;
    PreparedStatement pst = null;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    HttpSession session = request.getSession(true);
        String old = request.getParameter("txtoldpwd");
        String newpass = request.getParameter("txtnewpwd");

        if (old != null) {
            try {
                con = connection.getDBConnection.makeConn();
                String sql = "Update teacher set pwd='" + newpass + "'where  pwd='" + old + "'";
                //System.out.println(newpass);
                pst = con.prepareStatement(sql);
                int j = pst.executeUpdate();
                if (j > 0) {
                    response.sendRedirect("Teacher/ChangePassword.jsp");
                     session.setAttribute("msg", "Password is Updated  successfully!!!");
                } else {
                    response.sendRedirect("Teacher/ChangePassword.jsp");
                     session.setAttribute("msg", "Password is Not Updated  successfully!!!");
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}
