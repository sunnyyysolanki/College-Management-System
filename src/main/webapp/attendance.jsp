<%@ page import="java.util.List" %>
<%@ page import="java.sql.*, javax.sql.DataSource" %>
<%@ page import="com.java.Student" %>
<%@ page import="com.java.StudentDAO" %>
<%@ page import="com.java.DatabaseUtils" %>
<!DOCTYPE html>
<html>
<head>
	<link rel="stylesheet" href="CSS/AdminAttendance.css">
    <title>Attendance System</title>
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

   <h1>Mark Attendance</h1>
<form id="attendanceForm" action="submitAttendance" method="post">  <!-- action points to the same JSP -->
        <div class="row">
            <div class="col-md-6">
                <label for="subject">Select subject</label>
                <select name="subject" id="subject">
				    <option value="ajt" <%= "ajt".equals(request.getParameter("subject")) ? "selected" : "" %> >ADVANCE JAVA TECHNOLOGY</option>
				    <option value="dsc" <%= "dsc".equals(request.getParameter("subject")) ? "selected" : "" %> >DATA SCIENCE</option>
				    <option value="cns" <%= "cns".equals(request.getParameter("subject")) ? "selected" : "" %> >CRYPTOGRAPHY AND NETWORK SECURITY</option>
				</select>


                <div>
                    <label for="date">Date:</label>
                    <!-- Automatically submit the form when a new date is selected -->
                    <input type="date" id="date" name="date" required onchange="this.form.submit()" value="<%= request.getParameter("date") %>">
                </div>
                <input class="box" type="submit" value="Submit Attendance">
            </div>

            <div class="col-md-10">
                <input type="text" id="searchInput"  placeholder="Search..." class="search" />
            </div>
        </div>

        <br />

        <div class="container">
            <table border="1" id="dataTable">
                <tr>
                    <th>Student ID</th>
                    <th>Student Name</th>
                    <th>Attendance</th>
                </tr>
                <%
                    List<Student> students = StudentDAO.getAllStudents();
                    String selectedDate = request.getParameter("date");
                    String sub = request.getParameter("subject");	

                    Connection conn = null;
                    PreparedStatement stmt = null;
                    ResultSet rs = null;

                    try {
                        conn = DatabaseUtils.getConnection();

                        for (Student student : students) {
                            boolean isPresent = false;

                            if (selectedDate != null) {
                                String attendanceQuery = "SELECT COUNT(*) AS count FROM attendance_"+sub+" WHERE student_id = ? AND date = ? AND status = 'present'";
                                stmt = conn.prepareStatement(attendanceQuery);
                                stmt.setString(1, student.getId());
                                stmt.setString(2, selectedDate);
                                rs = stmt.executeQuery();

                                if (rs.next() && rs.getInt("count") > 0) {
                                    isPresent = true;
                                }
                            }
                %>
                <tr>
                    <td><%= student.getId() %></td>
                    <td><%= student.getName() %></td>
                    <td>
                        <input type="radio" name="student_<%= student.getId() %>" value="present" <%= isPresent ? "checked" : "" %> >
                        <label>Present</label>
                        <input type="radio" name="student_<%= student.getId() %>" value="absent" <%= !isPresent ? "checked" : "" %> >
                        <label>Absent</label>
                    </td>
                </tr>
                <%
                        }
                    } catch (SQLException e) {
                        e.printStackTrace();
                    } finally {
                        if (rs != null) {
                            rs.close();
                        }
                        if (stmt != null) {
                            stmt.close();
                        }
                        if (conn != null) {
                            conn.close();
                        }
                    }
                %>
            </table>
        </div>
    </form>
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
