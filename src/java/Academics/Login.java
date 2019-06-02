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
import java.util.Random;
import javax.servlet.http.HttpSession;
import java.util.Properties;    
import javax.mail.*;    
import javax.mail.internet.*;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class Login extends HttpServlet {

    Connection con = null;
    ResultSet rs = null;
    PreparedStatement pst = null;
    String uname = null;
    String pass = null;
    String utype = null;
    Properties emailProperties = null;
    Session mailSession = null;
    MimeMessage emailMessage = null;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(true);
        utype = request.getParameter("cmbtype");
        uname = request.getParameter("name");
        pass = request.getParameter("password");
        
        if (pass != null) {
            try {
                con = connection.getDBConnection.makeConn();
                String query = "select id,pwd from " + utype + " where id='" + uname + "'and pwd='" + pass + "'";

                pst = con.prepareStatement(query);
                rs = pst.executeQuery();
                if (rs.next()) {
                    if (utype.equals("admin")) {
                        session.setAttribute("ADMIN", uname);
                        response.sendRedirect("Admin/StudentList.jsp");
                    } else if (utype.equals("student")) {
                        Random rand = new Random();
                        int n = rand.nextInt(999999) + 100000;

                        String txtpassword = Integer.toString(n);
                        System.err.println("otp="+txtpassword);
                        Connection conn = null;
                        ResultSet rs1 = null;
                        PreparedStatement pst1 = null;
                        
                        
                        try {
                            conn = connection.getDBConnection.makeConn();
                            String q1 = "select email from student where id='" + uname + "'";
                            pst1 = conn.prepareStatement(q1);
                            rs1 = pst1.executeQuery();
                            rs1.next();
                            System.out.println("Email: " + rs1.getString(1));
                            String email[] = rs1.getString(1).split(" ");
                            
                            String text = "Your otp for Student Login is : " + txtpassword;
                            session.setAttribute("otp", txtpassword);
                            Login javaEmail = new Login();
                            javaEmail.setMailServerProperties();
                            javaEmail.createEmailMessage(text,email);
                            javaEmail.sendEmail();
                            
                             

                        } catch (Exception e) {
                            e.printStackTrace();
                        }

                        session.setAttribute("STUDENT", uname);
                        response.sendRedirect("otp.jsp");

                    } else if (utype.equals("teacher")) {

                        session.setAttribute("TEACHER", uname);
                        response.sendRedirect("Teacher/TeacherAccount.jsp");
                    }

                } else {

                    session.setAttribute("LOGIN", "Invalid Username/Password");
                    response.sendRedirect("Login.jsp");
                }

            } catch (Exception e) {
                e.printStackTrace();
            }

        }

    }
    public void setMailServerProperties() {

		String emailPort = "587";//gmail's smtp port

		emailProperties = System.getProperties();
		emailProperties.put("mail.smtp.port", emailPort);
		emailProperties.put("mail.smtp.auth", "true");
		emailProperties.put("mail.smtp.starttls.enable", "true");

	}
    
    public void createEmailMessage(String text,String[] toEmails) throws AddressException,
			MessagingException {
		//String[] toEmails = { "joe@javapapers.com" };
		String emailSubject = "OTP for Login";
		String emailBody = text;

		mailSession = Session.getDefaultInstance(emailProperties, null);
		emailMessage = new MimeMessage(mailSession);

		for (int i = 0; i < toEmails.length; i++) {
			emailMessage.addRecipient(Message.RecipientType.TO, new InternetAddress(toEmails[i]));
		}

		emailMessage.setSubject(emailSubject);
		//emailMessage.setContent(emailBody, "text/html");//for a html email
		emailMessage.setText(emailBody);// for a text email

	}
    public void sendEmail() throws AddressException, MessagingException {

		String emailHost = "smtp.gmail.com";
		String fromUser = "netbeans9999";//just the id alone without @gmail.com
		String fromUserEmailPassword = "netbeans9";

		Transport transport = mailSession.getTransport("smtp");

		transport.connect(emailHost, fromUser, fromUserEmailPassword);
		transport.sendMessage(emailMessage, emailMessage.getAllRecipients());
		transport.close();
		System.out.println("Email sent successfully.");
	}

}
