<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.java.FacultyNameUtility" %>
<!DOCTYPE html>
<html>
<head>
    <title>View Subject Asign</title>
    <link rel="stylesheet" href="CSS/style.css">	
    <link rel="stylesheet" href="CSS/AdminViewSubjectAsign.css">
  </head>
  <body>
    <%
    		String FacultyID = FacultyNameUtility.getFacultyName();
                Connection conn = null;
                Statement stmt = null;
                ResultSet rs = null;

                try {
                    Class.forName("com.mysql.jdbc.Driver");
                    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/AdminDb", "root", "Yash@297");
                    stmt = conn.createStatement();	
                    String query = "SELECT * FROM asign_subject WHERE faculty_id = '"+FacultyID+"' ORDER BY faculty_id";
                    
                    rs = stmt.executeQuery(query);
%>
                  
<h2>Faculty Subject Asign</h2>  
<div class="container">
    <table  style="width: 100%; border-collapse: collapse; margin-top: 20px; box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);">
      <tr>
        <th>Faculty ID</th>
        <th>SUBJECT CODE</th>
        <th>SUBJECT ID</th>
        <th>subject Name</th>
      </tr>
      <% while (rs.next()) {%>
          <tr>
            <td><%= rs.getString("faculty_id") %></td>
            <td><%= rs.getString("subject_code") %></td>
            <td><%= rs.getString("subject_id") %></td>
            <td><%= rs.getString("subject_name") %></td>
      	</tr>
         <% } %>
     
    </table>
    </div>
    <%
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            // Close resources
            try { if (rs != null) rs.close(); } catch (SQLException e) { e.printStackTrace(); }
            try { if (stmt != null) stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            try { if (conn != null) conn.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
%>
    
  </body>
</html>