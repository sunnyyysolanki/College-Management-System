package com.java;

import jakarta.servlet.ServletException;
//import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class AdminSubjectAsign extends HttpServlet {
	private static final long serialVersionUID = 1L;
  
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String operation = request.getParameter("operation");
		String subject_name = request.getParameter("subject_name");
		//String Course = request.getParameter("Course");
	//	String Semester_year = request.getParameter("Sem");
		String subject_code = request.getParameter("subject_code");
		String subject_id = request.getParameter("subject_id");
		String faculty_id = request.getParameter("faculty_id");	
		
		String url = "jdbc:mysql://localhost:3306/admindb";
        String username = "root";
        String password = "Yash@297";
		
        try(Connection connection = DriverManager.getConnection(url, username, password)){
        	switch(operation) {
        	case "insert":
        		String insertDataSQL = "insert into asign_subject (faculty_id, subject_code, subject_id, subject_name) values(?,?,?,?);";
        		try (PreparedStatement preparedStatement = connection.prepareStatement(insertDataSQL)) {
        			preparedStatement.setString(1, faculty_id);
                    preparedStatement.setString(2, subject_code);
                    preparedStatement.setString(3, subject_id);
                    preparedStatement.setString(4, subject_name);
                    preparedStatement.executeUpdate();
                    response.getWriter().println("Data inserted successfully.");
        		}
        		break;
        		
        	case "delete":
        		String updateDataSQL = "Delete FROM asign_subject WHERE faculty_id = ? AND subject_code = ?";
        		try (PreparedStatement preparedStatement = connection.prepareStatement(updateDataSQL)) {
        			preparedStatement.setString(1, faculty_id);
                    preparedStatement.setString(2, subject_code);
                    preparedStatement.executeUpdate();
                    response.getWriter().println("Data deleted successfully.");
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
