<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="boardWeb.vo.*" %>
<%
	Member loginUser = (Member)session.getAttribute("loginUser");
	
	Members members = new Members();
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>개인프로젝트</title>
	<link rel="shortcut icon" type="image/x-icon" href="<%=request.getContextPath()%>/image/mylogo.ico">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/header.css">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/nav.css">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/admin_section_mainWrap.css">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/section_asideWrap.css">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/footer.css">
	<script src ="<%=request.getContextPath()%>/js/jquery-3.6.0.min.js"></script>
</head>
<body>
	<%@include file="/header.jsp" %>
	<%@include file="/nav.jsp" %>
	<section style="margin-top: 10px;">
		<div id="mainWrap">
			<h2>운영자페이지</h2>
				<div id="adminpage">
					<div id="userList">
						<h3>회원정보 관리</h3>
						<div id="usertable">
							<table>
								<thead>
									<tr>
										<th class="col1">회원번호</th>
										<th class="col2">아이디</th>
										<th class="col3">이름</th>
										<th class="col4">권한</th>
										<th class="col5">가입날짜</th>
										<th class="col6">탈퇴여부</th>
									</tr>
								</thead>
								<tbody>
								<%for(Member m : members.memberList){%>
									<tr>
										<td class="col1"><%=m.getMidx()%></td>
										<td class="col2"><a href="<%=request.getContextPath()%>/manager/adminpage_user.jsp?midx=<%=m.getMidx()%>"><%=m.getId()%></a></td>
										<td class="col3"><%=m.getName()%></td>
										<td class="col4"><%=m.getPosition()%></td>
										<td class="col5"><%=m.getJoinday()%></td>
										<td class="col6"><%=m.getDelyn()%></td>
									</tr>
								<%}%>
								</tbody>
							</table>
						</div>
					</div>
				</div>
		</div>
		<%@include file="/section_asideWrap.jsp" %>
	</section>
	<%@include file="/footer.jsp" %>
</body>
</html>