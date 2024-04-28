<%@ page import="java.sql.*" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="com.java.UsernameUtility" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="CSS/StudentAttendance.css">
<title>Attendance Report</title>
</head>
<body>

<!--===================navbar=============== -->
    <header class="header" id="header">
        <nav class="nav container">
           <a href="#" class="nav__logo">Indus University</a>
        </nav>
   </header>
<form method="post">
    
        
        <div class="col-md-6">
            <label for="subject">Select subject</label>
            <select name="subject" id="subject">
                <option value="ajt">ADVANCE JAVA TECHNOLOGY</option>
                <option value="dsc">DATA SCIENCE</option>
                <option value="cns">CRYPTOGRAPHY AND NETWORK SECURITY</option>
               <!--    <option value="sem-4">Semester 4</option>
                <option value="sem-5">Semester 5</option>
                <option value="sem-6">Semester 6</option>
              <option value="sem-7">Semester 7</option>
                <option value="sem-8">Semester 8</option> -->
            </select>
        </div>
   	
    <input class="box" type="submit" value="View Detail">
</form>
  <% 
  String sub = request.getParameter("subject");
  
  String username = UsernameUtility.getUsername();	
  String jdbcUrl = "jdbc:mysql://localhost:3306/admindb";
  String Username = "root";
  String password = "Yash@297";
	
  if (sub != null && !sub.isEmpty()) {
  Connection conn = null;
  PreparedStatement pstmt = null;
  ResultSet rs = null;

  try {
      Class.forName("com.mysql.jdbc.Driver");
      conn = DriverManager.getConnection(jdbcUrl, Username, password);
      String sql = "SELECT student_id, SUM(CASE WHEN status = 'present' THEN 1 ELSE 0 END) AS total_present, COUNT(*) AS total_lectures " +
                   "FROM attendance_"+sub +" WHERE student_id = '"+ username +"' GROUP BY student_id";
      pstmt = conn.prepareStatement(sql);
      rs = pstmt.executeQuery();

      DecimalFormat df = new DecimalFormat("##.##");
%>



<h2>Attendance Report</h2>
<div class="container">
<table border="1">
  <tr>
    <th>Student ID</th>
    <th>Total Present</th>
    <th>Total Lectures</th>
    <th>Percentage</th>
  </tr>


     <% while (rs.next()) { 
		 String studentId = rs.getString("student_id");
          int totalPresent = rs.getInt("total_present");
          int totalLectures = rs.getInt("total_lectures");
          double percentage = (double) totalPresent / totalLectures * 100;

          out.println("<tr>");
          out.println("<td>" + studentId + "</td>");
          out.println("<td>" + totalPresent + "</td>");
          out.println("<td>" + totalLectures + "</td>");
          out.println("<td>" + df.format(percentage) + "%</td>");
          out.println("</tr>");
		
  } %>

<%   
  } catch (Exception e) {
      e.printStackTrace();
  } finally {
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
</table>

</div>
</body>
</html>
