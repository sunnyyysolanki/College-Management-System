
<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" ng-app="myApp">
<head>
   <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="CSS/StudentSubjects.css">
    <title>Student Subjects</title>
</head>
<body>
<!--===================navbar=============== -->
    <header class="header" id="header">
        <nav class="nav container">
           <a href="#" class="nav__logo">Indus University</a>
        </nav>
   </header>
<form method="post">
    <div class="row">
        
        <div class="col-md-6">
            <label for="Sem">Select Semester</label>
            <select name="sem" id="Sem">
                <option value="sem-1">Semester 1</option>
                <option value="sem-2">Semester 2</option>
                <option value="sem-3">Semester 3</option>
                <option value="sem-4">Semester 4</option>
                <option value="sem-5">Semester 5</option>
                <option value="sem-6">Semester 6</option>
              <!--   <option value="sem-7">Semester 7</option>
                <option value="sem-8">Semester 8</option> -->
            </select>
        </div>
    </div>
    <input class="box" type="submit" value="View Detail">
</form>

<%
            // Get the ID parameter from the request
            String sem = request.getParameter("sem");


            // Check if the ID parameter is not null and not empty
            if (sem != null && !sem.isEmpty()) {
                Connection conn = null;
                PreparedStatement pstmt = null;
                ResultSet rs = null;

                try {
                    // Connect to the database
                    Class.forName("com.mysql.jdbc.Driver");
                    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/AdminDb", "root", "Yash@297");

                    // Prepare a parameterized query to fetch student details based on ID
                    String query = "SELECT * FROM subjects WHERE course = 'CSE' AND semester = ?";
                    pstmt = conn.prepareStatement(query);
                    pstmt.setString(1, sem);

                    // Execute the query
                    rs = pstmt.executeQuery();

%>

<div class="container">
   
    <br/>
    <table style="width: 100%; border-collapse: collapse; margin-top: 20px; box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);">
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
  <% 
  } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    // Close resources
                    try {
                        if (rs != null) rs.close();
                        if (pstmt != null) pstmt.close();
                        if (conn != null) conn.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
            } 
%>
    
</div>
</body>
</html>
