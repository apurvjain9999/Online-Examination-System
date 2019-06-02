<%-- 
    Document   : OnlineTest
    Created on : Feb 25, 2011, 12:34:21 PM
    Author     : Administrator
--%>

<%@page import="sun.print.PSPrinterJob"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="java.lang.Math.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<%
            String subject = null;
            String user = (String) session.getAttribute("STUDENT");
            int i = 0;
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="../style/style-sheet.css" rel="stylesheet" type="text/css">
        <link href="../style/menu.css" rel="stylesheet" type="text/css">
        <title>Online Test</title>
        <script type="text/javascript">
            function validate(){
                if(document.getElementById("cmbsubject").value=="na"){
                    alert("Select subject name !");                    
                    return false;
                }
                // document.formc.btnok.disabled = true;
            }
        </script>    

        <script type="text/javascript">
            var c=0;
            var t;
            var timer_is_on=0;

            function timedCount()
            {
                var endtime = document.getElementById('hidExTime').value;               
              
                document.getElementById('txt').value=c;
                c=c+1;
                t=setTimeout("timedCount()",1000);

                var desctime = endtime - t;
                document.getElementById('endtxt').value=desctime;
                if(desctime == 120){

                    alert('Your Exam Time Remaing 2 Minute Plz Submit Exam question');

                }else if (desctime == 60){

                    alert('Your Exam Time Remaing 1 Minute !! Last Warning');
                }
                else if (desctime == 0){
                    alert('Your Exam Time Expired');
                    document.getElementById("btnsubmit").disabled = true;
                }
                else if (desctime == -10){
                    window.location.href = '../Login.jsp';
                }
            }

            function doTimer()
            {
                if (!timer_is_on)
                {
                    timer_is_on=1;
                    timedCount();
                }
            }
        </script>
    </head>
    <body onload="doTimer()">
        <div id="outerdiv" >
            <div class="innerdiv">
                <!-- Start Header -->
                <div id="header">
                    <%@include file="StudentMenu.html" %>
                </div>
                <!-- End Footer -->
                <!-- Start Content -->
                <div id="content">
                    <div class="content">
                        <form action="OnlineTest.jsp" method="get" name="formc">
                            <table cellpadding="3" cellspacing="3" align="center" height="220px">
                                <tr>
                                    <td align="center" colspan="2">
                                        <h2>Online Exam</h2>
                                    </td>
                                </tr>
                                <%
                                                    String msg = null;
                                                    msg = (String) session.getAttribute("STUDENT");
                                                    if (msg == null) {
                                        %>
                                        <tr>
                                            <td style="font-family: verdana;color: red;font-size: 10px" align="center" colspan="2"><%=msg%></td>
                                        </tr>
                                        <%
                                                        session.removeAttribute("STUDENT");
                                                        session.setAttribute("LOGIN","login");
                                                        response.sendRedirect("../Login.jsp");
                                                    } else {
                                                        session.setAttribute("STUDENT", msg);
                                                    }
                                        %>
                                         <%
                                            String marks = null;
                                            marks = (String) session.getAttribute("Marks");
                                            if (marks != null) {
                                %>
                                <tr>
                                    <td style="font-family: verdana;color: red;font-size: 10px" align="center" colspan="2"><%=marks%></td>
                                </tr>
                                <%
                                                session.removeAttribute("Marks");
                                            } 
                                %>
                                <tr>
                                    <td class="login-text">
                                        Exam Start&nbsp;&nbsp;&nbsp;
                                        <input type="text" id="txt" size="10"/>
                                    </td>
                                    <td>
                                        Total Remaing Second&nbsp;&nbsp;&nbsp;
                                        <input type="text" id="endtxt" size="10" />
                                    </td>
                                </tr>
   
                                <tr>
                                    <td class="text" align="right">Subject</td>
                                    <td align="left">
                                        <select name="cmbsubject" id="cmbsubject" class="text_input" style="width: 200px;">
                                            <option value="na" selected> - - - - - Select - - - - -</option>
                                            <option value="Java" >Java</option>
                                            <option value="C" >C</option>
                                            <option value="Data Structure">Data Structure</option>
                                            <option value="DBMS" >DBMS</option>
                                            <option value="O.S" >O.S</option>
                                        </select>
                                        <input type="submit" value="OK" name="btnok" id="btnok" class="button" onclick="return validate()">
                                    </td>
                                </tr>
                            </table>
                        </form>
                        <%
                                    if (request.getParameter("btnok") != null) {
                        %>
                        <div>                            
                            <form action="../onlineTest" method="post" name="formex" >                               

                                <table align="center">
                                    <%
                                                                            //System.out.println("jfdskafjdksahfkj lsahfjklhsafjkl");
                                                                            subject = request.getParameter("cmbsubject");
                                                                            Connection con33 = null;
                                                                            Statement st33 = null;
                                                                            ResultSet rs33 = null;
                                                                            String extime = null;
                                                                            try {
                                                                                con33 = connection.getDBConnection.makeConn();
                                                                                st33 = con33.createStatement();
                                                                                String QString = "select QuesLimit,time,time_format(curtime(),'%h:%i %p') from exam_schedule where date = date_format(curdate(),'%d-%m-%Y') and subject = '" + subject + "'";
                                                                                //System.out.println("query : " + QString);
                                                                                rs33 = st33.executeQuery(QString);
                                                                                if (rs33.next()) {

                                                                                    //question limit
                                                                                    int quesLimit = rs33.getInt(1);

                                                                                    //exam time
                                                                                    String time = rs33.getString(2);

                                                                                    //current time
                                                                                    String cur_time = rs33.getString(3);

                                                                                    //exam time and current time
                                                                                    //break exam time
                                                                                    String ctime[] = time.split("to");
                                                                                    String ct1[] = ctime[0].split(":");
                                                                                    int s_time = Integer.parseInt(ct1[0]);//start time

                                                                                    String ct2[] = ctime[1].split(":");
                                                                                    int l_time = Integer.parseInt(ct2[0]);//end time
                                                                                    //System.out.println("stime : " + s_time);



                                                                                    //break current time
                                                                                    String ct[] = cur_time.split(":");
                                                                                    int c_time = Integer.parseInt(ct[0]);


                                                                                    //count total second for exam ending time
                                                                                    String endttsec[] = ct2[1].split(" ");

                                                                                    //count total second for current time
                                                                                    String curttsec[] = ct[1].split(" ");


                                                                                    int hourdiff = l_time - c_time;
                                                                                    System.out.println("hourdiff : " + hourdiff);

                                                                                    int tothorsc = (hourdiff * 3600) + (Integer.parseInt(endttsec[0]) * 60);

                                                                                    System.out.println("tothorsc : " + tothorsc);


                                                                                    int hourtosec = tothorsc - (Integer.parseInt(curttsec[0]) * 60);


                                                                                    System.out.println("hourtosec : " + hourtosec);

                                                                                    int flag = 0;
                                                                                    Connection con4 = connection.getDBConnection.makeConn();
                                                                                    Statement st4 = con4.createStatement();
                                                                                    String QS = "select ques_id,question,option1,option2,option3,option4,answer from question_master where sub_id = 'Java' and status = 0 limit " + quesLimit + "";
                                                                                    ResultSet rs4 = st4.executeQuery(QS);
                                                                                    if (rs4.next() == false) {
                                                                                        flag = 1;
                                                                                %>
                                                                                       <!-- <tr>
                                                                                                <td class="bold_matter" colspan="2" align="center">
                                                                                                    123
                                                                                                </td>
                                                                                            </tr> -->
                                                                                <%    }
                                                                                            
                                                                                    //System.out.println("Exam time ::::::::::::::::::" + extime);
                                                                                    if ((s_time <= c_time || s_time >= l_time) && flag == 0 ) {
                                                                                        //onload = "setTimeout('delayer()', 20000)";
%>
                                    <tr>
                                        <td class="bold_matter" colspan="2" align="center">
                                            All Question are equal Marks.
                                        </td>
                                    </tr>
                                    <%
                                                                                                                            //System.out.println("successfully");
                                                                                                                            try {
                                                                                                                                Connection con44 = connection.getDBConnection.makeConn();
                                                                                                                                Statement st44 = con44.createStatement();
                                                                                                                                String QueryString = "select ques_id,question,option1,option2,option3,option4,answer from question_master where sub_id = 'Java' and status = 0 limit " + quesLimit + "";
                                                                                                                                //System.out.println("QueryString : " + QueryString);
                                                                                                                                ResultSet rs44 = st44.executeQuery(QueryString);
                                                                                                                                while (rs44.next()) {
                                                                                                                                    String ques_id = rs44.getString(1);
                                                                                                                                    if (!ques_id.equals("")) {
                                                                                                                                        try {
                                                                                                                                            Connection cont = connection.getDBConnection.makeConn();
                                                                                                                                            String query = "Update question_master set  status =1 where ques_id ='" + ques_id + "'";
                                                                                                                                            PreparedStatement pstt = cont.prepareStatement(query);
                                                                                                                                            pstt.executeUpdate();
                                                                                                                                        } catch (Exception e) {
                                                                                                                                            e.printStackTrace();
                                                                                                                                        }
                                                                                                                                    }
                                                                                                                                    String ques = rs44.getString(2);
                                                                                                                                    String option1 = rs44.getString(3);
                                                                                                                                    String option2 = rs44.getString(4);
                                                                                                                                    String option3 = rs44.getString(5);
                                                                                                                                    String option4 = rs44.getString(6);
                                                                                                                                    String ans = rs44.getString(7);
                                                                                                                                    i++;
                                                                                                                                    String quesid = "quesid" + i;
                                                                                                                                    String rdop1 = "rdoop1" + i;

                                                                                                                                    String rdop2 = "rdoop2" + i;
                                                                                                                                    // String rdop3 = "rdoop3" + i;
                                                                                                                                    //String rdop4 = "rdoop4" + i;
                                                                                                                                    //String rdoid = "rdoid" + i;
                                    %>
                                    <tr>
                                        <td colspan="2">
                                            <table cellpadding="3" cellspacing="5">
                                                <tr class="login-text">
                                                    <td colspan="2"><%=i%>.&nbsp;&nbsp;<%=ques%>?</td>
                                                </tr>
                                                <tr class="text_input">
                                                    <td>
                                                        <input type="hidden" name="hidExTime" id="hidExTime" value="<%=hourtosec%>">
                                                        <input type="hidden" name="hidsubject" id="hidsubject" value="<%=subject%>">
                                                        <input type="hidden" name="<%=quesid%>" id="<%=quesid%>" value="<%=ques_id%>">
                                                        <input type="radio" name="<%=rdop1%>" id="<%=rdop1%>" value="<%=option1%>">&nbsp;&nbsp;<%=option1%>
                                                    </td>
                                                    <td><input type="radio" name="<%=rdop1%>" id="<%=rdop1%>" value="<%=option2%>">&nbsp;&nbsp;<%=option2%></td>
                                                </tr>
                                                <tr class="text_input">
                                                    <td><input type="radio" name="<%=rdop1%>" id="<%=rdop1%>" value="<%=option3%>">&nbsp;&nbsp;<%=option3%></td>
                                                    <td><input type="radio" name="<%=rdop1%>" id="<%=rdop1%>" value="<%=option4%>">&nbsp;&nbsp;<%=option4%></td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <%}%>
                                    <%
                                                                                                                            } catch (Exception e) {
                                                                                                                                e.printStackTrace();
                                                                                                                            }
                                                                                                                     
                                            
                                                                                                                        }
                                                                                                                        else {
                                    %>
                                    <tr>
                                        <td style="font-family: verdana;color: red;font-size: 14px;font-weight: bold;" align="center" colspan="2">Please See Examination Schedule with time</td>
                                    </tr>
                                    <%} 
                                                                                                                    } else {
                                    %>
                                    <tr>
                                        <td style="font-family: verdana;color: red;font-size: 14px;font-weight: bold;" align="center" colspan="2">Please See Examination Schedule with time</td>
                                    </tr>
                                    <%}
                                                                            } catch (Exception e) {
                                                                                e.printStackTrace();
                                                                            }
                                    %>
                                    <tr>
                                        <td colspan="2" align="center">
                                            <input type="hidden" name="count" id="count" value="<%=i%>">
                                            <input type="submit" name="btnsubmit" id="btnsubmit" value="Submit"/>
                                        <td>
                                    </tr>
                                </table>
                            </form>
                            <%}%>
                        </div>
                    </div>
                </div>
                <!-- End Content -->
                <!-- Start Footer -->
                <div id="footer">
                    <%@include file="../Footer.html" %>
                </div>
                <!-- End Footer -->
            </div>
        </div>

    </body>
</html>

