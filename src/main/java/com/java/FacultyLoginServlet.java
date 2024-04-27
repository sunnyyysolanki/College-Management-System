package com.java;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

/**
 * Servlet implementation class loginServlet
 */
public class FacultyLoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 String username = request.getParameter("username");
	        String password = request.getParameter("password");
	        PrintWriter out = response.getWriter();
	        
	        FacultyNameUtility.setFacultyName(username);
	        
	        String jdbcURL = "jdbc:mysql://localhost:3306/logindb";
	        String dbUser = "root";
	        String dbPassword = "Yash@297";
	        
	        try {
	            Class.forName("com.mysql.jdbc.Driver");
	            Connection connection = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);
	            
	            String sql = "SELECT * FROM FacultyLogin WHERE username = ? AND password = ?";
	            PreparedStatement statement = connection.prepareStatement(sql);
	            statement.setString(1, username);
	            statement.setString(2, password);
	            
	            ResultSet result = statement.executeQuery();
	            
	            if (result.next()) {
	            	response.sendRedirect("FacultyHome.html");
	            } else {
	                out.println("Invalid username or password.");
	            }
	            
	            connection.close();
	        } catch (Exception e) {
	            out.println("Error: " + e.getMessage());
	        }
	}

}
