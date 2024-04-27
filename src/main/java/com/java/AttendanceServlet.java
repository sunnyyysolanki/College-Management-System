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

@WebServlet("/submitAttendance")
public class AttendanceServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String sub = request.getParameter("subject");
        String date = request.getParameter("date");
        String submit = request.getParameter("submit");

        if (date != null && submit == null) {
            // If only the date is provided, fetch existing attendance data for that date
            try (Connection connection = DatabaseUtils.getConnection()) {
                // Fetch existing attendance data for the given date
                Map<String, String> attendanceStatus = new HashMap<>();
                PreparedStatement fetchStatement = connection.prepareStatement(
                    "SELECT student_id, status FROM attendance_" + sub + " WHERE date = ?");
                fetchStatement.setString(1, date);

                ResultSet resultSet = fetchStatement.executeQuery();
                while (resultSet.next()) {
                    String studentId = resultSet.getString("student_id");
                    String status = resultSet.getString("status");
                    attendanceStatus.put(studentId, status);
                }

                // Set fetched data as an attribute for the JSP to use
                request.setAttribute("attendanceStatus", attendanceStatus);
                request.setAttribute("selectedDate", date);

                // Forward the request back to the JSP for rendering with the fetched data
                request.getRequestDispatcher("attendance.jsp").forward(request, response);

            } catch (SQLException e) {
                e.printStackTrace();
            }

        } else if (submit != null) {
            // If the form is being submitted, update the attendance records
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

            try (Connection connection = DatabaseUtils.getConnection()) {
                for (Map.Entry<String, String> entry : attendanceMap.entrySet()) {
                    String studentId = entry.getKey();
                    String status = entry.getValue();

                    PreparedStatement checkStatement = connection.prepareStatement(
                        "SELECT COUNT(*) FROM attendance_" + sub + " WHERE student_id = ? AND date = ?");
                    checkStatement.setString(1, studentId);
                    checkStatement.setString(2, date);
                    ResultSet resultSet = checkStatement.executeQuery();
                    resultSet.next();
                    int count = resultSet.getInt(1);
                    checkStatement.close();

                    if (count > 0) {
                        // Update existing record
                        PreparedStatement updateStatement = connection.prepareStatement(
                            "UPDATE attendance_" + sub + " SET status = ? WHERE student_id = ? AND date = ?");
                        updateStatement.setString(1, status);
                        updateStatement.setString(2, studentId);
                        updateStatement.setString(3, date);
                        updateStatement.executeUpdate();
                        updateStatement.close();
                    } else {
                        // Insert new record
                        PreparedStatement insertStatement = connection.prepareStatement(
                            "INSERT INTO attendance_" + sub + " (student_id, date, status) VALUES (?, ?, ?)");
                        insertStatement.setString(1, studentId);
                        insertStatement.setString(2, date);
                        insertStatement.setString(3, status);
                        insertStatement.executeUpdate();
                        insertStatement.close();
                    }
                }

                response.getWriter().println("Attendance updated successfully."); // Redirect after successful submission

            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
