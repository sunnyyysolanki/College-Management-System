<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
    <title>Student Marks</title>
    <link rel="stylesheet" href="CSS/style.css">
</head>
<style>

    
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
      margin-inline: 3rem;
       margin: 10px auto; 
    }
    
    .main {
      position: relative;
      height: 100vh;
    }
    
    .main__bg {
      position: absolute;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
      object-fit: cover;
      object-position: center;
      z-index: -1;
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
      /*height: var(--header-height); */
      height:9vh;
      display: flex;
      justify-content: space-between;
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
    
          form {
               margin: 0px auto;
            width: 30%;
            padding: 20px;
            margin-top: 100px;
            background-color: #fff;
            border-radius: 20px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            align-items: center;
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
    
            table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 20px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            }
    
            table, th, td {
                border: 1px solid #dddddd;
            }
    
            th, td {
                padding: 8px;
                text-align: left;
            }
    
            tr:nth-child(even) {
                background-color: #f2f2f2;
            }
    
            .search {
            width: quto;
            padding: 5px;
            border-radius: 5px;
            background-color: #fff;
            /* border: 1px solid #ccc; */
            box-sizing: border-box;
            }
    
            .row {
                margin-bottom: 10px;
            }
            
            
            .IU{
            border: 1px solid #ccc;
                  border-radius: 5px;
                  padding:5px 10px;
                  cursor: pointer;
                  transition: all 0.3s ease;
                  box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);	
            }
            
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
<body>
<form method="post">
    <div class="row">
        <div class="col-md-6">
            <label for="Course">Select Course:</label>
            <select name="course" id="course">
                <option value="CSE">COMPUTER SCIENCE ENGINEERING</option>
                <option value="CE">COMPUTER ENGINEERING</option>
                <option value="IT">INFORMATION TECHNOLOGY</option>
                <option value="ME">MECHANICAL ENGINEERING</option>
                <option value="AE">AUTOMOBILE ENGINEERING</option>
            </select>
            <br>
            <label for="Sem">Select Semester</label>
            <select name="sem" id="Sem">
                <option value="sem1">Semester 1</option>	
                <option value="sem2">Semester 2</option>
                <option value="sem3">Semester 3</option>
                <option value="sem4">Semester 4</option>
                <option value="sem5">Semester 5</option>
                <option value="sem6">Semester 6</option>
                <option value="sem7">Semester 7</option>
                <option value="sem8">Semester 8</option>
            </select>
        </div>
    </div>
        <label class="col-md-6" for="id">Enter Student ID</label>
        <input class="IU" type="text" name="id" placeholder="IU" id="id">
        <input class="box" type="submit" value="View Marksheet">
    </form>
	
<%

    // Check if the form is submitted
    if (request.getMethod().equals("POST")) {
        // Retrieve form data
        String course = request.getParameter("course");
        String sem = request.getParameter("sem");
        String studentId = request.getParameter("id");

        // Define MySQL database connection details
        String url = "jdbc:mysql://localhost:3306/admindb";
        String username = "root";
        String password = "Yash@297";

        // Establish database connection
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;

        try {
            // Load the MySQL JDBC driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Connect to the database
            conn = DriverManager.getConnection(url, username, password);

            // Create SQL query to fetch data
            String sql = "SELECT " + 
             course + "_" + sem + "_subjects.subject_name, " + 
             course + "_" + sem + "_subjects.subject_code, " + 
             course + "_" + sem + "_subjects.credit, " + 
             course + "_" + sem + "_marksheet.theory_mse, " + 
             course + "_" + sem + "_marksheet.theory_ese, " + 
             course + "_" + sem + "_marksheet.practical_mse, " + 
             course + "_" + sem + "_marksheet.practical_ese " +
             "FROM " + course + "_" + sem + "_students " +
             "JOIN " + course + "_" + sem + "_marksheet ON " + 
             course + "_" + sem + "_students.student_id = " + 
             course + "_" + sem + "_marksheet.student_id " +
             "JOIN " + course + "_" + sem + "_subjects ON " + 
             course + "_" + sem + "_subjects.subject_id = " + 
             course + "_" + sem + "_marksheet.subject_id " +
             "WHERE " + course + "_" + sem + "_students.student_id = ?";


            // Prepare the statement
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, studentId);

            // Execute the query
            rs = pstmt.executeQuery();

%>
<div class="container">
    <table style="width: 100%; border-collapse: collapse; margin-top: 20px; box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);">
        <tr>
            <th>Subject Name</th>
            <th>Subject Code</th>
            <th>CREDIT</th>
            <th>MSE Theory</th>
            <th>ESE Theory</th>
            <th>MSE Practical</th>
            <th>ESE Practical</th>
        </tr>
        <% while(rs.next()) { %>
        <tr>
            <td><%= rs.getString("subject_name") %></td>
            <td><%= rs.getString("subject_code") %></td>
            <td><%= rs.getInt("credit") %></td>
            <td><%= rs.getInt("theory_mse") %></td>
            <td><%= rs.getInt("theory_ese") %></td>
            <td><%= rs.getInt("practical_mse") %></td>
            <td><%= rs.getInt("practical_ese") %></td>
        </tr>
        <% } %>
    </table>
</div>
<%
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            // Close resources
            try { if (rs != null) rs.close(); } catch (SQLException e) { e.printStackTrace(); }
            try { if (stmt != null) stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            try { if (conn != null) conn.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    }
%>



</body>
</html>