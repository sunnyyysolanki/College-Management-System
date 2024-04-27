<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>View Subject Asign</title>
    <link rel="stylesheet" href="CSS/style.css">	
  </head>
  </head>
<style>

    
    body,
    input,
    button {
      font-family: var(--body-font);
      font-size: var(--normal-font-size);
    }
    
    body {
      background-color: var(--body-color);
      color: var(--text-color);
      background-color: #f2f2f2;
                margin: 0;
                padding: 0;
    }
    
    input,
    button {
      border: none;
      outline: none;
    }
    
    ul {
      list-style: none;
    }
    
    a {
      text-decoration: none;
    }
    
    img {
      display: block;
      max-width: 100%;
      height: auto;
    }
    
    /*=============== REUSABLE CSS CLASSES ===============*/
    .container {
      max-width: 100%;
      margin-inline: 3rem;
       margin: 10px auto; 
    }
    
    .main {
      position: relative;
      height: 100vh;
    }
    
    .main__bg {
      position: absolute;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
      object-fit: cover;
      object-position: center;
      z-index: -1;
    }
    
    
    
    /*=============== HEADER & NAV ===============*/
    .header {
      position: fixed;
      top: 0;
      left: 0;
      width: 100%;
      background-color: var(--body-color);
      box-shadow: 0 2px 16px hsla(230, 75%, 32%, .15);
      z-index: var(--z-fixed);
    }
    
    .nav {
      /*height: var(--header-height); */
      height:9vh;
      display: flex;
      justify-content: space-between;
      align-items: center;
    }
    
    .nav__logo {
      color: var(--title-color);
      font-weight: var(--font-semi-bold);
      transition: color .4s;
    }
    
    
            h2 {
                text-align: center;
            }
    
          form {
               margin: 0px auto;
            width: 30%;
            padding: 20px;
            margin-top: 100px;
            background-color: #fff;
            border-radius: 20px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            align-items: center;
            text-align: center;
    }
    
            label {
                font-weight: bold;
            }
    
            select, input[type="submit"] {
                width: 200px;
                padding: 5px;
                margin: 5px;
                border-radius: 5px;
            }
    
            table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 20px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            }
    
            table, th, td {
                border: 1px solid #dddddd;
            }
    
            th, td {
                padding: 8px;
                text-align: left;
            }
    
            tr:nth-child(even) {
                background-color: #f2f2f2;
            }
    
            .search {
            width: quto;
            padding: 5px;
            border-radius: 5px;
            background-color: #fff;
            /* border: 1px solid #ccc; */
            box-sizing: border-box;
            }
    
            .row {
                margin-bottom: 10px;
            }
            
            
            .IU{
            border: 1px solid #ccc;
                  border-radius: 5px;
                  padding:5px 10px;
                  cursor: pointer;
                  transition: all 0.3s ease;
                  box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);	
            }
            
            .box{
                 border: 1px solid #ccc;
                  border-radius: 5px;
                  cursor: pointer;
                  transition: all 0.3s ease;
                  box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);	
            }
            .container {
			  max-width: 100%;
			  margin-inline: 3rem;
			  /* margin: 10px auto; */
			}
            </style>
  <body>
    <%

                Connection conn = null;
                Statement stmt = null;
                ResultSet rs = null;

                try {
                    Class.forName("com.mysql.jdbc.Driver");
                    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/AdminDb", "root", "Yash@297");
                    stmt = conn.createStatement();	
                    String query = "SELECT * FROM asign_subject ORDER BY faculty_id";
                    
                    rs = stmt.executeQuery(query);
%>
                  
<h2>Faculty Subject Asign</h2>  
<div class="container">
    <table  style="width: 100%; border-collapse: collapse; margin-top: 20px; box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);">
      <tr>
        <th>Faculty ID</th>
        <th>SUBJECT CODE</th>
        <th>SUBJECT ID</th>
        <th>subject Name</th>
      </tr>
      <% while (rs.next()) {%>
          <tr>
            <td><%= rs.getString("faculty_id") %></td>
            <td><%= rs.getString("subject_code") %></td>
            <td><%= rs.getString("subject_id") %></td>
            <td><%= rs.getString("subject_name") %></td>
      
         <% } %>
     
    </table>
    </div>
    <%
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            // Close resources
            try { if (rs != null) rs.close(); } catch (SQLException e) { e.printStackTrace(); }
            try { if (stmt != null) stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            try { if (conn != null) conn.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
%>
    
  </body>
</html>