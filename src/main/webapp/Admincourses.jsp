
<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" ng-app="myApp">
<head>
   <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Courses</title>
    <link rel="stylesheet" href="CSS/style.css">
    <!--=============== REMIXICONS ===============-->
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
  /* margin: 10px auto; */
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




}

.container {
  display: flex;
  justify-content: center;
  }

        h2 {
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


    .detail_container {
        background-color: #fff; /* Set container background color */
        padding: 20px; /* Add padding for better spacing */
        border-radius: 10px; /* Add border radius for rounded corners */
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1); /* Add box shadow for depth */
        margin: 150px auto 0;
        margin-inline:5rem;
    }

    table {
        font-family: Arial, sans-serif;
        border-collapse: collapse;
        width: 100%;
    }

    th, td {
        border: 1px solid #dddddd;
        text-align: left;
        padding: 8px;
    }

    th {
        background-color: #f2f2f2; /* Set header background color */
    }

    .search {
        width: quto;
        padding: 8px;
        border-radius: 5px;
        border: 1px solid #ccc;
        box-sizing: border-box;
    }
    
    </style>
</head>
<body>

<!--==================== HEADER ====================-->
    <header class="header" id="header">
      <nav class="nav container">
         <a href="#" class="nav__logo">Indus University</a>

         <div class="nav__menu" id="nav-menu">
            <ul class="nav__list">
               <li class="nav__item">
                  <span>Indus Institute of Technology And Engineering</span>
               </li>
            </ul>
          </div>
           
      </nav>
   </header>  


<div class="detail_container" ng-controller="myCtrl">
  
  <br/>
  <table>
      <tr>
          <th>Index NO.</th>
          <th>Course Code</th>
          <th>Course Name</th>
          <th>Subjects</th>
          <th>Students</th>
          <th>Total Semester/Year</th>
      </tr>
      <tr ng-repeat="course in people | filter: table">
          <td>{{course.index}}</td>
          <td>{{course.code}}</td>
          <td>{{course.name}}</td>
          <td>{{course.subjects}}</td>
          <td>{{course.students}}</td>
          <td>{{course.sem}}</td>
      </tr>
  </table>
 
</div>

<script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.4.8/angular.min.js"></script>
<script src="https://angular-ui.github.io/bootstrap/ui-bootstrap-tpls-0.3.0.min.js"></script>
<script>
  var app = angular.module('myApp', ['ui.bootstrap']);
  app.controller('myCtrl', function($scope) {
      
      $scope.currentPage = 1;
      $scope.numPerPage = 5;
    

      $scope.numPages = function () {
          return Math.ceil($scope.course.length / $scope.numPerPage);
      };

      $scope.$watch('currentPage + numPerPage', function() {
          var begin = (($scope.currentPage - 1) * $scope.numPerPage),
              end = begin + $scope.numPerPage;

          $scope.people = $scope.course.slice(begin, end);
      });
      
      // Initialize AngularJS data with JSP data
      $scope.course = [
          <% 
          Connection conn = null;
          Statement stmt = null;
          ResultSet rs = null;

          try {
              // Connect to the database
              Class.forName("com.mysql.jdbc.Driver");
              conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/AdminDb", "root", "Yash@297");

              // Execute a query
              stmt = conn.createStatement();
              rs = stmt.executeQuery("SELECT * FROM Courses");

              // Display data
              while (rs.next()) {
                  out.println("{");
                  out.println("\"index\": \"" + rs.getString("id") + "\",");
                  out.println("\"code\": \"" + rs.getString("Course_Code") + "\",");
                  out.println("\"name\": \"" + rs.getString("Course_Name") + "\",");
                  out.println("\"subjects\": \"" + rs.getString("subjects") + "\",");
                  out.println("\"students\": \"" + rs.getString("students") + "\",");
                  out.println("\"sem\": \"" + rs.getString("Total_sem") + "\"");
                  out.println("},");
              }

          } catch (Exception e) {
              e.printStackTrace();
          } finally {
              // Close resources
              try {
                  if (rs != null) rs.close();
                  if (stmt != null) stmt.close();
                  if (conn != null) conn.close();
              } catch (SQLException e) {
                  e.printStackTrace();
              }
          }
          %>
      ];
  });
</script>


</body>
</html>
