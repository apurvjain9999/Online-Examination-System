<%-- 
    Document   : OnlineExam
    Created on : Feb 28, 2011, 2:08:05 PM
    Author     : Administrator
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="../style/style-sheet.css" rel="stylesheet" type="text/css">
        <link href="../style/menu.css" rel="stylesheet" type="text/css">
        <title>Online Exam</title>
    </head>
    <script type="text/javascript">
        function valid()
            {
                var sub = document.getElementById('cmbsubject').value;
                var qu = document.getElementById('txtquestion').value;
                var ans = document.getElementById('txtanswer').value;
                var op1 = document.getElementById('txtoption1').value;
                var op2 = document.getElementById('txtoption2').value;
                var op3 = document.getElementById('txtoption3').value;
                var op4 = document.getElementById('txtoption4').value;
                if(sub == "na") {
                    alert("Subject cannot be left blank!");
                    return false;
                
                }
                else if (qu == "") {
                    alert("Question cannot be left blank!");
                    return false;
                }
                else if (ans == "") {
                    alert("Answer cannot be left blank!");
                    return false;
                }
                else if (op1 == "") {
                    alert("Option1 cannot be left blank!");
                    return false;
                }
                else if (op2 == "") {
                    alert("Option2 cannot be left blank!");
                    return false;
                }
                else if (op3 == "") {
                    alert("Option3 cannot be left blank!");
                    return false;
                }
                else if (op4 == "") {
                    alert("Option4 cannot be left blank!");
                    return false;
                }
                else {
                    var i;
                    var count = 0;
                    if(op1 == ans) {
                        count = count + 1;
                    }
                    if(op2 == ans) {
                        count = count + 1;
                    }
                    if(op3 == ans) {
                        count = count + 1;
                    }
                    if(op4 == ans) {
                        count = count + 1;
                    }
                    if(count == 0) {
                        alert("No option matches answer!");
                        return false;
                    }
                    else if(count>1) {
                        alert("Multiple options match the answer");
                        return false;
                    }
                    else {
                        return true;
                    }
                       
                        
                }
                    
            }
    </script>
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
                        <form action="../examQuestion" method="post" onsubmit="return valid()">
                            <table  cellpadding="3" cellspacing="3" align="center">
                                <tr>
                                    <td align="center" colspan="4">
                                        <h2>Online Exams</h2>
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
                                    <td class="text" rowspan="2">
                                        Question
                                    </td>
                                    <td rowspan="2">
                                        <textarea style="width: 200px;height: 50px;" id="txtquestion" name="txtquestion" class="text_input"></textarea>
                                    </td>
                                    <td class="text">
                                        Answer
                                    </td>
                                    <td><input type="text" id="txtanswer" name="txtanswer" class="text_input" size="35"></td>
                                </tr>

                                <tr>
                                    <td class="text">
                                        Option 1
                                    </td>
                                    <td><input type="text" id="txtoption1" name="txtoption1" class="text_input" size="35"></td>

                                </tr>
                                <tr>
                                    <td class="text">
                                        Option 2
                                    </td>
                                    <td><input type="text" id="txtoption2" name="txtoption2" class="text_input" size="35"></td>
                                    <td class="text">
                                        Option 3
                                    </td>
                                    <td><input type="text" id="txtoption3" name="txtoption3" class="text_input" size="35"></td>
                                </tr>
                                <tr>
                                    <td class="text">
                                        Option 4
                                    </td>
                                    <td><input type="text" id="txtoption4" name="txtoption4" class="text_input" size="35"></td>
                                </tr>
                                <tr><td>&nbsp;</td></tr>
                                <tr>
                                    <td colspan="4" align="center">
                                        <input type="submit" id="btnsubmit" name="btnsubmit" value="Submit">
                                        <input type="reset" id="btnreset" name="btnreset" value="Reset">
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


