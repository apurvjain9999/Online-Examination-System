<%-- 
    Document   : Result
    Created on : Apr 29, 2011, 8:24:28 PM
    Author     : softavate
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
        <title>Question List</title>
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
                                        <h2>Online Test Result</h2>
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
                                                        &nbsp;Total&nbsp;Marks&nbsp;
                                                    </td>
                                                    <td align="center">
                                                        &nbsp;Obtain Marks&nbsp;
                                                    </td>
                                                    <td align="center">
                                                        &nbsp;Division&nbsp;
                                                    </td>
                                                    <td align="center">
                                                        &nbsp;Date&nbsp;
                                                    </td>
                                                </tr>

                                                <%

                                                            Connection con = null;
                                                            ResultSet rs = null;
                                                            Statement st = null;



                                                            try {
                                                                con = connection.getDBConnection.makeConn();
                                                                st = con.createStatement();
                                                                String sql = "select s.id,s.name,o.obtain,o.total,o.division,o.date from student s join onlineresult o where s.id = o.id";
                                                                rs = st.executeQuery(sql);
                                                                while (rs.next()) {

                                                                    String stuid = rs.getString(1);
                                                                    String name = rs.getString(2);
                                                                    String obtain = rs.getString(3);
                                                                    String total = rs.getString(4);
                                                                    String division = rs.getString(5);
                                                                    String date = rs.getString(6);


                                                %>
                                                <tr class="text-1">

                                                    <td align="center"><%=stuid%></td>
                                                    <td align="center"><%=name%></td>
                                                    <td align="center"><%=total%></td>
                                                    <td align="center"><%=obtain%></td>
                                                    <td align="center"><%=division%></td>
                                                    <td align="center"><%=date%></td> 
                                                </tr>
                                                <%
                                                                }
                                                                con.close();
                                                                st.close();


                                                            } catch (Exception e) {
                                                                e.printStackTrace();
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
