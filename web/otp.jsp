<%--
    Document   : Login
    Created on : Feb 15, 2011, 11:25:12 AM
    Author     : Owner
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login </title>
        <link type="text/css" rel="stylesheet" href="style/style_bgimage.css">
        <link href="style/style-sheet.css" rel="stylesheet" type="text/css">
        <script type="text/javascript">
            function validate(){
                if(document.getElementById('cmbtype').value == "na"){
                    alert('Please Select User Type!!');
                    return false;
                }
                if(document.getElementById('name').value == ""){
                    alert('User Name Field Cannot be Blank Left!!');
                    return false;
                }
                if(document.getElementById('password').value == ""){
                    alert('Password Field Cannot be Blank Left!!');
                    return false;
                }
            }

        </script>
    </head>
    <body>
        <div id="outerdiv">
            <div class="innerdiv">
                <!-- Start Header -->
                <div id="header">
                    <%@include file="Header.html" %>
                </div>
                <!-- End Footer -->

                <!-- Start Content -->
                <div id="content">
                    <div class="content">

                        <table width="100%" cellpadding="" cellspacing="" align="center" height="250">
                            <tr>
                                <td align="center">
                                    <table width="300px" height="150px" cellpadding="" cellspacing="" align="center">
                                        <tr>
                                            <td align="center" class="heading" colspan="2">
                                                <strong>Login</strong>
                                            </td>
                                        </tr>
                                        <%
                                                    String msg = null;
                                                    msg = (String) session.getAttribute("LOGIN");
                                                    if (msg != null) {
                                        %>
                                        <tr>
                                            <td style="font-family: verdana;color: red;font-size: 10px" align="center" colspan="2"><%=msg%></td>
                                        </tr>
                                        <%
                                                        session.removeAttribute("LOGIN");
                                                    } else {
                                                        session.setAttribute("LOGIN", "");
                                                    }
                                        %>
                                        <tr>
                                            <td>
                                                <form method="post" action="otp">
                                                    <table width="100%" cellpadding="5" cellspacing="5" align="center">
                                                       
                                                        <tr>
                                                            <td class="text" >
                                                                OTP
                                                            </td>
                                                            <td>
                                                                <input type="text" name="otp" id="name"  class="texttype" maxlength="10" size="30">
                                                            </td>
                                                        </tr>
                                                       

                                                        <tr>
                                                            <td colspan="2" align="center">
                                                                <input type="submit" value="Login" id="submit" onclick="return validate();">
                                                                <input type="reset" value="Reset" id="Reset">
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </form>
                                            </td>
                                        </tr>

                                    </table>
                                </td>
                            </tr>
                        </table>

                    </div>

                </div>
                <!-- End Content -->
                <!-- Start Footer -->
                <div id="footer">
                    <%@include file="Footer.html" %>
                </div>
                <!-- End Footer -->
            </div>
        </div>
    </body>
</html>
