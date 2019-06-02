/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package connection;

import java.sql.Connection;
import java.sql.Statement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.DriverManager;

/**
 *
 * @author Owner
 */
public class getDBConnection {

    static Connection con = null;
    Statement st = null;
    ResultSet rs = null;
    int p;

    /* Creates a new instance of ConnectionBean */
    public static Connection makeConn() {
        try {
            Class.forName("com.mysql.jdbc.Driver").newInstance();
            con = DriverManager.getConnection("jdbc:mysql://localhost/onlineexam", "root", "");


        } catch (Exception e) {
            e.printStackTrace();
        }
        return con;
    }

    public static void closeConn() throws Exception {
        if (con != null) {
            con.close();
        }
    }
}
