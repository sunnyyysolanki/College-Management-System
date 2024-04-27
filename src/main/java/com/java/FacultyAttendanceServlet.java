package com.java;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/SubmitAttendance")
public class FacultyAttendanceServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	String sub = request.getParameter("subject");
        String date = request.getParameter("date");
        Map<String, String> attendanceMap = new HashMap<>();
        Enumeration<String> parameterNames = request.getParameterNames();
        while (parameterNames.hasMoreElements()) {
            String paramName = parameterNames.nextElement();
            if (paramName.startsWith("student_")) {
                String studentId = paramName.substring("student_".length());
                String status = request.getParameter(paramName);
                attendanceMap.put(studentId, status);
            }
        }

        try {
            Connection connection = DatabaseUtils.getConnection();
            for (Map.Entry<String, String> entry : attendanceMap.entrySet()) {
                String studentId = entry.getKey();
                String status = entry.getValue();
                
                // Check if attendance record already exists for this student and date
                PreparedStatement checkStatement = connection.prepareStatement(
                        "SELECT COUNT(*) FROM attendance_"+sub+" WHERE student_id = ? AND date = ?");
                checkStatement.setString(1, studentId);
                checkStatement.setString(2, date);
                ResultSet resultSet = checkStatement.executeQuery();
                resultSet.next();
                int count = resultSet.getInt(1);
                checkStatement.close();
                
                if (count > 0) {
                    // Update existing record
                    PreparedStatement updateStatement = connection.prepareStatement(
                            "UPDATE attendance_"+sub+" SET status = ? WHERE student_id = ? AND date = ?");
                    updateStatement.setString(1, status);
                    updateStatement.setString(2, studentId);
                    updateStatement.setString(3, date);
                    updateStatement.executeUpdate();
                    updateStatement.close();
                    
                    
                } else {
                    // Insert new record
                    PreparedStatement insertStatement = connection.prepareStatement(
                            "INSERT INTO attendance_"+sub+" (student_id, date, status) VALUES (?, ?, ?)");
                    insertStatement.setString(1, studentId);
                    insertStatement.setString(2, date);
                    insertStatement.setString(3, status);
                    insertStatement.executeUpdate();
                    insertStatement.close();
                }
            }
            
            connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        response.sendRedirect("FacultyAttendance.jsp");
    }
}
