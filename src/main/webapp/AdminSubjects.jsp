<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" ng-app="myApp">
<head>
   <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Subjects Administration</title>
    <!-- Style and CSS Imports -->
    <!-- Example CSS (adjust as needed) -->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Syne:wght@400;500;600&display=swap">
    <link rel="stylesheet" href="CSS/AdminSubjects.css">
</head>
<body>
<header class="header" id="header">
        <nav class="nav container">
           <a href="#" class="nav__logo">Indus University</a>
        </nav>
   </header>

<form method="post" action="AdminSubjects.jsp">
    <h2>Select Course and Semester</h2>
    <div>
        <label for="course">Select Course:</label>
        <select name="course" id="course">
            <option value="CSE">COMPUTER SCIENCE ENGINEERING</option>
            <option value="CE">COMPUTER ENGINEERING</option>
            <option value="IT">INFORMATION TECHNOLOGY</option>
            <option value="ME">MECHANICAL ENGINEERING</option>
            <option value="AE">AUTOMOBILE ENGINEERING</option>
        </select>
    </div>
    <div>
        <label for="sem">Select Semester:</label>
        <select name="sem" id="sem">
            <option value="sem-1">Semester 1</option>
            <option value="sem-2">Semester 2</option>
            <option value="sem-3">Semester 3</option>
            <option value="sem-4">Semester 4</option>
            <option value="sem-5">Semester 5</option>
            <option value="sem-6">Semester 6</option>
            <option value="sem-7">Semester 7</option>
            <option value="sem-8">Semester 8</option>
        </select>
    </div>
    <input type="submit" value="View Detail">
</form>

<%-- JSP Block to handle database interaction --%>
<%
String course = request.getParameter("course");
String sem = request.getParameter("sem");

if (course != null && !course.isEmpty() && sem != null && !sem.isEmpty()) {
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        // Connect to the database
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/AdminDb", "root", "Yash@297");

        // Prepare a parameterized query to fetch subject details based on course and semester
        String query = "SELECT * FROM subjects WHERE course = ? AND semester = ?";
        pstmt = conn.prepareStatement(query);
        pstmt.setString(1, course);
        pstmt.setString(2, sem);

        // Execute the query and display the results
        rs = pstmt.executeQuery();
%>

<div class="container">
    <table>
      <tr>
          <th>Course</th>
          <th>Semester</th>
          <th>Subject Code</th>
          <th>Subject Name</th>
          <th>Faculty Name</th>
          <th>Subject Credit</th>
          <th>Theory</th>
          <th>Practical</th>
      </tr>
      <% while(rs.next()) { %>
      <tr>
          <td><%= rs.getString("course") %></td>
          <td><%= rs.getString("semester") %></td>
          <td><%= rs.getString("subject_code") %></td>
          <td><%= rs.getString("subject_name") %></td>
          <td><%= rs.getString("Faculty_name") %></td>
          <td><%= rs.getString("subject_credit") %></td>
          <td><%= rs.getString("Theory") %></td>
          <td><%= rs.getString("Practical") %></td>
      </tr>
      <% } %>
  </table>
</div>

<% 
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        // Close resources to prevent leaks
        try {
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }
}
%>

</body>
</html>
