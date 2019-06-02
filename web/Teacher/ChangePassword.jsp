<%--
    Document   : ChangePassword
    Created on : Feb 25, 2011, 4:56:10 PM
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
        <title>My Account</title>
    </head>
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

            xmlHttpRequest.open("GET", "../passwordMessage1?uid="+escape(uid),true);
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
                    alert("Old Password is Wrong !! Please Retry");
                    return true;
                }


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
                        <form action="../changeTeacherPassword" method="post" onsubmit="return valid()">
                            <table width="50%" cellpadding="3" cellspacing="3" align="center">
                                <tr>
                                    <td align="center" colspan="2">
                                        <h2>Change Password</h2>
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
                                                    va = (String) session.getAttribute("msg");
                                                    if (va != null) {
                                        %>
                                        <tr>
                                            <td style="font-family: verdana;color: red;font-size: 10px" align="center" colspan="2"><%=va%></td>
                                        </tr>
                                        <%
                                                    session.removeAttribute("msg");
                                                    }
                                                      
                                        %>
                                <tr>
                                    <td class="text-1">Old Password</td>
                                    <td><input type="password" name="txtoldpwd" id="txtoldpwd" size="30" class="texttype" onblur="changePwd()"></td>
                                </tr>
                                <tr>
                                    <td class="text-1">New Password</td>
                                    <td><input type="password" name="txtnewpwd" id="txtnewpwd" size="30" class="texttype"></td>
                                </tr>
                                <tr>
                                    <td class="text-1">Confirm Password</td>
                                    <td><input type="password" name="txtcpwd" id="txtcpwd" size="30" class="texttype"></td>
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

