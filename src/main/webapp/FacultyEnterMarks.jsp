<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>    
<%@ page import="com.java.FacultyNameUtility" %>
<!DOCTYPE html>
<!-- Coding By CodingNepal - codingnepalweb.com -->
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
     
    <!----===== Iconscout CSS ===== -->
    <link rel="stylesheet" href="https://unicons.iconscout.com/release/v4.0.0/css/line.css">
	<link rel="stylesheet" href="CSS/Form.css">
   <title>Enter Marks</title>
</head>
<body>
<%
    // Obtain faculty ID and subject parameter
    String facultyID = FacultyNameUtility.getFacultyName();

    // JDBC connection parameters
    String jdbcUrl = "jdbc:mysql://localhost:3306/admindb";
    String username = "root";
    String password = "Yash@297";


    Connection conn = null;
    Statement stmt = null;
    ResultSet rs = null;

    try {
        // Establish database connection
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(jdbcUrl, username, password);
        stmt = conn.createStatement();

        // Get subject names and codes based on faculty ID
        rs = stmt.executeQuery("SELECT subject_name, subject_id FROM asign_subject WHERE faculty_id = '" + facultyID + "'");
%>
    <div class="container">
        <form action="FacultyEnterMarks" method="post">
            <div class="form ">
                <div class="details personal">
                    <span class="title">Marksheet Details</span>

                    <div class="fields">
                        <div class="input-field">
                            <label>ID</label>
                            <input type="text" name="student_id" id="student_id" placeholder="Enter ID" required>
                        </div>
                    
                        <div class="input-field">
                            <label for="Course">Select Course:</label>
                            <select name="Course" id="course">
                            	<option value="" disabled selected>Select your course</option>
                                <option value="CSE">COMPUTER SCIENCE ENGINEERING</option>
                                <option value="CE">COMPUTER ENGINEERING</option>
                                <option value="IT">INFORMATION TECHNOLOGY</option>
                                <option value="ME">MECHANICAL ENGINEERING</option>
                                <option value="AE">AUTOMOBILE ENGINEERING</option>
                            </select>
                        </div>
                        <div class="input-field">
                            <label for="Sem">Select Semester</label>
                            <select name="Sem" id="Sem">
                            	<option value="" disabled selected>Select your Semester</option>
                                <option value="sem-1">Semester 1</option>
                                <option value="sem-2">Semester 2</option>
                                <option value="sem-3">Semester 3</option>
                                <option value="sem-4">Semester 4</option>
                                <option value="sem-5">Semester 5</option>
                                <option value="sem-6">Semester 6</option>
                                <option value="sem-7">Semester 7</option>
                                <option value="sem-8">Semester 8</option>
                            </select>
                        </div>
                        <div class="input-field">
                            <label for="subject">Select Subjects:</label>
					        <select id="subject" name="subject">
					            <%
							        // Populate the dropdown with subjects
							        while (rs.next()) {
							            String subjectCode = rs.getString("subject_id");
							            String subjectName = rs.getString("subject_name");
							            out.println("<option value='" + subjectCode + "'>" + subjectName + "</option>");
							        }
							    %>
					        </select>
                        </div>
                        
                            <div class="input-field">
                                    <label>MSE Theory</label>
                                    <input type="text" name="MSE_Theory" id="MSE Theory" placeholder="Enter MSE Theory Marks" required>
                            </div>
                            
                            <div class="input-field">
                                    <label>ESE Theory</label>
                                    <input type="text" name="ESE_Theory" id="ESE Theory" placeholder="Enter ESE Theory Marks" required>
                            </div>
                            
                            <div class="input-field">
                                    <label>MSE Practical</label>
                                    <input type="text" name="MSE_Practical" id="MSE Practical" placeholder="Enter MSE Practical Marks" required>
                            </div>
                            
                            <div class="input-field">
                                    <label>ESE Practical</label>
                                    <input type="text" name="ESE_Practical" id="ESE Practical" placeholder="Enter ESE Practical Marks" required>
                            </div>
                            <div class="input-field">
                                <label for="operation">Select operation:</label>
                                <select id="operation" name="operation">
                                    <option value="insert">Insert</option>
                                    <option value="update">Update</option>
                                </select>
                    </div>
                    </div>
                    
                        <button class="sumbit">
                            <span class="btnText">Save</span>
                            <i class="uil uil-navigator"></i>
                        </button>
                    </div>
                </div> 
            </form>
            <%
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        // Ensure resources are closed to avoid leaks
        try {
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }
%>
            </div>
        
    
    <script>const form = document.querySelector("form"),
        nextBtn = form.querySelector(".nextBtn"),
        backBtn = form.querySelector(".backBtn"),
        allInput = form.querySelectorAll(".first input");


nextBtn.addEventListener("click", ()=> {
    allInput.forEach(input => {
        if(input.value != ""){
            form.classList.add('secActive');
        }else{
            form.classList.remove('secActive');
        }
    })
})

backBtn.addEventListener("click", () => form.classList.remove('secActive'));</script>
</body>
</html>
