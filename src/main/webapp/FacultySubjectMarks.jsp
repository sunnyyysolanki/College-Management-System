<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.java.FacultyNameUtility" %>


<!DOCTYPE html>
<html>
<head>
    <title>Student Marks</title>
</head>
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
  /* margin: 10px auto; */
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

        select {
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
        
        .box{
        	 border: 1px solid #ccc;
        	 width: 150px;
            padding: 5px;
            margin: 5px;
			  border-radius: 5px;
			  cursor: pointer;
			  transition: all 0.3s ease;
  			box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);	
        }
         
     
        
    </style>
<body>
	<h2>Student Marks</h2>
	<!-- <form method="post">
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
        <br>	
        <input class="box" type="submit" value="View Marksheet">
    </form -->
	<%
		String facultyID = FacultyNameUtility.getFacultyName();
        // Define MySQL database connection details
        String url = "jdbc:mysql://localhost:3306/admindb";
        String Username = "root";
        String password = "Yash@297";
		
        // Establish database connection
        Connection conn = null;
        Statement stmt = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            // Load the MySQL JDBC driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Connect to the database
            conn = DriverManager.getConnection(url, Username, password);
			
            stmt = conn.createStatement();
            
            String qry = "select subject_name, subject_code from asign_subject where faculty_id = '"+facultyID+"'";
            rs = stmt.executeQuery(qry);
            
               
            
           
            if (rs.next()) {
                String subject_code = rs.getString("subject_code");
            // Create SQL query to fetch data
            String query = "SELECT " +
               "  cse_sem6_marksheet.student_id, " +
               "  cse_sem6_marksheet.theory_mse, " +
               "  cse_sem6_marksheet.theory_ese, " +
               "  cse_sem6_marksheet.practical_mse, " +
               "  cse_sem6_marksheet.practical_ese " +
               "FROM " +
               "  cse_sem6_marksheet " +
               "INNER JOIN " +
               "  asign_subject " +
               "ON " +
               "  cse_sem6_marksheet.subject_id = asign_subject.subject_id " +
               "WHERE " +
               "  asign_subject.subject_code = ? " +
               "AND " +
               "  asign_subject.faculty_id = '"+facultyID+"';";



            
            pstmt = conn.prepareStatement(query);
            pstmt.setString(1, subject_code);
            rs = pstmt.executeQuery();
        }

%>
<div class="container">
    <table border="1" style="width: 100%; border-collapse: collapse; margin-top: 20px; box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);">
        <tr>
            <th>Student ID</th>
            <th>MSE Theory</th>
            <th>ESE Theory</th>
            <th>MSE Practical</th>
            <th>ESE Practical</th>
        </tr>
        <% while(rs.next()) { %>
        <tr>
            <td><%= rs.getString("student_id") %></td>
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
   
%>



</body>
</html>