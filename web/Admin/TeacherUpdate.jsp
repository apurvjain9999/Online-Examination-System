<%--
    Document   : test
    Created on : Feb 15, 2011, 10:52:57 PM
    Author     : Owner
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
        <script type="text/javascript">
            function validate(){
                if(document.getElementById('password').value == "");
                {
                    alert('Password Field Cannot Be Blank Left!!');
                    return false;
                }
                if(document.getElementById('txtid').value == "");
                {
                    alert('Student ID Field  Cannot Be Blank Left!!');
                    return false;
                }
                if(document.getElementById('name').value == "");
                {
                    alert('Student Name Field  Cannot Be Blank Left!!');
                    return false;
                }
            }


            function confirPwd(){
                var pwd = document.getElementById('password').value;;
                var cpwd = document.getElementById('confirmpassword').value;
                if(pwd != cpwd){
                    alert('Confirm Password Does Not Matched!! Re-Type');
                    return false;
                }
            }
        </script>
        <%
                    Connection con = null;
                    ResultSet rs = null;
                    Statement st = null;
                    String id = request.getParameter("id");
                    System.out.println("id is " + id);
                    try {
                        con = connection.getDBConnection.makeConn();
                        st = con.createStatement();
                        String Sql = "select name,gender,dob,telephone,mobile,course,email,father,occupation,present,permanent,state,city from teacher where id='" + id + "'";
                        System.out.println("query string : " + Sql);
                        rs = st.executeQuery(Sql);
                        if (rs.next()) {

                            String name = rs.getString(1);
                            String gender = rs.getString(2);
                            String dob = rs.getString(3);
                            String telephone = rs.getString(4);
                            String mobile = rs.getString(5);
                            String course = rs.getString(6);
                            String email = rs.getString(7);
                            String father = rs.getString(8);
                            String occupation = rs.getString(9);
                            String present = rs.getString(10);
                            String permanent = rs.getString(11);
                            String state = rs.getString(12);
                            String city = rs.getString(13);

        %>
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
                        <form action="../teacherUpdate" method="post">
                            <table width="100%" cellpadding="3" cellspacing="3" align="center">
                                <tr height="40">
                                    <td align="center" colspan="2">
                                        <h2> Teacher Updation</h2>
                                    </td>
                                </tr>
                                <%                                                        String msg = null;
                                                            msg = (String) session.getAttribute("MSG");
                                                            if (msg != null) {
                                %>
                                <tr>
                                    <td style="font-family: verdana;color: red;font-size: 10px" align="center" colspan="2"><%=msg%></td>
                                </tr>
                                <%
                                                                session.removeAttribute("MSG");
                                                            } else {
                                                                session.setAttribute("MSG", "");
                                                            }
                                %>


                                <tr>
                                    <td colspan="4">
                                        <fieldset width="100%" >
                                            <legend>Personal Information</legend>

                                            <table width="100%" cellpadding="5" cellspacing="5" align="center">
                                                <tr>
                                                    <td class="text-1" align="">
                                                        Teacher ID
                                                    </td>
                                                    <td>
                                                        <input type ="text" name="txtid" id="txtid" class="texttype" value="<%=id%>">
                                                    </td>
                                                    <td class="text-1" align="">
                                                        Teacher Name
                                                    </td>
                                                    <td>
                                                        <input type ="text" name="name" id="name" class="texttype" value="<%=name%>">
                                                    </td>
                                                </tr>

                                                <tr>
                                                    <td class="text-1">
                                                        Gender
                                                    </td>
                                                    <td >
                                                        <select id="cmbgender" name="cmbgender" class="combotext1">
                                                            <option value="na">---- select-----</option>
                                                            <option value="Male"> Male</option>
                                                            <option value="FeMale">Female</option>
                                                            <option value="<%=gender%>" selected><%=gender%></option>
                                                        </select>
                                                    </td>
                                                    <td class="text-1">
                                                        Date of Birth
                                                    </td>
                                                    <td>
                                                        <input type="text" name="txtdob" id="txtdob" class="texttype" value="<%=dob%>">
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="text-1">
                                                        Telephone No.
                                                    </td>
                                                    <td>
                                                        <input type="text" name="telephone" id="telephone" class="texttype" value="<%=telephone%>">
                                                    </td>
                                                    <td class="text-1">
                                                        Mobile No.
                                                    </td>
                                                    <td>
                                                        <input type="text" name="mobile" id="mobile" class="texttype" value="<%=mobile%>">
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
                                                        <input type="text" name="email" id="email" class="texttype" value="<%=email%>">
                                                    </td>

                                                </tr>
                                                <tr>
                                                    <td class="text-1">
                                                        Father
                                                    </td>
                                                    <td>
                                                        <input type="text" name="father" id="father" class="texttype" value="<%=father%>">
                                                    </td>
                                                    <td class="text-1">
                                                        Occupation
                                                    </td>
                                                    <td>
                                                        <input type="text" name="occupation" id="occupation" class="texttype" value="<%=occupation%>">
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="textarea">
                                                        Present Address
                                                    </td>
                                                    <td class="">
                                                        <textarea style="width: 155px; height: 50px;"  id="txtpre" name="txtpre" class="texttype"><%=present%></textarea>
                                                    </td>
                                                    <td class="textarea">
                                                        Permanent Address
                                                    </td>
                                                    <td>
                                                        <textarea style="width: 155px; height: 50px;"  id="txtper" name="txtper" class="texttype"><%=permanent%></textarea>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="text-1">
                                                        State
                                                    </td>
                                                    <td>
                                                        <select id="cmbstate" name="cmbstate" class="combotext1" value="<%=state%>">
                                                            <option value="na"selected> - - - - - - Select - - - - - </option>
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
                                                <%                                }
                                                                st.close();
                                                                con.close();
                                                            } catch (Exception e) {
                                                            }
                                                %>
                                            </table>

                                        </fieldset>
                                    </td>
                                </tr>

                                <tr align="center" height="40">
                                    <td colspan="4">
                                        <input type="submit" value="Update" id="submit">
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
    </body>
</html>
