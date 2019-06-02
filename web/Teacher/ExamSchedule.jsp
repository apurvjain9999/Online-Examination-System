<%--
    Document   : EnlishmentSubject
    Created on : Mar 2, 2011, 1:08:18 PM
    Author     : Administrator
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="../style/style-sheet.css" rel="stylesheet" type="text/css">
        <link href="../style/menu.css" rel="stylesheet" type="text/css">
        <script type="text/javascript" src="../js/scw.js"></script>
        <title>Exam Schedule</title>
        <script language="javascript">
            function ValidateDate()
            {
                var SDate = new Date();
                var EDate =  document.getElementById();

                var alertReason1 =  'Date Can not be less than current date'

                var startDate= new Date(EDate);

                if(startDate < SDate)
                {
                    alert(alertReason1);
                    document.getElementById(CtrlEDate).value = "";
                    return false;
                }
                else if(SDate == '')
                {
                    alert("Please enter Exam Date");
                    return false;
                }
                
            }
            function Valid()
            {
                var sub = document.getElementById('cmbsubject').value;
                var qu = document.getElementById('txtLimit').value;
                var date = document.getElementById('txtdate').value;
                if (sub == "na") {
                    alert("Subject cannot be left blank");
                    return false;
                }
                else if (qu == "") {
                    alert("Question Limit cannot be left blank");
                    return false;
                }
                else if (date == "") {
                    alert("Date cannot be left blank");
                    return false;
                }
                else {
                    return true;
                }
                    
                  
            }
        </script>
    </head>
    <body>
        <div id="outerdiv">
            <div class="innerdiv">
                <!-- Start Header -->
                <div id="header">
                    <%@include file="TeacherMenu.html" %>
                </div>
                <!-- End Footer -->

                <!-- Start Content -->
                <div id="content">
                    <div class="content">
                        <form action="../examSchedule" method="post" onsubmit="return Valid()">
                            <table cellpadding="5" cellspacing="5" align="center">
                                <tr>
                                    <td align="center" colspan="4">
                                        <h2>Exam Schedule</h2>
                                    </td>
                                </tr>
                                <%
                                                    String msg = null;
                                                    msg = (String) session.getAttribute("TEACHER");
                                                    if (msg == null) {
                                        %>
                                        <tr>
                                            <td style="font-family: verdana;color: red;font-size: 10px" align="center" colspan="2"><%=msg%></td>
                                        </tr>
                                        <%
                                                        session.removeAttribute("TEACHER");
                                                        session.setAttribute("LOGIN","login");
                                                        response.sendRedirect("../Login.jsp");
                                                    } else {
                                                        session.setAttribute("TEACHER", msg);
                                                    }
                                        %>
                                        <%
                                                    String va = null;
                                                    va = (String) session.getAttribute("MSG");
                                                    if (va != null) {
                                        %>
                                        <tr>
                                            <td style="font-family: verdana;color: red;font-size: 10px" align="center" colspan="2"><%=va%></td>
                                        </tr>
                                        <%          session.removeAttribute("MSG");
                                                    }
                                                      
                                        %>
                                <tr>
                                    <td class="text">Subject</td>
                                    <td>

                                        <select name="cmbsubject" id="cmbsubject" class="text_input" style="width: 200px;">
                                            <option value="na" > - - - - - Select - - - - -</option>
                                            <option value="Java" >Java</option>
                                            <option value="C" >C</option>
                                            <option value="Data Structure">Data Structure</option>
                                            <option value="DBMS" >DBMS</option>
                                            <option value="O.S" >O.S</option>
                                        </select>

                                    </td>
                                </tr>
                                <tr>
                                    <td class="text-1">
                                        Ques Limitation
                                    </td>
                                    <td>
                                        <input type="number" name="txtLimit" id="txtLimit" class="text_input" size="35" >
                                    </td>
                                </tr>
                                <tr>
                                    <td class="text-1">Date</td>
                                    <td>
                                        <input type="text" name="txtdate" id="txtdate" class="text_input" size="35"  readonly onclick="showCal(this, event)">
                                    </td>
                                </tr>
                                <tr>
                                    <td class="text-1">
                                        Start Time
                                    </td>
                                    <td>
                                        <input type="text" name="combotext1" id="combotext1" class="text_input" size="35"  value="08:00 AM" onclick="ValidateDate()">
                                    </td>
                                </tr>
                                <tr>
                                    <td class="text-1">
                                        End Time
                                    </td>
                                    <td>
                                        <input type="text" name="combotext2" id="combotext2" class="text_input" size="35"  value="08:00 AM">
                                    </td>
                                </tr>
                                <tr><td>&nbsp;</td></tr>
                                <tr>
                                    <td align="center" colspan="2">
                                        <input type="submit" value="Submit" name="btnsubmit" id="btnsubmit" class="button" >
                                        <input type="reset" value="Reset" name="btnreset" id="btnreset" class="button">
                                    </td>
                                </tr>
                            </table>
                        </form>
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

