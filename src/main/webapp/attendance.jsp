<%@ page import="java.util.List" %>
<%@ page import="java.sql.*, javax.sql.DataSource" %>
<%@ page import="com.java.Student" %>
<%@ page import="com.java.StudentDAO" %>
<%@ page import="com.java.DatabaseUtils" %>
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
    	.container {
			  max-width: 100%;
			  margin-inline: 3rem;
			  /* margin: 10px auto; */
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
