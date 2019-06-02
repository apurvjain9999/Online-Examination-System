/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Student;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.PreparedStatement;
import javax.servlet.http.HttpSession;

public class onlineTest extends HttpServlet {

    Connection con = null;
    ResultSet rst = null;
    PreparedStatement pst = null;
    String stu_id = null;
    String option1 = null;
    String option2 = null;
    String option3 = null;
    String option4 = null;
    String count = null;
    String ques_id = null;
    String subject = null;
    int ctr = 0;
    int k = 0;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(true);

        //System.out.println("Calling");
        stu_id = (String) session.getAttribute("STUDENT");
        count = request.getParameter("count");
        ctr = Integer.parseInt(count);
        // System.out.println("Counter :::::::::::::::::" + ctr);
        String sub = request.getParameter("hidsubject");
        System.out.println("Subject              :" + sub);
        int totmarks = 0;
        totmarks = ctr * 2;//total marks       
        String result = "";
        double percentage = 0;
        int j = 0;
        try {
            int marks = 0;
            for (j = 1; j <= ctr; j++) {
                String qid = request.getParameter("quesid" + j);
                String ans = request.getParameter("rdoop1" + j);
                System.out.println(ans);
                con = connection.getDBConnection.makeConn();
                String sql = "select answer from question_master where ques_id='" + qid + "' and sub_id='" + sub + "'";
                pst = con.prepareStatement(sql);
                rst = pst.executeQuery();
                String answer = null;
                if (rst.next()) {
                    answer = rst.getString(1);
                }
                if (answer.equals(ans)) {
                    marks = marks + 2;
                }
            }
            if (totmarks == 0) {
                session.setAttribute("msg","You have submitted no answer");
            }
            try
            {
                percentage = (marks * 100) / totmarks;
                if (percentage > 75) {
                    result = "FIRST DIVISION WITH DISTINCTION";
                } else if (percentage < 75 && percentage > 60) {
                    result = "FIRST DIVISION";
                } else if (percentage < 60 && percentage > 45) {
                    result = "SECOND DIVISION";
                } else if (percentage < 45 && percentage > 30) {
                    result = "THIRD DIVISION";
                } else {
                    result = "FAIL";
                }
            }
            catch (Exception e)
                    {
                        response.sendRedirect("/Student/StudentAccount.jsp");
                    }
            try {
                String QueryString = "insert into onlineresult(id,total,obtain,division,subject,date) values(?,?,?,?,?,now())";
                System.out.println("QueryString : " + QueryString);
                pst = con.prepareStatement(QueryString);
                pst.setString(1, stu_id);
                pst.setInt(2, totmarks);
                pst.setInt(3, marks);
                pst.setString(4, result);
                pst.setString(5, sub);
                k = pst.executeUpdate();
                if (k > 0) {
                    session.setAttribute("Marks", "Total Marks obtained : " + marks + " And Division = " + result);

                    response.sendRedirect("/Student/OnlineTest.jsp");
                } else {
                    session.setAttribute("Marks", "Your Answer is not submited");

                    response.sendRedirect("/Student/OnlineTest.jsp");
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
            pst.close();
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        response.setHeader("Cache-Control", "no-cache");
        response.setHeader("Pragma", "no-cache");
        Runtime r = Runtime.getRuntime();
        r.freeMemory();
        r.gc();
    }
}
