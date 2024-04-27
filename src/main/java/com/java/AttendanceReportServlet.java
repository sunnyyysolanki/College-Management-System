package com.java;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
	
@WebServlet("/attendanceReport")
public class AttendanceReportServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String studentId = request.getParameter("studentId");
        if (studentId == null || studentId.isEmpty()) {
            response.getWriter().println("Please provide a student ID.");
            return;
        }

        try {
            Connection connection = DatabaseUtils.getConnection();

            // Query to count total present lectures for the student
            PreparedStatement presentStatement = connection.prepareStatement(
                    "SELECT COUNT(*) FROM attendance WHERE student_id = ? AND status = 'present'");
            presentStatement.setString(1, studentId);
            ResultSet presentResult = presentStatement.executeQuery();
            presentResult.next();
            int totalPresent = presentResult.getInt(1);
            presentStatement.close();

            // Query to count total lectures for the student (both present and absent)
            PreparedStatement totalStatement = connection.prepareStatement(
                    "SELECT COUNT(*) FROM attendance WHERE student_id = ?");
            totalStatement.setString(1, studentId);
            ResultSet totalResult = totalStatement.executeQuery();
            totalResult.next();
            int totalLectures = totalResult.getInt(1);
            totalStatement.close();

            // Calculate total absent lectures
            int totalAbsent = totalLectures - totalPresent;

            // Calculate percentage
            double percentage = (double) totalPresent / totalLectures * 100;

            // Forward data to JSP for rendering
            request.setAttribute("studentId", studentId);
            request.setAttribute("totalPresent", totalPresent);
            request.setAttribute("totalAbsent", totalAbsent);
            request.setAttribute("totalLectures", totalLectures);
            request.setAttribute("percentage", percentage);

            connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        request.getRequestDispatcher("attendanceReport.jsp").forward(request, response);
    }
}
