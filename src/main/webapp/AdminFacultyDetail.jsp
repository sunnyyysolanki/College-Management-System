
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
	<link rel="stylesheet" href="CSS/AdminFacultyDetail.css">
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
        <div class="form-container">
            <h2>Enter Faculty ID</h2>
            <form method="post">
               
                <label for="id">Enter Faculty ID</label>
                <input type="text" name="id" id="id">
                <input type="submit" value="View Detail">
            </form>
        </div>

            <div class="detail-container">
        <h2>Faculty Details</h2>
        <%
            String FacultyId = request.getParameter("id");

            if (FacultyId != null && !FacultyId.isEmpty()) {
                Connection conn = null;
                PreparedStatement pstmt = null;
                ResultSet rs = null;

                try {
                    Class.forName("com.mysql.jdbc.Driver");
                    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/AdminDb", "root", "Yash@297");

                    String query = "SELECT * FROM faculty WHERE id = ?";
                    pstmt = conn.prepareStatement(query);
                    pstmt.setString(1, FacultyId);

                    rs = pstmt.executeQuery();

                    if (rs.next()) {
        %>
        <table>
            <tr>
                <td></td>
                <td>
                    <table border="1">
                        <tr>
                            <td>Faculty IU</td>
                            <td><%= rs.getString("id") %></td>
                        </tr>
                        <tr>
                            <td>Faculty Name</td>
                            <td><%= rs.getString("faculty_name") %></td>
                        </tr>
                        <tr>
                            <td>Email ID</td>
                            <td><%= rs.getString("Email_ID") %></td>
                        </tr>
                        <tr>
                            <td>Department</td>
                            <td><%= rs.getString("department") %></td>
                        </tr>
                        <tr>
                            <td>Subject</td>
                            <td><%= rs.getString("Subject") %></td>
                        </tr>
                        <tr>
                            <td>Contact Number</td>
                            <td><%= rs.getString("subject_code") %></td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <table border="1">
                    <tr>
                        <td>Course</td>
                        <td><%= rs.getString("JOIN_Date") %></td>
                        <td class ="TD"> Semester</td>
                        <td><%= rs.getString("Contact_no") %></td>
                    </tr>
                    <tr>
                        <td>Admission Date</td>
                        <td><%= rs.getString("gender") %></td>
                        <td class ="TD">Admission Date</td>
                        <td><%= rs.getString("DOB") %></td>
                    </tr>
                </table>
            </tr>
        </table>
        <%
                    } else {
                        out.println("<p>Faculty not found with ID: " + FacultyId + "</p>");
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
