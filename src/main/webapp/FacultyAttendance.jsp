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
    <style>
    /*=========================header css==============================*/
    /*=============== GOOGLE FONTS ===============*/
    @import url("https://fonts.googleapis.com/css2?family=Syne:wght@400;500;600&display=swap");

/*=============== VARIABLES CSS ===============*/
:root {
  --header-height: 3.5rem;

  /*========== Colors ==========*/
  /*Color mode HSL(hue, saturation, lightness)*/
  --first-color: hsl(230, 75%, 56%);
  --title-color: hsl(230, 75%, 15%);
  --text-color: hsl(230, 12%, 40%);
  --body-color: hsl(230, 100%, 98%);
  --container-color: hsl(230, 100%, 97%);
  --border-color: hsl(230, 25%, 80%);

  /*========== Font and typography ==========*/
  /*.5rem = 8px | 1rem = 16px ...*/
  --body-font: "Syne", sans-serif;
  --h2-font-size: 1.25rem;
  --normal-font-size: .938rem;

  /*========== Font weight ==========*/
  --font-regular: 400;
  --font-medium: 500;
  --font-semi-bold: 600;

  /*========== z index ==========*/
  --z-fixed: 100;
  --z-modal: 1000;
}

/*========== Responsive typography ==========*/
@media screen and (min-width: 1023px) {
  :root {
    --h2-font-size: 1.5rem;
    --normal-font-size: 1rem;
  }
}

/*=============== BASE ===============*/
/* * {
  box-sizing: border-box;
  padding: 0;
  margin: 0; rrrrrrrrrrrrrrrrrrr
} */

body,
input,
button {
  font-family: var(--body-font);
  font-size: var(--normal-font-size);
}


body,
input,
button {
  font-family: var(--body-font);
  font-size: var(--normal-font-size);
}

body {
  background-color: var(--body-color);
  color: var(--text-color);
  background-color: #f2f2f2;
  margin: 0;
  padding: 0;
}

input,
button {
  border: none;
  outline: none;
}

ul {
  list-style: none;
}

a {
  text-decoration: none;
}

img {
  display: block;
  max-width: 100%;
  height: auto;
}

/*=============== REUSABLE CSS CLASSES ===============*/
.container {
  max-width: 100%;
 /* margin-inline: 3rem; */
   margin: 10px 80px; 
}





/*=============== HEADER & NAV ===============*/
.header {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  background-color: var(--body-color);
  box-shadow: 0 2px 16px hsla(230, 75%, 32%, .15);
  z-index: var(--z-fixed);
}

.nav {
  height: var(--header-height);
  display: flex;
  align-items: center;
}

.nav__logo {
  color: var(--title-color);
  font-weight: var(--font-semi-bold);
  transition: color .4s;
}


        h2 {
            text-align: center;
        }



        label {
            font-weight: bold;
        }

        select, input[type="submit"] {
            width: 200px;
            padding: 5px;
            margin: 5px;
            border-radius: 5px;
        }


    .col-md-10 {
        padding: 20px 20px 0px; /* Add padding for better spacing */
        border-radius: 10px; /* Add border radius for rounded corners */
        margin:50px auto 0;
        margin-inline:5rem;
    }
	
	
    table {		
    			
		        background-color: #fff;
    			border: 1px solid #dddddd;
        		width: 100%;
                border-collapse: collapse;
              /*  margin-top: 20px;*/
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    }

    th, td {
    	border: 1px solid #dddddd;
        padding: 8px;
        text-align: left;
    }
	tr:nth-child(even) {
                background-color: #f2f2f2;
	}
   label{
   		display:inline-block;
   }

    .search {
        width: auto;
            padding: 5px;
            border-radius: 5px;
            background-color: #fff;
            box-sizing: border-box;
    }
    .s{
        width: 0;
        margin: 0 30px;
    }
    
    .col-md-6{
      margin: 0px auto;
	    width: 35%;
	    padding: 20px;
	    /* margin-top: 100px; */
	    background-color: #fff;
	    border-radius: 20px;
	    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
	    align-items: center;
	    text-align: center;
}
    /* .row {
            margin-bottom: 10px;
        } */
        
        .box{
        	 border: 1px solid #ccc;
			  border-radius: 5px;
			  cursor: pointer;
			  transition: all 0.3s ease;
  			box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);	
        }
</style>	
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
