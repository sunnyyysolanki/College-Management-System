<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
    <title>Student Marks</title>
    <link rel="stylesheet" href="CSS/style.css">
    <link rel="stylesheet" href="CSS/AdminMarksheet.css">
</head>
<body>
<form method="post">
    <div class="row">
        <div class="col-md-6">
            <label for="Course">Select Course:</label>
            <select name="course" id="course">
                <option value="CSE">COMPUTER SCIENCE ENGINEERING</option>
                <option value="CE">COMPUTER ENGINEERING</option>
                <option value="IT">INFORMATION TECHNOLOGY</option>
                <option value="ME">MECHANICAL ENGINEERING</option>
                <option value="AE">AUTOMOBILE ENGINEERING</option>
            </select>
            <br>
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
        </div>
    </div>
        <label class="col-md-6" for="id">Enter Student ID</label>
        <input class="IU" type="text" name="id" placeholder="IU" id="id">
        <input class="box" type="submit" value="View Marksheet">
    </form>
	
<%

    // Check if the form is submitted
    if (request.getMethod().equals("POST")) {
        // Retrieve form data
        String course = request.getParameter("course");
        String sem = request.getParameter("sem");
        String studentId = request.getParameter("id");

        // Define MySQL database connection details
        String url = "jdbc:mysql://localhost:3306/admindb";
        String username = "root";
        String password = "Yash@297";

        // Establish database connection
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;

        try {
            // Load the MySQL JDBC driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Connect to the database
            conn = DriverManager.getConnection(url, username, password);

            // Create SQL query to fetch data
            String sql = "SELECT " + 
             course + "_" + sem + "_subjects.subject_name, " + 
             course + "_" + sem + "_subjects.subject_code, " + 
             course + "_" + sem + "_subjects.credit, " + 
             course + "_" + sem + "_marksheet.theory_mse, " + 
             course + "_" + sem + "_marksheet.theory_ese, " + 
             course + "_" + sem + "_marksheet.practical_mse, " + 
             course + "_" + sem + "_marksheet.practical_ese " +
             "FROM " + course + "_" + sem + "_students " +
             "JOIN " + course + "_" + sem + "_marksheet ON " + 
             course + "_" + sem + "_students.student_id = " + 
             course + "_" + sem + "_marksheet.student_id " +
             "JOIN " + course + "_" + sem + "_subjects ON " + 
             course + "_" + sem + "_subjects.subject_id = " + 
             course + "_" + sem + "_marksheet.subject_id " +
             "WHERE " + course + "_" + sem + "_students.student_id = ?";


            // Prepare the statement
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, studentId);

            // Execute the query
            rs = pstmt.executeQuery();

%>
<div class="container">
    <table style="width: 100%; border-collapse: collapse; margin-top: 20px; box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);">
        <tr>
            <th>Subject Name</th>
            <th>Subject Code</th>
            <th>CREDIT</th>
            <th>MSE Theory</th>
            <th>ESE Theory</th>
            <th>MSE Practical</th>
            <th>ESE Practical</th>
        </tr>
        <% while(rs.next()) { %>
        <tr>
            <td><%= rs.getString("subject_name") %></td>
            <td><%= rs.getString("subject_code") %></td>
            <td><%= rs.getInt("credit") %></td>
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
    }
%>



</body>
</html>