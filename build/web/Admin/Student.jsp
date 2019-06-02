<%--
    Document   : test
    Created on : Feb 15, 2011, 10:52:57 PM
    Author     : Owner
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="../style/style-sheet.css" rel="stylesheet" type="text/css">
        <link href="../style/menu.css" rel="stylesheet" type="text/css">
        <script type="text/javascript" src="../js/scw.js"></script>
        <title>New Student</title>
        <script type="text/javascript">
            //function validateMsg()
            //{
                //if(document.getElementById('txtpassword').value == "");
                //{
                    //alert('Password Field Cannot Be Blank Left!!');
                    //return false;
                //}
                //if(document.getElementById('txtid').value == "");
                //{
                    //alert('Student ID Field  Cannot Be Blank Left!!');
                    //return false;
                //}
                //if(document.getElementById('name').value == "");
                //{
                    //alert('Student Name Field  Cannot Be Blank Left!!');
                    //return false;
                //}
            //}

            function reqrd() {
                var pwd = document.getElementById('txtpassword').value;
                var id = document.getElementById('txtid').value;
                var name = document.getElementById('name').value;
                if(pwd == ""){
                    alert('Password Field Cannot Be Blank Left!!');
                    return false;
                }
                if(id == ""){
                    alert('Student ID Field  Cannot Be Blank Left!!');
                    return false;
                }
                if(name == ""){
                    alert('Student Name Field  Cannot Be Blank Left!!');
                    return false;
                }
                return true;
        
            }
            function confirPwd(){
                var pwd = document.getElementById('txtpassword').value;
                var cpwd = document.getElementById('confirmpassword').value;
                if(pwd != cpwd){
                    alert('Confirm Password Does Not Matched!! Re-Type');
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
        function CheckForAlphabets(elem)
        {
            var alphaExp = /^[a-z A-Z]+$/;
            if(elem.value.match(alphaExp)){
                return true;
            }else{
                alert("give alphabatic name ");
                return false;
            }
        }
        function mob()
        {
            var rl=document.getElementById("telephone").value;
            if(rl.toString().length<10)
            {
                alert("Contact No. should be of ten digits");
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
                        <form action="../student"  method="post" name="student_form" onsubmit="return reqrd()">
                            <table width="100%" cellpadding="3" cellspacing="3" align="center">
                                <tr height="40">
                                    <td align="center" colspan="2">
                                        <h2>New Students</h2>
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
                                    <td colspan="4">
                                        <fieldset>
                                            <legend>Login Information</legend>
                                            <table width="100%" cellpadding="5" cellspacing="5" align="center">
                                                <tr>
                                                    <td class="text-1" align="center"><span style="color: red;">*</span>
                                                        Password
                                                    </td>
                                                    <td>
                                                        <input type ="password" name="txtpassword" id="txtpassword" class="texttype">
                                                    </td>

                                                    <td  class="text-1" colspan="" align="center">
                                                        Confirm Password
                                                    </td>
                                                    <td class="" colspan="">
                                                        <input type ="password" name="confirmpassword" id="confirmpassword" class="texttype" onblur="return confirPwd();">
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
                                                    <td class="text-1" align=""><span style="color: red;">*</span>
                                                        Student ID
                                                    </td>
                                                    <%
                                                                String stuid = null;
                                                                stuid = connection.AutoID.globalGenId("S-", "student");
                                                    %>
                                                    <td>
                                                        <input type ="text" name="txtid" id="txtid" class="texttype" value="<%=stuid%>" readonly>
                                                    </td>
                                                    <td class="text-1" align=""><span style="color: red;">*</span>
                                                        Student Name
                                                    </td>
                                                    <td>
                                                        <input type ="text" name="name" id="name" class="texttype">
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="text-1"><span style="color: red;">*</span>
                                                       Course
                                                    </td>
                                                    <td>
                                                        <select  class="combotext" id="class" name="class">
                                                            <option value="na"> - - - - Selected - - - - </option>                                                            
                                                            <option value="Bca">Bca</option>
                                                            <option value="Mca">Mca</option>
                                                            <option value="BBA">BBA</option>
                                                            <option value="MBA">MBA</option>
                                                            <option value="BTec">BTec</option>
                                                            <option value="MTec">MTec</option>
                                                            <option value="Diploma">Diploma</option>
                                                        </select>

                                                    </td>

                                                    <td class="text-1"><span style="color: red;">*</span>
                                                        Section
                                                    </td>
                                                    <td>
                                                        <input type="text" name="section" id="section" class="texttype">
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="text-1"><span style="color: red;">*</span>
                                                        Gender
                                                    </td>
                                                    <td >
                                                        <select id="cmbgender" name="cmbgender" class="combotext1">
                                                            <option value="na"selected>---- select-----</option>
                                                            <option value="Male"> Male</option>
                                                            <option value="FeMale">Female</option>
                                                        </select>
                                                    </td>
                                                    <td class="text-1"><span style="color: red;">*</span>
                                                        Date of Birth
                                                    </td>
                                                    <td>
                                                        <input type="text" name="txtdob" id="txtdob" class="texttype" readonly onclick="showCal(this, event);">
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="text-1">
                                                        Telephone No.
                                                    </td>
                                                    <td>
                                                        <input type="text" name="telephone" id="telephone" class="texttype" onkeyup="contact(this)" onblur="mob()">
                                                    </td>
                                                    <td class="text-1">
                                                        Mobile No.
                                                    </td>
                                                    <td>
                                                        <input type="text" name="mobile" id="mobile" class="texttype">
                                                    </td>
                                                </tr>
                                                <tr>                                                   

                                                    <td class="text-1">
                                                        Email ID
                                                    </td>
                                                    <td>
                                                        <input type="text" name="email" id="email" class="texttype" onblur="valid()">
                                                    </td>
                                                    <td class="text-1">
                                                        Father
                                                    </td>
                                                    <td>
                                                        <input type="text" name="father" id="father" class="texttype">
                                                    </td>

                                                </tr>                                                
                                                <tr>
                                                    <td class="textarea">
                                                        Present Address
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
                                                <tr>
                                                    <td class="text-1">
                                                        Father&nbsp;Occupation
                                                    </td>
                                                    <td>
                                                        <input type="text" name="occupation" id="occupation" class="texttype">
                                                    </td>
                                                </tr>
                                            </table>

                                        </fieldset>
                                    </td>
                                </tr>

                                <tr align="center">
                                    <td colspan="4">
                                        <input type="submit" value="Submit" id="btnsubmit" name="btnsubmit" >
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
