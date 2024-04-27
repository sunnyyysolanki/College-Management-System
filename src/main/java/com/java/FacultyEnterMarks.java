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

public class FacultyEnterMarks extends HttpServlet {
	private static final long serialVersionUID = 1L;
  
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String operation = request.getParameter("operation");
		String studentId = request.getParameter("student_id");
		//String Course = request.getParameter("Course");
	//	String Semester_year = request.getParameter("Sem");
		String subject = request.getParameter("subject");
		String MSE_Theory = request.getParameter("MSE_Theory");
		String ESE_Theory = request.getParameter("ESE_Theory");
		String MSE_Practical = request.getParameter("MSE_Practical");
		String ESE_Practical = request.getParameter("ESE_Practical");
		
		String url = "jdbc:mysql://localhost:3306/admindb";
        String username = "root";
        String password = "Yash@297";
		
        try(Connection connection = DriverManager.getConnection(url, username, password)){
        	switch(operation) {
        	case "insert":
        		String insertDataSQL = "insert into cse_sem6_marksheet (student_id, subject_id, theory_mse, theory_ese, practical_mse, practical_ese) values(?,?,?,?,?,?);";
        		try (PreparedStatement preparedStatement = connection.prepareStatement(insertDataSQL)) {
        			preparedStatement.setString(1, studentId);
                    preparedStatement.setString(2, subject);
                    preparedStatement.setString(3, MSE_Theory);
                    preparedStatement.setString(4, ESE_Theory);
                    preparedStatement.setString(5, MSE_Practical);
                    preparedStatement.setString(6, ESE_Practical);
                    preparedStatement.executeUpdate();
                    response.getWriter().println("Data inserted successfully.");
        		}
        		break;
        		
        	case "update":
        		String updateDataSQL = "UPDATE cse_sem6_marksheet SET theory_mse = ?, theory_ese = ?, practical_mse = ?, practical_ese = ? WHERE student_id = ? AND subject_id = ?";
        		try (PreparedStatement preparedStatement = connection.prepareStatement(updateDataSQL)) {
        			preparedStatement.setString(1, MSE_Theory);
                    preparedStatement.setString(2, ESE_Theory);
                    preparedStatement.setString(3, MSE_Practical);
                    preparedStatement.setString(4, ESE_Practical);
                    preparedStatement.setString(5, studentId);
                    preparedStatement.setString(6, subject);
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
