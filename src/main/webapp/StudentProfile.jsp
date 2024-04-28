
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.java.UsernameUtility" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css"/>
    <!--=============== REMIXICONS ===============-->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/remixicon/3.5.0/remixicon.css">

<title>Student Detail</title>
<style>
    
/*=========================header css==============================*/
    /*=============== GOOGLE FONTS ===============*/
@import url("https://fonts.googleapis.com/css2?family=Syne:wght@400;500;600&display=swap");

/*=============== VARIABLES CSS ===============*/
:root {
  --header-height: 3.5rem;

  /*========== Colors ==========*/
  /*Color mode HSL(hue, saturation, lightness)*/
  --first-color: hsl(230, 75%, 56%);
  --title-color: hsl(230, 75%, 15%);
  --text-color: hsl(230, 12%, 40%);
  --body-color: hsl(230, 100%, 98%);
  --container-color: hsl(230, 100%, 97%);
  --border-color: hsl(230, 25%, 80%);

  /*========== Font and typography ==========*/
  /*.5rem = 8px | 1rem = 16px ...*/
  --body-font: "Syne", sans-serif;
  --h2-font-size: 1.25rem;
  --normal-font-size: .938rem;

  /*========== Font weight ==========*/
  --font-regular: 400;
  --font-medium: 500;
  --font-semi-bold: 600;

  /*========== z index ==========*/
  --z-fixed: 100;
  --z-modal: 1000;
}

/*========== Responsive typography ==========*/
@media screen and (min-width: 1023px) {
  :root {
    --h2-font-size: 1.5rem;
    --normal-font-size: 1rem;
  }
}

/*=============== BASE ===============*/
/* * {
  box-sizing: border-box;
  padding: 0;
  margin: 0; rrrrrrrrrrrrrrrrrrr
} */

html {
  scroll-behavior: smooth;
}

body,
input,
button {
  font-family: var(--body-font);
  font-size: var(--normal-font-size);
}

body {
  background-color: var(--body-color);
  color: var(--text-color);
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
  max-width: 1120px;
  margin-inline: 1.5rem;
}

.main {
  position: relative;
  height: 100vh;
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
  height: var(--header-height);
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.nav__logo {
  color: var(--title-color);
  font-weight: var(--font-semi-bold);
  transition: color .4s;
}



:is(.nav__logo, .nav__search, .nav__login, .nav__toggle, .nav__link):hover {
  color: var(--first-color);
}

/* Navigation for mobile devices */
@media screen and (max-width: 1023px) {
  .nav__menu {
    position: fixed;
    top: -100%;
    left: 0;
    background-color: var(--body-color);
    box-shadow: 0 8px 16px hsla(230, 75%, 32%, .15);
    width: 100%;
    padding-block: 4.5rem 4rem;
    transition: top .4s;
  }
}

.nav__list {
  display: flex;
  flex-direction: column;
  row-gap: 2.5rem;
  text-align: center;
}

.nav__link {
  color: var(--title-color);
  font-weight: var(--font-semi-bold);
  transition: color .4s;
}





/*=============== BREAKPOINTS ===============*/
/* For medium devices */
@media screen and (min-width: 576px) {
  .search,
  .login {
    padding-top: 10rem;
  }

  .search__form {
    max-width: 450px;
    margin-inline: auto;
  }

  .search__close,
  .login__close {
    width: max-content;
    top: 5rem;
    left: 0;
    right: 0;
    margin-inline: auto;
    font-size: 2rem;
  }

  .login__form {
    max-width: 400px;
    margin-inline: auto;
  }
}

/* For large devices */
@media screen and (min-width: 1023px) {
  .nav {
    height: calc(var(--header-height) + 2rem);
    column-gap: 3rem;
  }
  .nav__close, 
  .nav__toggle {
    display: none;
  }
  .nav__menu {
    margin-left: auto;
  }
  .nav__list {
    flex-direction: row;
    column-gap: 3rem;
  }

  .login__form {
    padding: 3rem 2rem 3.5rem;
  }
}

@media screen and (min-width: 1150px) {
  .container {
    margin-inline: auto;
  }
}
/*========================profile css===================================*/
    /* body {
        font-family: Arial, sans-serif;
        background-color: #f5f7ff;
        margin: 0;
        padding: 0;
    } */

    .profile_container {
        margin-top: 150px;
        margin-left: 350px;
        display: flex;
        flex-wrap: wrap; /* Adjusted for responsiveness */
        justify-content: space-between;
        align-items: flex-start;
        height: 100%;
        padding: 20px;
    }
    .image{
      height: 200px;
    }

    /* .sidebar {
        width: 0;
        height: 100%;
        background-color: #007bff;
        color: #fff;
        padding: 20px;
        overflow-x: hidden;
        transition: 0.5s;
    }

    .sidebar-content {
        width: 100%;
    }

    .sidebar-content h2 {
        margin-top: 0;
    } */

    .form-container {
        width: 100%;
        margin-bottom: 20px; /* Adjusted for responsiveness */
    }

    .form-container form {
        padding: 20px;
        background-color: #fff;
        border-radius: 8px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    }

    .form-container form label {
        display: block;
        margin-bottom: 10px;
    }
		
	.form-container form input[type="text"]{
      width: 90%;
      padding: 10px;
      margin-bottom: 15px;
      border: 1px solid #ccc;
      border-radius: 5px;
    }
	
    .form-container form select,
    .form-container form input[type="submit"] {
        width: 96%;
        padding: 10px;
        margin-bottom: 15px;
        border: 1px solid #ccc;
        border-radius: 5px;
    }

    .form-container form input[type="submit"] {
        background-color: #007bff;
        color: #fff;
        cursor: pointer;
        transition: background-color 0.3s;
    }

    .form-container form input[type="submit"]:hover {
        background-color: #0056b3;
    }

    .detail-container {
        width: 100%;
        padding: 20px;
        background-color: #f8f9fa;
        border-radius: 8px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    }

    .detail-container h2 {
        margin-top: 0;
        margin-bottom: 20px;
    }

    .detail-container table {
        width: 100%;
        border-collapse: collapse;
    }

    .detail-container table td {
        padding: 10px;
        border-bottom: 1px solid #ccc;
    }

    .detail-container table td:first-child {
        color: #007bff;
        font-weight: bold;
    }

    .detail-container table tr:last-child td {
        border-bottom: none;
    }

    /* Responsive adjustments */
    @media only screen and (min-width: 768px) {
        .profile_container {
            justify-content: space-around;
        }

        .form-container {
            width: 40%;
            margin-bottom: 0;
        }

        .detail-container {
            width: 55%;
        }
    }

    @media only screen and (min-width: 992px) {
        .profile_container {
            justify-content: space-between;
        }

        .form-container {
            width: 30%;
        }

        .detail-container {
            width: 65%;
        }
    }
    /*xxxxxxxxxxxxxxxxxxxxxxxxx btn  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx*/
    /* .edit {
    position: fixed;
    top: 20%;
    left: 30px;
    transform: translateY(-50%);
    z-index: 999;
    background-color: #007bff;
    color: #fff;
    padding: 10px 20px;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    transition: background-color 0.3s;
}

.edit:hover {
    background-color: #0056b3;
} */

.TD{
	color:#007bff;
	font-weight: bold;
}

</style>
</head>
<body>

	
    <!--===================navbar=============== -->
    <header class="header" id="header">
        <nav class="nav container">
           <a href="#" class="nav__logo">Indus University</a>

           <div class="nav__menu" id="nav-menu">
              <ul class="nav__list">
                 <li class="nav__item">
                    <a href="AdminHome.html" class="nav__link">Home</a>
                 </li>

                 <li class="nav__item">
                    <a href="#" class="nav__link">About Us</a>
                 </li>

                 <li class="nav__item">
                    <a href="#" class="nav__link">Services</a>
                 </li>

                 <li class="nav__item">
                    <a href="#" class="nav__link">Featured</a>
                 </li>

                 <li class="nav__item">
                    <a href="#" class="nav__link">Contact Me</a>
                 </li>
              </ul>
           </div>
        </nav>
   </header>
		
		
		<div class="profile_container">
            <div class="detail-container">
        <h2>Student Details</h2>
        
        
        <%
        String username = UsernameUtility.getUsername();
   

                Connection conn = null;
                Statement stmt = null;
                ResultSet rs = null;

                try {
                    Class.forName("com.mysql.jdbc.Driver");
                    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/AdminDb", "root", "Yash@297");
                    stmt = conn.createStatement();	
                    String query = "SELECT * FROM students WHERE id ='"+ username +"'";
                    

                    rs = stmt.executeQuery(query);
                    if (rs.next()) {
        %>
        <table>
            <tr>
                <td><img src="<%= rs.getString("link") %>" alt="img"></td>
                <td>
                    <table border="1">
                        <tr>
                            <td>Roll Number</td>
                            <td><%= rs.getString("id") %></td>
                        </tr>
                        <tr>
                            <td>Student Name</td>
                            <td><%= rs.getString("student_name") %></td>
                        </tr>
                        <tr>
                            <td>Address</td>
                            <td><%= rs.getString("Address") %></td>
                        </tr>
                        <tr>
                            <td>Email ID</td>
                            <td><%= rs.getString("Email_ID") %></td>
                        </tr>
                        <tr>
                            <td>Date Of Birth</td>
                            <td><%= rs.getString("DOB") %></td>
                        </tr>
                        <tr>
                            <td>Contact Number</td>
                            <td><%= rs.getString("Contact_no") %></td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <table border="1">
                    <tr>
                        <td>Course</td>
                        <td><%= rs.getString("Course") %></td>
                        <td class = "TD">Semester</td>
                        <td><%= rs.getString("Semester_year") %></td>
                    </tr>
                    <tr>
                        <td>Admission Date</td>
                        <td><%= rs.getString("admission_date") %></td>
                    </tr>
                </table>
            </tr>
        </table>
        <%
                    } else {
                        out.println("<p>Student not found with ID:</p>");
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    try {
                        if (rs != null) rs.close();
                        if (stmt != null) stmt.close();
                        if (conn != null) conn.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
           
        %>
    </div>
    </div>

<script>
    function toggleSidebar() {
        var sidebar = document.getElementById("sidebar");
        if (sidebar.style.width === "0px" || sidebar.style.width === "") {
            sidebar.style.width = "250px";
        } else {
            sidebar.style.width = "0px";
        }
    }
</script>

</body>
</html>
