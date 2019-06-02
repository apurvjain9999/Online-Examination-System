<%-- 
    Document   : deleteTeacher
    Created on : 23 May, 2019, 12:54:13 PM
    Author     : Apurv Jain
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.*,java.util.*"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="../style/style-sheet.css" rel="stylesheet" type="text/css">
        <link href="../style/menu.css" rel="stylesheet" type="text/css">
        <title>Delete Student</title>
    </head>
    <script type="text/javascript">
        
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
                    <div class="content" align="center">
                        <table>
                            <tr> 
        <%
            try {
                Connection con = null;
                ResultSet rs = null;
                Statement st = null;
                con = connection.getDBConnection.makeConn();
                st = con.createStatement();
                
                int ct = 0;
                String sql = "select count(*) from teacher";
                rs = st.executeQuery(sql);
                rs.next();
                ct = rs.getInt(1);
                con.close();
                st.close();
                String id[] = new String[ct];
                int count = 0;
                for(int i=0; i<ct; i++) {
                    id[i] = request.getParameter("check"+i);
                    if(id[i]!=null){
                        count = count + 1;
                    }
                    System.out.println("id=" +id[i]);
                }
                if(count!=0) {
                    con = connection.getDBConnection.makeConn();
                    st = con.createStatement();
                    for(int i=0; i<ct; i++) {
                        st.executeUpdate("delete from teacher where id='" + id[i] + "'");
                        
                    }
        %>
        
                    <td style="color: red;font-size:12px;" align="center">Deleted Successfully!</td>
        <%
                }
                else {
        %>
                   <td style="color: red;font-size:12px;" align="center">Not Deleted Successfully!</td> 
        <%
                }
                con.close();
                st.close();
            }
            
            catch(Exception e) {
            
            }
        %>    
                            </tr>
                            <tr>
                                <td align="center">    
        <a href="TeacherList.jsp" align = "center">
            <button type="submit">
                Continue
            </button>
        </a>
                                </td>   
                        </tr>
                        </table>
                    </div>
                </div>
        <!-- End Content -->
                <!-- Start Footer -->
                <div id="footer">
                    <%@include file="../Footer.html" %>
                </div>
                <!-- End Footer -->
    </body>
</html> 