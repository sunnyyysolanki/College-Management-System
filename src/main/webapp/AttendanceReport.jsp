<%@ page import="java.sql.*" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" data-ng-app="myApp">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Attendance Report</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" href="https://netdna.bootstrapcdn.com/twitter-bootstrap/2.3.2/css/bootstrap-combined.min.css">
<link rel="stylesheet" href="CSS/AdminAttendanceReport.css">


</head>
<body>
<!--===================navbar=============== -->
    <header class="header" id="header">
        <nav class="nav container">
           <a href="#" class="nav__logo">Indus University</a>
        </nav>
   </header>

<form method="post">
    
        
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
   	
    <input class="box" type="submit" value="View Detail">
</form>
<% 
String sub = request.getParameter("subject");
// JDBC URL, username, and password
String jdbcUrl = "jdbc:mysql://localhost:3306/admindb";
String username = "root";
String password = "Yash@297";

// Create a DecimalFormat object to format percentage
DecimalFormat df = new DecimalFormat("##.##");

if (sub != null && !sub.isEmpty()) {
Connection conn = null;
PreparedStatement pstmt = null;
ResultSet rs = null;

try {
    // Connect to the database
    Class.forName("com.mysql.cj.jdbc.Driver");
    conn = DriverManager.getConnection(jdbcUrl, username, password);

    String sql = "SELECT student_id, SUM(CASE WHEN status = 'present' THEN 1 ELSE 0 END) AS total_present, COUNT(*) AS total_lectures " +
               "FROM attendance_"+sub+" GROUP BY student_id";
    pstmt = conn.prepareStatement(sql);
    rs = pstmt.executeQuery();
%> 
<div class="detail_container" data-ng-controller="myCtrl">
    <div class="row">
        <div class="s col-md-2">
            Search:
        </div>
        <div class="col-md-10">
            <input type="text" id="searchInput" placeholder="Search..." class="search" />
        </div>
    </div>
    <br/>
    <table id="dataTable">
        <tr>
            <th>Student Id</th>
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
    </table>
  
  
</div>

<%
} catch (Exception e) {
    e.printStackTrace();
} finally {
    // Close resources
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
<script>

document.getElementById('searchInput').addEventListener('keyup', function() {
	  var searchText = this.value.toLowerCase();
	  var table = document.getElementById('dataTable');
	  var rows = table.getElementsByTagName('tr');
	  
	  for (var i = 0; i < rows.length; i++) {
	    var rowData = rows[i].textContent.toLowerCase();
	    if (rowData.includes(searchText)) {
	      rows[i].style.display = '';
	    } else {
	      rows[i].style.display = 'none';
	    }
	  }
	});

</script>
</body>
</html>
