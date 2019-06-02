<%--
    Document   : Subject
    Created on : Feb 25, 2011, 5:17:48 PM
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
        <title>Subject</title>
        <%@page import="java.sql.*" %>
        <script language="javascript">
            var xmlHttpRequest;
            function validateUser(val)
            {


                var xmlHttpRequest=init();
                function init()
                {
                    if (window.XMLHttpRequest){
                        return new XMLHttpRequest();}
                    else if (window.ActiveXObject){
                        return new ActiveXObject("Microsoft.XMLHTTP");}
                }


                var d=new Date();
                var t=d.getTime();
                xmlHttpRequest.open("get","../validateID?sess="+escape(val)+"&timestamp="+t, true);

                xmlHttpRequest.onreadystatechange=processRequest;
                xmlHttpRequest.send(null);
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
                    var res=xmlMessage.getElementsByTagName("valid")[0].firstChild.nodeValue;
                    //alert (res);
                    if(res == "f"){
                        alert('This Studnet Id is not avilable. So insert it.');
                    }
                    if(res == "t")
                    {
                        alert('this Student Id is already exits please retry');
                    }
                }
            }
        </script>
    </head>
    <body>
        <div id="outerdiv">
            <div class="innerdiv">
                <!-- Start Header -->
                <div id="header">
                    <%@include file="AdminMenu.html" %>
                </div>
                <!-- End Footer -->

                <!-- Start Content -->
                <div id="content">
                    <div class="content">
                        <form method="get" action="EnrolmentVerify.jsp">
                            <table align="center" cellspacing="5" cellpadding="5">
                                <tr>
                                    <td class="login-text">
                                        Student Enrollment
                                    </td>
                                    <td>
                                        <input type="text" name="txtid" id="txtid" size="20" class="input-text">
                                    </td>
                                    <td class="login-text">
                                        <input type="submit" name="btnok" id="btnok" value="OK">
                                    </td>
                                </tr>
                                <%
                                                    String msg = null;
                                                    msg = (String) session.getAttribute("ADMIN");
                                                    if (msg == null) {
                                        %>
                                        <tr>
                                            <td style="font-family: verdana;color: red;font-size: 10px" align="center" colspan="2"><%=msg%></td>
                                        </tr>
                                        <%
                                                        session.removeAttribute("ADMIN");
                                                        session.setAttribute("LOGIN","login");
                                                        response.sendRedirect("../Login.jsp");
                                                    } else {
                                                        session.setAttribute("ADMIN", msg);
                                                    }
                                        %>
                                <tr>
                                    <td colspan="4">
                                        <table align="center" width="1000px" cellspacing="5" cellpadding="5">
                                            <%
                                                        if (request.getParameter("btnok") != null) {
                                                            Connection con = null;
                                                            ResultSet rs = null;
                                                            Statement st = null;
                                                            String id = null;
                                                            String name = null;
                                                            String total = null;
                                                            String grade = null;
                                                            String obtain = null;
                                                            String division = null;
                                                            id = request.getParameter("txtid");
                                                            //System.out.println("FJJJJJJJJJJJ" + id);
                                                            try {
                                                                con = connection.getDBConnection.makeConn();
                                                                st = con.createStatement();
                                                                String sql = "select name,class,section,gender,dob,telephone,mobile,email,father,occupation,present,permanent,state,city from student where id = '" + id + "' ";
                                                                rs = st.executeQuery(sql);
                                                                if (rs.next()) {
                                                                    name = rs.getString(1);
                                                                    total = rs.getString(2);
                                                                    obtain = rs.getString(3);
                                                                    grade = rs.getString(4);
                                                                    division = rs.getString(5);
                                            %>
                                            <tr>
                                                <td class="login-text">
                                                    <strong>Name</strong>
                                                </td>
                                                <td class="login-text">
                                                    <%=name%>
                                                </td>
                                                <td class="login-text">
                                                    Course
                                                </td>
                                                <td class="login-text">

                                                </td>
                                            </tr>
                                            <tr>
                                                <%
                                                                                                                } else {
                                                %>
                                            <tr>
                                                <td style="color: red;font-size: 12px;font-weight: bold;">Student ID Wrong !!Retry Again</td>
                                            </tr>
                                            <%                                                                                                        }
                                                                                                            con.close();
                                                                                                            st.close();
                                                                                                        } catch (Exception e) {
                                                                                                            e.printStackTrace();
                                                                                                        }
                                            %>
                                        </table>
                                    </td>
                                </tr>
                                <%} else {%>
                                <%}%>
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
