package com.java;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class FacultySubjectAsign extends HttpServlet {
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Fetch data from database
        try {
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/admindb", "root", "Yash@297");
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT subject_name FROM asign_subject where faculty_id='FIU001'");
            
            request.setAttribute("options", rs); // Set result set as an attribute
            
            rs.close();
            stmt.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        request.getRequestDispatcher("/FacultyAttendance.jsp").forward(request, response); // Forward to JSP
    }
}
