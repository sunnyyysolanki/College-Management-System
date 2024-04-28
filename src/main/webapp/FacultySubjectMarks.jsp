<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.java.FacultyNameUtility" %>


<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="CSS/FacultySubjectMarks.css">
    <title>Student Marks</title>
    
</head>
<body>
	<h2>Student Marks</h2>
	<!-- <form method="post">
        <label for="Sem">Select Semester</label>
        <select name="sem" id="Sem">
            <option value="sem1">Semester 1</option>
            <option value="sem2">Semester 2</option>
            <option value="sem3">Semester 3</option>
            <option value="sem4">Semester 4</option>
            <option value="sem5">Semester 5</option>
            <option value="sem6">Semester 6</option> 
        <option value="sem7">Semester 7</option>
            <option value="sem8">Semester 8</option>  
        </select>
        <br>	
        <input class="box" type="submit" value="View Marksheet">
    </form -->
	<%
		String facultyID = FacultyNameUtility.getFacultyName();
        // Define MySQL database connection details
        String url = "jdbc:mysql://localhost:3306/admindb";
        String Username = "root";
        String password = "Yash@297";
		
        // Establish database connection
        Connection conn = null;
        Statement stmt = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            // Load the MySQL JDBC driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Connect to the database
            conn = DriverManager.getConnection(url, Username, password);
			
            stmt = conn.createStatement();
            
            String qry = "select subject_name, subject_code from asign_subject where faculty_id = '"+facultyID+"'";
            rs = stmt.executeQuery(qry);
            
               
            
           
            if (rs.next()) {
                String subject_code = rs.getString("subject_code");
            // Create SQL query to fetch data
            String query = "SELECT " +
               "  cse_sem6_marksheet.student_id, " +
               "  cse_sem6_marksheet.theory_mse, " +
               "  cse_sem6_marksheet.theory_ese, " +
               "  cse_sem6_marksheet.practical_mse, " +
               "  cse_sem6_marksheet.practical_ese " +
               "FROM " +
               "  cse_sem6_marksheet " +
               "INNER JOIN " +
               "  asign_subject " +
               "ON " +
               "  cse_sem6_marksheet.subject_id = asign_subject.subject_id " +
               "WHERE " +
               "  asign_subject.subject_code = ? " +
               "AND " +
               "  asign_subject.faculty_id = '"+facultyID+"';";



            
            pstmt = conn.prepareStatement(query);
            pstmt.setString(1, subject_code);
            rs = pstmt.executeQuery();
        }

%>
<div class="container">
    <table border="1" style="width: 100%; border-collapse: collapse; margin-top: 20px; box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);">
        <tr>
            <th>Student ID</th>
            <th>MSE Theory</th>
            <th>ESE Theory</th>
            <th>MSE Practical</th>
            <th>ESE Practical</th>
        </tr>
        <% while(rs.next()) { %>
        <tr>
            <td><%= rs.getString("student_id") %></td>
            <td><%= rs.getInt("theory_mse") %></td>
            <td><%= rs.getInt("theory_ese") %></td>
            <td><%= rs.getInt("practical_mse") %></td>
            <td><%= rs.getInt("practical_ese") %></td>
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