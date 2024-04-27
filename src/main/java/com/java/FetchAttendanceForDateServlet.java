package com.java;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.*;
import java.sql.*;
import java.util.HashMap;
import java.util.Map;

public class FetchAttendanceForDateServlet extends HttpServlet {
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String selectedDate = request.getParameter("selectedDate");

        if (selectedDate == null || selectedDate.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Date is required.");
            return;
        }

        Map<Integer, String> attendanceMap = new HashMap<>();
        try {
            Connection conn = DatabaseUtils.getConnection();
            String query = "SELECT student_id, status FROM attendance_ajt WHERE date = ?";
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setString(1, selectedDate);

            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                int studentId = rs.getInt("student_id");
                String status = rs.getString("status");
                attendanceMap.put(studentId, status);
            }

            rs.close();
            stmt.close();
            conn.close();

            // Store the data in the request attribute to pass it back to the JSP
            request.setAttribute("attendanceMap", attendanceMap);
            request.setAttribute("selectedDate", selectedDate);

            RequestDispatcher dispatcher = request.getRequestDispatcher("/attendance.jsp");
            dispatcher.forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error fetching attendance data.");
        }
    }
}
