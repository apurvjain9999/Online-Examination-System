<%--
    Document   : ChnagePassword
    Created on : Feb 25, 2011, 5:08:46 PM
    Author     : Administrator
--%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="../style/style-sheet.css" rel="stylesheet" type="text/css">
        <link href="../style/menu.css" rel="stylesheet" type="text/css">
        <script type="text/javascript">

            function confirmPwd(){
                var pwd = document.getElementById('txtpwd').value;
                var cpwd = document.getElementById('txtcpwd').value;
                if(pwd != cpwd){
                    alert('Confirm Password Does Not Matched');
                    return false;
                }
            }
            function valid()
            {
                var old = document.getElementById('txtoldpwd').value;
                var ne = document.getElementById('txtnewpwd').value;
                var cp = document.getElementById('txtcpwd').value;
                
                if(old == "") {
                    alert("Old Password cannot be left blank!");
                    return false;
                
                }
                else if (ne == "") {
                    alert("New Password cannot be left blank!");
                    return false;
                }
                else if (cp == "") {
                    alert("Confirm New Password cannot be left blank!");
                    return false;
                }
                else {
                    return true;
                }
                    
            }
        </script>

<script language="javascript">
            var xmlHttpRequest;
            function changePwd()
            {
                //alert('called');
                var xmlHttpRequest=init();

                function init()
                {
                    if (window.XMLHttpRequest){
                        return new XMLHttpRequest();}
                    else if (window.ActiveXObject){
                        return new ActiveXObject("Microsoft.XMLHTTP");}
                }

                var uid=document.getElementById('txtoldpwd').value;
              // alert(uid);

                xmlHttpRequest.open("GET", "../passwordMessage?uid="+escape(uid),true);
                xmlHttpRequest.onreadystatechange=processRequest;
                xmlHttpRequest.send(null);
                // alert('calling===================2');

                function processRequest()
                {
                    if(xmlHttpRequest.readyState==4)
                    {
                        if(xmlHttpRequest.status==200)
                        {
                            processResponse();
                        }
                    }
                }

                function processResponse()
                {

                    var xmlMessage=xmlHttpRequest.responseXML;
                    var pwd=xmlMessage.getElementsByTagName("sname")[0].firstChild.nodeValue;
                    //alert(pwd);
                    if(pwd != uid)
                    {
                        alert("Old Password is Wrong !! Plase Retry");
                        return true;
                    }


                }
            }
        </script>
        <title>Change Password</title>
    </head>
    <body>
        <div id="outerdiv">
            <div class="innerdiv">
                <!-- Start Header -->
                <div id="header">
                    <%@include file="StudentMenu.html" %>
                </div>
                <!-- End Footer -->

                <!-- Start Content -->
                <div id="content">
                    <div class="content">
                        <form action="../changeStudentPassword" method="post" onsubmit="return valid()">
                            <table width="50%" cellpadding="3" cellspacing="3" align="center">
                                <tr>
                                    <td align="center" colspan="2">
                                        <h2>Change Password</h2>
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
                                                    String va = null;
                                                    va = (String) session.getAttribute("MSG");
                                                    if (va != null) {
                                        %>
                                        <tr>
                                            <td style="font-family: verdana;color: red;font-size: 10px" align="center" colspan="2"><%=va%></td>
                                        </tr>
                                        <%      
                                                    session.removeAttribute("MSG");
                                                    }
                                                      
                                        %>
                                <tr>
                                    <td class="text">Old Password</td>
                                    <td><input type="password" name="txtoldpwd" id="txtoldpwd" size="30" class="texttype" onblur="changePwd()"></td>
                                </tr>
                                <tr>
                                    <td class="text">New Password</td>
                                    <td><input type="password" name="txtnewpwd" id="txtnewpwd" size="30" class="texttype"></td>
                                </tr>
                                <tr>
                                    <td class="text">Confirm Password</td>
                                    <td><input type="password" name="txtcpwd" id="txtcpwd" size="30" class="texttype" onblur="return confirmPwd();"></td>
                                </tr>
                                <tr><td>&nbsp;</td></tr>
                                <tr>
                                    <td>&nbsp;</td>
                                    <td align="center">
                                        <input type="submit" name="btnsubmit" id="btnsubmit" value="Change Now" class="button">
                                        <input type="reset" name="btnreset" id="btnreset" value="Reset" class="button">
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


