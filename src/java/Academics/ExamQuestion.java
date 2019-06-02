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

public class ExamQuestion extends HttpServlet {

    static Connection conn = null;
    Statement st = null;
    PreparedStatement pst = null;
    ResultSet rs = null;
    String ques_id = null;
    String sub_id = null;
    String question = null;
    String ans = null;
    String option1 = null;
    String option2 = null;
    String option3 = null;
    String option4 = null;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(true);

        ques_id = connection.AutoID.globalGenId("Q-", "question");
        sub_id = request.getParameter("cmbsubject");
        question = request.getParameter("txtquestion");
        ans = request.getParameter("txtanswer");
        option1 = request.getParameter("txtoption1");
        option2 = request.getParameter("txtoption2");
        option3 = request.getParameter("txtoption3");
        option4 = request.getParameter("txtoption4");


        if (ques_id != null) {
            try {
                conn = connection.getDBConnection.makeConn();
                String query = "insert into question_master(ques_id,sub_id,question,answer,option1,option2,option3,option4)values(?,?,?,?,?,?,?,?)";
                pst = conn.prepareStatement(query);
                pst.setString(1, ques_id);
                pst.setString(2, sub_id);
                pst.setString(3, question);
                pst.setString(4, ans);
                pst.setString(5, option1);
                pst.setString(6, option2);
                pst.setString(7, option3);
                pst.setString(8, option4);


                int j = 0;
                j = pst.executeUpdate();
                if (j > 0) {
                    connection.AutoID.updateCampaignId("question", ques_id);
                    session.setAttribute("MSG", "Question Successfully Added!!");
                    response.sendRedirect("Teacher/OnlineExam.jsp");
                } else {
                    session.setAttribute("MSG", "Question Not Added!!");
                    response.sendRedirect("Teacher/OnlineExam.jsp");
                }

            } catch (Exception e) {
                e.printStackTrace();
            }

        }

    }
}
