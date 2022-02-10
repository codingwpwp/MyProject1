<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="boardWeb.vo.*" %>
<% Member loginUserAside = (Member)session.getAttribute("loginUser"); %>
<div id="asideWrap">
	<div id="memberdiv">
	<% if(loginUserAside == null){ %>
		<form action="<%=request.getContextPath()%>/login/loginOk.jsp" method="post" id="memberlogin">
			<input type="text" id="id" name="id" placeholder="아이디"><br>
			<input type="password" id="pw" name="pw" placeholder="비밀번호">
			<input type="submit" id="login"value="로그인"><br>
		</form>
		<a href="<%=request.getContextPath()%>/join/join.jsp">회원가입</a>
	<% } else if(loginUserAside.getPosition().equals("운영자")){ %>
		<div id="memberNickname"><%=loginUserAside.getNickname()%></div>
			<div id="memberPosition">
				&nbsp;<a href="#">회원정보 관리</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="#">자유게시판 관리</a></div>
			<button id="masterlogout" onclick="location.href='<%=request.getContextPath()%>/login/logout.jsp'">로그아웃</button>
	<% } else { %>
		<div id="memberNickname"><%=loginUserAside.getNickname()%></div>
		<div id="memberPosition"><%=loginUserAside.getPosition()%></div>
		<button class="button mypage" onclick="location.href='<%=request.getContextPath()%>/manager/user_manager.jsp'">마이페이지</button>
		<button class="button logout" onclick="location.href='<%=request.getContextPath()%>/login/logout.jsp'">로그아웃</button>
	<%}%>
	</div>
	<div id="ad"><a href="#">광고</a></div>
</div>