<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="com.java.Student" %>
<%@ page import="com.java.StudentDAO" %>
<%@ page import="com.java.FacultyNameUtility" %>
<!DOCTYPE html>
<html>
<head>
    <title>Attendance System</title>
    <link rel="stylesheet" href="CSS/AdminAttendance.css">
<!--<script>
	function submitForm(event) {
    event.preventDefault(); // Prevent default form submission

    var date = document.getElementById("date").value;

    document.getElementById("successMessage").innerHTML = "You have submitted Attendance successfully on " + date;

    // Perform asynchronous submission to the server
    var formData = new FormData(document.getElementById("attendanceForm"));
    var xhr = new XMLHttpRequest();
    xhr.open("POST", "submitAttendance");
    xhr.send(formData);
}

    </script> -->
</head>
<body>
  <header class="header" id="header">
    <nav class="nav container">
       <a href="#" class="nav__logo">Indus University</a>
    </nav>
</header>

	<%
	String facultyID = FacultyNameUtility.getFacultyName();
    Connection conn = null;
    Statement stmt = null;
    ResultSet rs = null;
    
    try {
        // Establishing a connection to the database
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/admindb", "root", "Yash@297");
        stmt = conn.createStatement();
        rs = stmt.executeQuery("select subject_name, subject_code from asign_subject where faculty_id = '"+facultyID+"'");
	%>
    <h1>Mark Attendance</h1>
    <form id="attendanceForm" action="SubmitAttendance" method="post" >
    	<div class="row">
	    	<div class="col-md-6">
	            <label for="subject">Select subject</label>
	            <select name="subject" id="subject">
            <%
                while (rs.next()) {
                	String id = rs.getString("subject_code");
                    String name = rs.getString("subject_name");
                    // Creating dynamic options for the dropdown
                    out.println("<option value='" + id + "'>" + name + "</option>");
                }
            %>
	            </select>
              <div >
                <label for="date">Date:</label>
                <input type="date" id="date" name="date" required>
                </div>
                <input class="box" type="submit" value="Submit Attendance">

	        </div>
        	
          <div class="col-md-10">
            <input type="text" id="searchInput" placeholder="Search..." class="search" />
        </div>
          <div class="container">
		        <table border="1" id="dataTable">
		            <tr>
		                <th>Student ID</th>
		                <th>Student Name</th>
		                <th>Attendance</th>
		            </tr>
		            <% 
		                List<Student> students = StudentDAO.getAllStudents();
		                for (Student student : students) {
		            %>
		            <tr>
		                <td><%= student.getId() %></td>
		                <td><%= student.getName() %></td>
		                <td>
		                    <input type="radio" id="present_<%= student.getId() %>" name="student_<%= student.getId() %>" value="present" >
		                    <label for="present_<%= student.getId() %>">Present</label>
		                    <input type="radio" id="absent_<%= student.getId() %>" name="student_<%= student.getId() %>" value="absent" checked>
		                    <label for="absent_<%= student.getId() %>">Absent</label>
		                </td>
		            </tr>
	            <% } %>
	        </table>
	        </div>
        </div>
    </form>
    <%
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (rs != null) rs.close();
        if (stmt != null) stmt.close();
        if (conn != null) conn.close();
    }
%>
    <!-- <p>${message}</p>
    <div id="successMessage"></div> -->
    
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
