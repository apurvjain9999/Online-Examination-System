<%--
    Document   : StudentAccount
    Created on : Feb 24, 2011, 1:44:45 PM
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
        <title>New Student</title>
    </head>
    <%

                String user = (String) session.getAttribute("STUDENT");
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
                        String classs, sec = null;
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
                            String sql = "select name,class,section,gender,dob,telephone,mobile,email,father,occupation,present,permanent,state,city from student where id='" + user + "'";
                            rs = st.executeQuery(sql);
                            while (rs.next()) {

                                name = rs.getString(1);
                                classs = rs.getString(2);
                                sec = rs.getString(3);
                                gender = rs.getString(4);
                                dob = rs.getString(5);
                                tno = rs.getString(6);
                                mno = rs.getString(7);
                                mail = rs.getString(8);
                                father = rs.getString(9);
                                ocup = rs.getString(10);
                                cadd = rs.getString(11);
                                padd = rs.getString(12);
                                state = rs.getString(13);
                                city = rs.getString(14);

    %>
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
                        <form action="../studentAccountUpdate" method="post">
                            <table width="100%" cellpadding="3" cellspacing="3" align="center">
                                <tr height="40">
                                    <td align="center" colspan="2">
                                        <h2>My  Account</h2>
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
                                    <td colspan="4">
                                        <fieldset width="100%" >
                                            <legend>Personal Information</legend>
                                            <table width="100%" cellpadding="5" cellspacing="5" align="center">
                                                <tr>
                                                    <td class="text-1" align=""><span style="color: red;">*</span>
                                                        Student Name
                                                    </td>
                                                    <td>
                                                        <input type ="hidden" name="txtid" id="txtid" class="texttype" readonly value="<%=user%>">
                                                        <input type ="text" pattern="[a-zA-Z]+" " name="name" id="name" class="texttype" readonly value="<%=name%>">
                                                    </td>
                                                    <td class="text-1"><span style="color: red;">*</span>
                                                        Gender
                                                    </td>
                                                    <td >
                                                        <select id="cmbgender" name="cmbgender" class="combotext1" readonly value="<%=gender%>">
                                                            <option value="na"selected>---- select-----</option>
                                                            <option value="Male"> Male</option>
                                                            <option value="FeMale">Female</option>

                                                        </select>
                                                    </td>
                                                </tr>
                                                <tr>

                                                    <td class="text-1"><span style="color: red;">*</span>
                                                        Date of Birth
                                                    </td>
                                                    <td>
                                                        <input type="text" name="txtdob" id="txtdob" class="texttype" readonly value="<%=dob%>">
                                                    </td>
                                                    <td class="text-1">
                                                        Email ID
                                                    </td>
                                                    <td>
                                                        <input type="text" name="email" id="email" class="texttype" value="<%=mail%>">
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="text-1">
                                                        Telephone No.
                                                    </td>
                                                    <td>
                                                        <input type="text" pattern="[789][0-9]{9}" name="telephone" id="telephone" class="texttype" value="<%=tno%>">
                                                    </td>
                                                    <td class="text-1">
                                                        Mobile No.
                                                    </td>
                                                    <td>
                                                        <input type="text" pattern="[789][0-9]{9}" name="mobile" id="mobile" class="texttype" value="<%=mno%>">
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="text-1"><span style="color: red;">*</span>
                                                        Class
                                                    </td>
                                                    <td>
                                                        <input type="text" name="class" id="class" class="texttype" readonly value="<%=classs%>">
                                                    </td>

                                                    <td class="text-1"><span style="color: red;">*</span>
                                                        Section
                                                    </td>
                                                    <td>
                                                        <input type="text" name="section" id="section" class="texttype" readonly value="<%=sec%>">
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
                                                        <input type="text" name="occupation" id="occupation" class="texttype" value="<%= ocup%>">
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
                                                            <option value="na"selected>------ select -----</option>
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
                                                                    }

                                                %>
                                            </table>

                                        </fieldset>
                                    </td>
                                </tr>

                                <tr align="center">
                                    <td colspan="2">
                                        <input type="submit" value="Update" id="btnsubmit" name="btnsubmit">
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
