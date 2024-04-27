package com.java;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class EditStudentDetail extends HttpServlet {
	private static final long serialVersionUID = 1L;
  

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String operation = request.getParameter("operation");
		String studentId = request.getParameter("student_id");
		String studentName = request.getParameter("studentName");
		String Address = request.getParameter("address");
		String Email_ID = request.getParameter("email");
		String DOB = request.getParameter("dob");
		String Contact_no = request.getParameter("contact");
		String Course = request.getParameter("Course");
		String Semester_year = request.getParameter("Sem");
		String admission_date = request.getParameter("addmission_date");
		
		
		String url = "jdbc:mysql://localhost:3306/admindb";
        String username = "root";
        String password = "Yash@297";
		
        try(Connection connection = DriverManager.getConnection(url, username, password)){
        	switch(operation) {
        	case "insert":
        		String insertDataSQL = "INSERT INTO students (id, student_name, Address, Email_ID, DOB, Contact_no, Course, Semester_year, admission_date) values(?,?,?,?,?,?,?,?,?)";
        		try (PreparedStatement preparedStatement = connection.prepareStatement(insertDataSQL)) {
        			preparedStatement.setString(1, studentId);
                    preparedStatement.setString(2, studentName);
                    preparedStatement.setString(3, Address);
                    preparedStatement.setString(4, Email_ID);
                    preparedStatement.setString(5, DOB);
                    preparedStatement.setString(6, Contact_no);
                    preparedStatement.setString(7, Course);
                    preparedStatement.setString(8, Semester_year);
                    preparedStatement.setString(9, admission_date);
                    preparedStatement.executeUpdate();
                    response.getWriter().println("Data inserted successfully.");
        		}
        		break;
        		
        	case "update":
        		String updateDataSQL = "UPDATE students SET student_name = ?, Address = ?, Email_id = ?, DOB = ?, Contact_no = ?, Course = ?, Semester_year = ?, admission_date = ? WHERE ID = ?";
        		try (PreparedStatement preparedStatement = connection.prepareStatement(updateDataSQL)) {
        			preparedStatement.setString(1, studentName);
                    preparedStatement.setString(2, Address);
                    preparedStatement.setString(3, Email_ID);
                    preparedStatement.setString(4, DOB);
                    preparedStatement.setString(5, Contact_no);
                    preparedStatement.setString(6, Course);
                    preparedStatement.setString(7, Semester_year);
                    preparedStatement.setString(8, admission_date);
                    preparedStatement.setString(9, studentId);
                    preparedStatement.executeUpdate();
                    response.getWriter().println("Data updated successfully.");
                }
                break;
        	default:	
                response.getWriter().println("Invalid operation.");
                break;
        	}
     
        	
        } catch (SQLException e) {
			e.printStackTrace();
			response.getWriter().println("Database operation failed. Error: " + e.getMessage());
		}
	}
	
}
