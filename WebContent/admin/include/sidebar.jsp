<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    <!-- Sidebar -->
    <ul class="sidebar navbar-nav">
      <!-- <li class="nav-item">
        <a class="nav-link" href="index.jsp">
          <i class="fas fa-fw fa-tachometer-alt"></i>
          <span>Dashboard</span>
        </a>
      </li> -->
      <li class="nav-item dropdown">
        <a class="nav-link dropdown-toggle" href="#" id="pagesDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
          <i class="fas fa-fw fa-folder"></i>
          <span>Member</span>
        </a>
        <div class="dropdown-menu" aria-labelledby="pagesDropdown">
          <h6 class="dropdown-header">Login Screens:</h6>
<%
if(session.getAttribute("USER_ID")==null){
%>
          <a class="dropdown-item" href="login.jsp">Login</a>
          <a class="dropdown-item" href="register.jsp">Register</a>
          <a class="dropdown-item" href="forgot-password.html">Forgot Password</a>
<%} else { %>
		<a class="dropdown-item" href="logout.jsp">Logout</a>
          <a class="dropdown-item" href="memctrl.jsp">회원관리</a>
          <a class="dropdown-item" href="forgot-password.html">Forgot Password</a>
<% } %>
        </div>
      </li>
     <!--  <li class="nav-item">
        <a class="nav-link" href="index.jsp">
          <i class="fas fa-fw fa-chart-area"></i>
          <span>Charts</span></a>
      </li> -->
      <li class="nav-item dropdown">
        <a class="nav-link dropdown-toggle" href="#" id="pagesDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
          <i class="fas fa-fw fa-table"></i>
          <span>Board</span>
        </a>
        <div class="dropdown-menu" aria-labelledby="pagesDropdown">
          
          <a class="dropdown-item" href="board.jsp?btype=0">공지사항</a>
          <a class="dropdown-item" href="board.jsp?btype=1">회원게시판</a>
          <a class="dropdown-item" href="board.jsp?btype=2">사진게시판</a>
          <a class="dropdown-item" href="board.jsp?btype=3">직원게시판</a>
          <a class="dropdown-item" href="board.jsp?btype=4">일정게시판</a>
         </div>
      </li>
    </ul>
