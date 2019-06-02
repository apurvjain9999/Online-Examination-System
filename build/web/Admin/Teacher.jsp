<%--
    Document   : test
    Created on : Feb 15, 2011, 10:52:57 PM
    Author     : Owner
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="../style/style-sheet.css" rel="stylesheet" type="text/css">
        <link href="../style/menu.css" rel="stylesheet" type="text/css">
        <title>New Teacher</title>
    </head>
    <script src="../js/scw.js" type="text/javascript"></script>
    <script type="text/javascript">
        function confirmPwd(){
            var a = document.getElementById('password').value;
            var b = document.getElementById('confirmpassword').value;
            if(a != b){
                alert('Please Enter the same password');
                return false;
            }

        }
    </script>
    <script type="text/javascript">
        function valid() {
            //alert('calling');
            var reg = /^([A-Za-z0-9_\-\.])+\@([A-Za-z0-9_\-\.])+\.([A-Za-z]{2,4})$/;
            // var address = document.forms[form_id].elements[txtemail_id].value;
            var address = document.getElementById('email').value;
            if(reg.test(address) == false) {
                alert('Invalid Email Address');
                return false;
            }
        }
    </script>

    <script type="text/javascript">
        function contact(i)
        {
            if(i.value.length>0)
            {
                i.value = i.value.replace(/[^\d]+/g, '');

            }
        }
        /*function CheckForAlphabets(elem)
        {
            var alphaExp = /^[a-z A-Z]+$/;
            if(elem.value.match(alphaExp)){
                return true;
            }else{
                alert("give alphabatic name ");
                return false;
            }
        }*/
        function mob()
        {
            var rl=document.getElementById("mobile").value;
            if(rl.toString().length<10)
            {
                alert("Contact No. should be of ten digits");
                return false;
            }

        }
    </script>
    <script type="text/javascript">
        function validate(){
            if(document.getElementById('password').value == "")
            {
                alert('Client password Field Cannot be Blank Left !!');
                return false;
            }
            if(document.getElementById('confirmpassword').value == "")
            {
                alert('Client conform password Field Cannot be Blank Left !!');
                return false;
            }
            if(document.getElementById('id').value == "")
            {
                alert('Id Field Cannot be Blank Left !!');
                return false;
            }
            if(document.getElementById('name').value == "")
            {
                alert('Name Field Cannot be Blank Left !!');
                return false;
            }

            if(document.getElementById('cmbgender').value == "")
            {
                alert('Gender Fielfd Cannot be Blank Left!!');
                return false;
            }
            if(document.getElementById('txtdob').value == "")
            {
                alert('Date of Birth Field Cannot be Blank Left!!');
                return false;
            }
            if(document.getElementById('telephone').value == "")
            {
                alert('Telephone Field Cannot be Blank Left !!');
                return false;
            }
            if(document.getElementById('mobile').value == "")
            {
                alert('Mobile Field Cannot be Blank Left !!');
                return false;
            }
            if(document.getElementById('course').value == "")
            {
                alert('Course Field Cannot be Blank Left !!');
                return false;
            }
            if(document.getElementById('email').value == "")
            {
                alert('Email Field Cannot be Blank Left !!');
                return false;
            }
            if(document.getElementById('father').value == "")
            {
                alert('Father Field Cannot be Blank Left !!');
                return false;
            }    if(document.getElementById('occupation').value == "")
            {
                alert('Telephone Field Cannot be Blank Left !!');
                return false;
            }    if(document.getElementById('txtpre').value == "")
            {
                alert('Prasent Address Field Cannot be Blank Left !!');
                return false;
            }
            if(document.getElementById('txtper').value == "")
            {
                alert('Permanent Address Field Cannot be Blank Left !!');
                return false;
            }
            if(document.getElementById('cmbstate').value == "")
            {
                alert('State Field Cannot be Blank Left !!');
                return false;
            }
            if(document.getElementById('txtcity').value == "")
            {
                alert('City Field Cannot be Blank Left !!');
                return false;
            }
        }
    </script>
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
                        <form action="../teacher" method="post">
                            <table width="100%" cellpadding="3" cellspacing="3" align="center">
                                <tr height="40">
                                    <td align="center" colspan="2">
                                        <h2>New Teacher</h2>
                                    </td>
                                </tr>
                                <%
                                                    String m = null;
                                                    m = (String) session.getAttribute("ADMIN");
                                                    if (m == null) {
                                        %>
                                        <tr>
                                            <td style="font-family: verdana;color: red;font-size: 10px" align="center" colspan="2"><%=m%></td>
                                        </tr>
                                        <%
                                                        session.removeAttribute("ADMIN");
                                                        session.setAttribute("LOGIN","login");
                                                        response.sendRedirect("../Login.jsp");
                                                    } else {
                                                        session.setAttribute("ADMIN", m);
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
                                        <fieldset>
                                            <legend>Login Information</legend>
                                            <table width="100%" cellpadding="5" cellspacing="5" align="center">
                                                <tr>
                                                    <td class="text-1" align="center">
                                                        Password
                                                    </td>
                                                    <td>
                                                        <input type ="password" name="password" id="password" class="texttype">
                                                    </td>

                                                    <td  class="text-1" colspan="" align="center">
                                                        Confirm Password
                                                    </td>
                                                    <td class="" colspan="">
                                                        <input type ="password" name="confirmpassword" id="confirmpassword" class="texttype" onblur="confirmPwd()">
                                                    </td>
                                                </tr>
                                            </table>
                                        </fieldset>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="4">
                                        <fieldset width="100%" >
                                            <legend>Personal Information</legend>
                                            <table width="100%" cellpadding="5" cellspacing="5" align="center">
                                                <tr>
                                                    <td class="text-1" align="">
                                                        Teacher ID
                                                    </td>
                                                    <%
                                                                String teac_id = connection.AutoID.globalGenId("T-", "teacher");
                                                    %>
                                                    <td>
                                                        <input type ="text" name="id" id="id" class="texttype" value="<%=teac_id%>" readonly>
                                                    </td>
                                                    <td class="text-1" align="">
                                                        Teacher Name
                                                    </td>
                                                    <td>
                                                        <input type ="text" name="name" id="name" class="texttype"> <!--onblur="CheckForAlphabets(this)">-->
                                                    </td>
                                                </tr>

                                                <tr>
                                                    <td class="text-1">
                                                        Gender
                                                    </td>
                                                    <td >
                                                        <select id="cmbgender" name="cmbgender" class="combotext1">
                                                            <option value="na"selected>---- select-----</option>
                                                            <option value="Male"> Male</option>
                                                            <option value="FeMale">Female</option>
                                                        </select>
                                                    </td>
                                                    <td class="text-1">
                                                        Date of Birth
                                                    </td>
                                                    <td>
                                                        <input type="text" name="txtdob" id="txtdob" class="texttype" readonly onclick="scwShow(this,event)">
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="text-1">
                                                        Telephone No.
                                                    </td>
                                                    <td>
                                                        <input type="text" name="telephone" id="telephone" class="texttype" onkeyup="contact(this)">
                                                    </td>
                                                    <td class="text-1">
                                                        Mobile No.
                                                    </td>
                                                    <td>
                                                        <input type="text" name="mobile" id="mobile" class="texttype" onkeyup="contact(this)">
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
                                                        <input type="text" name="email" id="email" class="texttype" onblur="valid()">
                                                    </td>

                                                </tr>
                                                <tr>
                                                    <td class="text-1">
                                                        Father
                                                    </td>
                                                    <td>
                                                        <input type="text" name="father" id="father" class="texttype">
                                                    </td>
                                                    <td class="text-1">
                                                        Occupation
                                                    </td>
                                                    <td>
                                                        <input type="text" name="occupation" id="occupation" class="texttype">
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="textarea">
                                                        Present Adderss
                                                    </td>
                                                    <td class="">
                                                        <textarea style="width: 155px; height: 50px;"  id="txtpre" name="txtpre" class="texttype"></textarea>
                                                    </td>
                                                    <td class="textarea">
                                                        Permanent Address
                                                    </td>
                                                    <td>
                                                        <textarea style="width: 155px; height: 50px;"  id="txtper" name="txtper" class="texttype"></textarea>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="text-1">
                                                        State
                                                    </td>
                                                    <td>
                                                        <select id="cmbstate" name="cmbstate" class="combotext1">
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
                                                        <input type="text" name="txtcity" id="txtcity" class="texttype">
                                                    </td>
                                                </tr>
                                            </table>
                                        </fieldset>
                                    </td>
                                </tr>

                                <tr align="center" height="40">
                                    <td colspan="4">
                                        <input type="submit" value="Submit" id="submit" onclick="return validate()">&nbsp;
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