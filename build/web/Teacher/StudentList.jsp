<%--
    Document   : test
    Created on : Feb 15, 2011, 10:52:57 PM
    Author     : Owner
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
        <title>Student List</title>
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
                        <form action="../student" method="post">
                            <table width="100%" cellpadding="3" cellspacing="3" align="center">
                                <tr height="40">
                                    <td align="center" colspan="4">
                                        <h2>Students List</h2>
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
                                <tr>
                                    <td width="100%">
                                        <div style="width: 870px;height: 350px;overflow: auto;">
                                            <table width="100%">
                                                <tr class="listheading">
                                                    <td align="center">
                                                        &nbsp;Student&nbsp;ID&nbsp;
                                                    </td>
                                                    <td align="center">
                                                        &nbsp;Student&nbsp;Name&nbsp;
                                                    </td>
                                                    <td align="center">
                                                        &nbsp;Course&nbsp;
                                                    </td>
                                                    <td align="center">
                                                        &nbsp;Section&nbsp;
                                                    </td>
                                                    <td align="center">
                                                        &nbsp;Gender&nbsp;
                                                    </td>
                                                    <td align="center">
                                                        &nbsp;Date&nbsp;of&nbsp;Birth&nbsp;
                                                    </td>
                                                    <td align="center">
                                                        &nbsp;TelePhone&nbsp;
                                                    </td>
                                                    <td align="center">
                                                        &nbsp;Mobile&nbsp;
                                                    </td>
                                                    <td align="center">
                                                        &nbsp;Email
                                                    </td>
                                                    <td align="center">
                                                        &nbsp;Father&nbsp;
                                                    </td>
                                                    <td align="center">
                                                        &nbsp;Occupation&nbsp;
                                                    </td>
                                                    <td align="center">
                                                        Present&nbsp;Add&nbsp;
                                                    </td>
                                                    <td align="center">
                                                        &nbsp;Permanent&nbsp;Add&nbsp;
                                                    </td>
                                                    <td align="center">
                                                        &nbsp;State&nbsp;
                                                    </td>
                                                    <td align="center">
                                                        &nbsp;City&nbsp;
                                                    </td>
                                                </tr>

                                                <%

                                                            Connection con = null;
                                                            ResultSet rs = null;
                                                            Statement st = null;
                                                            String id = null;
                                                            String name = null;
                                                            String gender = null;
                                                            String dob = null;
                                                            String tno = null;
                                                            String clss, sec = null;
                                                            String mno = null;
                                                            String mail = null;
                                                            String father = null;
                                                            String ocup = null;
                                                            String cadd = null;
                                                            String padd = null;
                                                            String state = null;
                                                            String city = null;

                                                            try {
                                                                con = connection.getDBConnection.makeConn();
                                                                st = con.createStatement();
                                                                String sql = "select id,name,class,section,gender,dob,telephone,mobile,email,father,occupation,present,permanent,state,city from student";
                                                                rs = st.executeQuery(sql);
                                                                while (rs.next()) {
                                                                    id = rs.getString(1);
                                                                    name = rs.getString(2);
                                                                    clss = rs.getString(3);
                                                                    sec = rs.getString(4);
                                                                    gender = rs.getString(5);
                                                                    dob = rs.getString(6);
                                                                    tno = rs.getString(7);
                                                                    mno = rs.getString(8);
                                                                    mail = rs.getString(9);
                                                                    father = rs.getString(10);
                                                                    ocup = rs.getString(11);
                                                                    cadd = rs.getString(12);
                                                                    padd = rs.getString(13);
                                                                    state = rs.getString(14);
                                                                    city = rs.getString(15);

                                                %>
                                                <tr class="text-1">
                                                    <td align="center"><%=id%></td>
                                                    <td align="center"><%=name%></td>
                                                    <td align="center"><%=clss%></td>
                                                    <td align="center"><%=sec%></td>
                                                    <td align="center"><%=gender%></td>
                                                    <td align="center"><%=dob%></td>
                                                    <td align="center"><%=tno%></td>
                                                    <td align="center"><%=mno%></td>
                                                    <td align="center"><%=mail%></td>
                                                    <td align="center"><%=father%></td>
                                                    <td align="center"><%=ocup%></td>
                                                    <td align="center"><%=cadd%></td>
                                                    <td align="center"><%=padd%></td>
                                                    <td align="center"><%=state%></td>
                                                    <td align="center"><%=city%></td>
                                                </tr>


                                                <%
                                                                }
                                                                con.close();
                                                                st.close();


                                                            } catch (Exception e) {
                                                            }

                                                %>


                                            </table>
                                        </div>
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
