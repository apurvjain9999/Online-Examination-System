<%--
    Document   : TeacherAccount
    Created on : Feb 24, 2011, 1:44:56 PM
    Author     : Administrator
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="java.sql.*" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="../style/style-sheet.css" rel="stylesheet" type="text/css">
        <link href="../style/menu.css" rel="stylesheet" type="text/css">
        <title>My Account</title>
    </head>
    <%

                String user = (String) session.getAttribute("TEACHER");

                if (user != null) {
    %>
    <%

                        Connection con = null;
                        ResultSet rs = null;
                        Statement st = null;
                        String id = null;
                        String name = null;
                        String gender = null;
                        String dob = null;
                        String tno = null;
                        String mno = null;
                        String subject = null;
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
                            String sql = "select name,gender,dob,telephone,mobile,course,email,father,occupation,present,permanent,state,city from teacher where id='" + user + "'";
                            System.out.println("sql : " + sql);
                            rs = st.executeQuery(sql);
                            while (rs.next()) {

                                name = rs.getString(1);
                                gender = rs.getString(2);
                                dob = rs.getString(3);
                                tno = rs.getString(4);
                                // System.out.println("telephone" + tno);
                                mno = rs.getString(5);
                                subject = rs.getString(6);
                                mail = rs.getString(7);
                                father = rs.getString(8);
                                ocup = rs.getString(9);
                                cadd = rs.getString(10);
                                padd = rs.getString(11);
                                state = rs.getString(12);
                                city = rs.getString(13);

    %>
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
                        <form action="../teacherAccountUpdate" method="post">
                            <table width="100%" cellpadding="3" cellspacing="3" align="center">
                                <tr height="40">
                                    <td align="center" colspan="2">
                                        <h2>My  Account</h2>
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
                                    <td colspan="2">
                                        <fieldset width="100%" >
                                            <legend>Personal Information</legend>
                                            <table width="100%" cellpadding="5" cellspacing="5" align="center">
                                                <tr>
                                                    <td class="text-1" align="">
                                                        Teacher ID
                                                    </td>
                                                    <td>
                                                        <input type ="text" name="id" id="id" class="texttype"  readonly value="<%=user%>">
                                                    </td>
                                                    <td class="text-1" align="">
                                                        Teacher Name
                                                    </td>
                                                    <td>
                                                        <input type ="text" name="name" id="name" class="texttype" readonly value="<%=name%>">
                                                    </td>
                                                </tr>

                                                <tr>
                                                    <td class="text-1">
                                                        Gender
                                                    </td>
                                                    <td >
                                                        <select id="cmbgender" name="cmbgender" class="combotext1" >
                                                            <option value="na" selected > - - - -  Select - - - - - </option>
                                                            <option value="Male"> Male</option>
                                                            <option value="FeMale">Female</option>
                                                            <option value="<%=gender%>selected"><%=gender%></option>
                                                        </select>
                                                    </td>
                                                    <td class="text-1">
                                                        Date of Birth
                                                    </td>
                                                    <td>
                                                        <input type="text" name="txtdob" id="txtdob" class="texttype" readonly value="<%=dob%>">
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="text-1">
                                                        Telephone No.
                                                    </td>
                                                    <td>
                                                        <input type="text" pattern="[789][0-9]{9}" name="telephone" id="telephone" class="texttype" onkeyup="contact(this)" value="<%=tno%>">
                                                    </td>
                                                    <td class="text-1">
                                                        Mobile No.
                                                    </td>
                                                    <td>
                                                        <input type="text" pattern="[789][0-9]{9}" name="mobile" id="mobile" class="texttype" onkeyup="contact(this)"  value="<%=mno%>">
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="text-1">
                                                        Subject
                                                    </td>
                                                    <td>
                                                        <%
                                                                                        Connection con22 = null;
                                                                                        Statement st22 = null;
                                                                                        ResultSet rs22 = null;
                                                                                        try {
                                                                                            con22 = connection.getDBConnection.makeConn();
                                                                                            st22 = con22.createStatement();
                                                                                            String QString = "select sub_name from subject";
                                                                                            rs22 = st22.executeQuery(QString);


                                                        %>
                                                        <select name="course" id="course" class="text_input" style="width: 160px;">
                                                            <option value="na" selected> - - - - - Select - - - - -</option>
                                                            <%
                                                                                                                                                    while (rs22.next()) {
                                                                                                                                                        String sub_name = rs22.getString(1);


                                                            %>
                                                            <option value=<%=sub_name%>><%=sub_name%></option>
                                                            <%}%>
                                                            <option selected value=<%=subject%>><%=subject%></option>
                                                        </select>
                                                        <%

                                                                                            st22.close();
                                                                                            con22.close();
                                                                                        } catch (Exception e) {
                                                                                        }
                                                        %>
                                                    </td>

                                                    <td class="text-1">
                                                        Email ID
                                                    </td>
                                                    <td>
                                                        <input type="text" name="email" id="email" class="texttype" onblur="valid()" value="<%=mail%>">
                                                    </td>

                                                </tr>
                                                <tr>
                                                    <td class="text-1">
                                                        Father
                                                    </td>
                                                    <td>
                                                        <input type="text" name="father" id="father" class="texttype" readonly value="<%=father%>">
                                                    </td>
                                                    <td class="text-1">
                                                        Occupation
                                                    </td>
                                                    <td>
                                                        <input type="text" name="occupation" id="occupation" class="texttype" value="<%=ocup%>">
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="textarea">
                                                        Present Address
                                                    </td>
                                                    <td class="">
                                                        <textarea style="width: 155px; height: 50px;"  id="txtpre" name="txtpre" class="texttype"><%=cadd%></textarea>
                                                    </td>
                                                    <td class="textarea">
                                                        Permanent Address
                                                    </td>
                                                    <td>
                                                        <textarea style="width: 155px; height: 50px;"  id="txtper" name="txtper" class="texttype" readonly><%=padd%></textarea>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="text-1">
                                                        State
                                                    </td>
                                                    <td>
                                                        <select id="cmbstate" name="cmbstate" class="combotext1" value="<%=state%>">
                                                            <option value="na"selected> - - - - Select - - - - </option>
                                                            <option value="Andhra Pradesh">Andhra Pradesh </option>
                                                            <option value="Arunachal Pradesh">Arunachal Pradesh </option>
                                                            <option value="Assam">Assam </option>
                                                            <option value="Bihar">Bihar </option>
                                                            <option value="Chhattisgarh">Chhattisgarh </option>
                                                            <option value="Goa">Goa </option>
                                                            <option value="Gujarat">Gujarat </option>
                                                            <option value="Haryana">Haryana </option>
                                                            <option value="Himachal Pradesh">Himachal Pradesh </option>
                                                            <option value="Jammu and Kashmir">Jammu and Kashmir </option>
                                                            <option value="Jharkhand">Jharkhand </option>
                                                            <option value="Karnataka">Karnataka </option>
                                                            <option value="Madhya Pradesh">Madhya Pradesh </option>
                                                            <option value="Maharashtra">Maharashtra </option>
                                                            <option value="Manipur">Manipur </option>
                                                            <option value="Meghalaya">Meghalaya </option>
                                                            <option value="Mizoram">Mizoram </option>
                                                            <option value="Nagaland">Nagaland </option>
                                                            <option value="New Delhi">New Delhi </option>
                                                            <option value="Orissa">Orissa </option>
                                                            <option value="Punjab">Punjab </option>
                                                            <option value="Rajasthan">Rajasthan </option>
                                                            <option value="Sikkim ">Sikkim </option>
                                                            <option value="Tamil Nadu">Tamil Nadu </option>
                                                            <option value="Tripura">Tripura </option>
                                                            <option value="Uttar Pradesh">Uttar Pradesh </option>
                                                            <option value="Uttarakhand">Uttarakhand </option>
                                                            <option value="West Bengal">West Bengal </option>
                                                        </select>
                                                    </td>
                                                    <td class="text-1">
                                                        City
                                                    </td>
                                                    <td>
                                                        <input type="text" name="txtcity" id="txtcity" class="texttype" value="<%=city%>">
                                                    </td>
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
                                        </fieldset>
                                    </td>
                                </tr>

                                <tr align="center" height="40">
                                    <td colspan="4">
                                        <input type="submit" value="Update" id="submit">&nbsp;
                                        <input type="reset" value="Reset" id="Reset">
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
        <%
                    } else {
                        response.sendRedirect("../Login.jsp");
                    }
        %>
    </body>
</html>
