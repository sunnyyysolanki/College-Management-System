
<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" ng-app="myApp">
<head>
   <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Courses</title>
    <link rel="stylesheet" href="CSS/style.css">
    <link rel="stylesheet" href="CSS/AdminCourses.css">
    <!--=============== REMIXICONS ===============-->
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
