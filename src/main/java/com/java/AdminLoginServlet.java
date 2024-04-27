package com.java;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class AdminLoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        try {
            String jdbcURL = "jdbc:mysql://localhost:3306/logindb";
            String dbUser = "root";
            String dbPassword = "Yash@297";

            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection connection = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);

            String sql = "SELECT * FROM AdminLogin WHERE username = ? AND password = ?";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, username);
            statement.setString(2, password);

            ResultSet result = statement.executeQuery();

            if (result.next()) {
                HttpSession session = request.getSession(true); // Create a new session
                session.setAttribute("username", username); // Store the username in the session
                response.sendRedirect("AdminHome.html"); // Redirect to the secured admin home page
            } else {
                request.setAttribute("error", "Invalid username or password"); // Set error message
                request.getRequestDispatcher("/AdminLogin.html").forward(request, response); // Forward with error
            }

            connection.close();
        } catch (Exception e) {
            request.setAttribute("error", "An error occurred: " + e.getMessage());
            request.getRequestDispatcher("/AdminLogin.html").forward(request, response); // Forward with error
        }
    }
}
