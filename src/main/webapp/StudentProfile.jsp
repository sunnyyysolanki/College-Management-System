
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.java.UsernameUtility" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css"/>
    <!--=============== REMIXICONS ===============-->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/remixicon/3.5.0/remixicon.css">
	<link rel="stylesheet" href="CSS/StudentProfile.css">
<title>Student Detail</title>
</head>
<body>

	
    <!--===================navbar=============== -->
    <header class="header" id="header">
        <nav class="nav container">
           <a href="#" class="nav__logo">Indus University</a>

           <div class="nav__menu" id="nav-menu">
              <ul class="nav__list">
                 <li class="nav__item">
                    <a href="AdminHome.html" class="nav__link">Home</a>
                 </li>

                 <li class="nav__item">
                    <a href="#" class="nav__link">About Us</a>
                 </li>

                 <li class="nav__item">
                    <a href="#" class="nav__link">Services</a>
                 </li>

                 <li class="nav__item">
                    <a href="#" class="nav__link">Featured</a>
                 </li>

                 <li class="nav__item">
                    <a href="#" class="nav__link">Contact Me</a>
                 </li>
              </ul>
           </div>
        </nav>
   </header>
		
		
		<div class="profile_container">
            <div class="detail-container">
        <h2>Student Details</h2>
        
        
        <%
        String username = UsernameUtility.getUsername();
   

                Connection conn = null;
                Statement stmt = null;
                ResultSet rs = null;

                try {
                    Class.forName("com.mysql.jdbc.Driver");
                    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/AdminDb", "root", "Yash@297");
                    stmt = conn.createStatement();	
                    String query = "SELECT * FROM students WHERE id ='"+ username +"'";
                    

                    rs = stmt.executeQuery(query);
                    if (rs.next()) {
        %>
        <table>
            <tr>
                <td><img src="<%= rs.getString("link") %>" alt="img"></td>
                <td>
                    <table border="1">
                        <tr>
                            <td>Roll Number</td>
                            <td><%= rs.getString("id") %></td>
                        </tr>
                        <tr>
                            <td>Student Name</td>
                            <td><%= rs.getString("student_name") %></td>
                        </tr>
                        <tr>
                            <td>Address</td>
                            <td><%= rs.getString("Address") %></td>
                        </tr>
                        <tr>
                            <td>Email ID</td>
                            <td><%= rs.getString("Email_ID") %></td>
                        </tr>
                        <tr>
                            <td>Date Of Birth</td>
                            <td><%= rs.getString("DOB") %></td>
                        </tr>
                        <tr>
                            <td>Contact Number</td>
                            <td><%= rs.getString("Contact_no") %></td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <table border="1">
                    <tr>
                        <td>Course</td>
                        <td><%= rs.getString("Course") %></td>
                        <td class = "TD">Semester</td>
                        <td><%= rs.getString("Semester_year") %></td>
                    </tr>
                    <tr>
                        <td>Admission Date</td>
                        <td><%= rs.getString("admission_date") %></td>
                    </tr>
                </table>
            </tr>
        </table>
        <%
                    } else {
                        out.println("<p>Student not found with ID:</p>");
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    try {
                        if (rs != null) rs.close();
                        if (stmt != null) stmt.close();
                        if (conn != null) conn.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
           
        %>
    </div>
    </div>

<script>
    function toggleSidebar() {
        var sidebar = document.getElementById("sidebar");
        if (sidebar.style.width === "0px" || sidebar.style.width === "") {
            sidebar.style.width = "250px";
        } else {
            sidebar.style.width = "0px";
        }
    }
</script>

</body>
</html>
