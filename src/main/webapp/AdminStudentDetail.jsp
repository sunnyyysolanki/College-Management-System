
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css"/>
    <!--=============== REMIXICONS ===============-->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/remixicon/3.5.0/remixicon.css">
    <link rel="stylesheet" href="CSS/AdminStudentDetail.css">

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

   <a href="EditStudentDetail.html"><button class="edit">
        <span>Edit</span>
    </button>
</a>
     <div class="profile_container">
        <div class="form-container">
            <h2>Enter Student ID</h2>
            <form method="post">
                <label for="Course">Select Course:</label>
                <select name="Course" id="course">
                	<option value="" disabled selected>SELECT YOUR COURSE</option>
                    <option value="CSE">COMPUTER SCIENCE ENGINEERING</option>
                    <option value="CE">COMPUTER ENGINEERING</option>
                    <option value="IT">INFORMATION TECHNOLOGY</option>
                    <option value="ME">MECHANICAL ENGINEERING</option>
                    <option value="AE">AUTOMOBILE ENGINEERING</option>
                </select>
                <br>
                <label for="Sem">Select Semester</label>
                <select name="Sem" id="Sem">	
                	<option value="" disabled selected>Select your semester</option>
                    <option value="1">Semester 1</option>
                    <option value="2">Semester 2</option>
                    <option value="3">Semester 3</option>
                    <option value="4">Semester 4</option>
                    <option value="5">Semester 5</option>
                    <option value="6">Semester 6</option>
                    <option value="7">Semester 7</option>
                    <option value="8">Semester 8</option>
                </select>
                <br>
                <label for="id">Enter Student ID</label>
                <input type="text" name="id" id="id">
                <input type="submit" value="View Detail">
            </form>
        </div>

            <div class="detail-container">
        <h2>Student Details</h2>
        <%
            String studentId = request.getParameter("id");

            if (studentId != null && !studentId.isEmpty()) {
                Connection conn = null;
                PreparedStatement pstmt = null;
                ResultSet rs = null;

                try {
                    Class.forName("com.mysql.jdbc.Driver");
                    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/AdminDb", "root", "Yash@297");

                    String query = "SELECT * FROM students WHERE id = ?";
                    pstmt = conn.prepareStatement(query);
                    pstmt.setString(1, studentId);

                    rs = pstmt.executeQuery();

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
                        <td>Semester</td>
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
                        out.println("<p>Student not found with ID: " + studentId + "</p>");
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    try {
                        if (rs != null) rs.close();
                        if (pstmt != null) pstmt.close();
                        if (conn != null) conn.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
            } else {
                out.println("<p>No student ID provided</p>");
            }
        %>
    </div>
    </div>



</body>
</html>
