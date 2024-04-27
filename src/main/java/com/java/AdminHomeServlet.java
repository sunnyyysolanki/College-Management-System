package com.java;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;

public class AdminHomeServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false); // Retrieve existing session
        if (session == null || session.getAttribute("username") == null) {
            // Redirect to login page if there's no valid session
            response.sendRedirect("AdminLogin.html");
            return;
        }

        // If session is valid, render the admin home content
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        out.println("<!DOCTYPE html>");
        out.println("<html lang=\"en\">");
        out.println("<head>");
        out.println("<title>Admin Home</title>");
        out.println("<link rel=\"stylesheet\" href=\"CSS/style.css\">");
        out.println("</head>");
        out.println("<body>");
        out.println("<h1>Welcome, " + session.getAttribute("username") + "!</h1>");
        out.println("<a href='AdminLogoutServlet'>Logout</a>");
        out.println("<div class='main'>");
        out.println("<!-- Include content for admin home page -->");
        out.println("</div>");
        out.println("</body>");
        out.println("</html>");
    }
}
