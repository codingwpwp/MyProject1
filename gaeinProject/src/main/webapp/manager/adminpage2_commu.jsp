<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="boardWeb.vo.*" %>
<%@ page import="boardWeb.util.*" %>
<%
	Member loginUser = (Member)session.getAttribute("loginUser");
	
	request.setCharacterEncoding("UTF-8");

	int lidx = Integer.parseInt(request.getParameter("lidx"));	// 게시판 번호
	
	ListFilter list = new ListFilter(lidx, "info");
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>개인프로젝트</title>
	<link rel="shortcut icon" type="image/x-icon" href="<%=request.getContextPath()%>/image/mylogo.ico">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/header.css">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/nav.css">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/admin_section_mainWrap2.css">
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
				<div id="commuList">
					<h3>커뮤니티 정보</h3>
					<div id="commutable">
						커뮤니티 이름 : <%=list.listtitle%><br>
						개설일자 : <%=list.listday%><br>
						커뮤장 : <%=list.m.getNickname()%><br>
						카테고리
						<table border="1">
							<tr>
								<td><%=list.writesort1%></td>
							</tr>
							<tr>
								<td><%=list.writesort2%></td>
							</tr>
						<%if(list.writesort3 != null){%>
							<tr>
								<td><%=list.writesort3%></td>
							</tr>
						<%}%>
						<%if(list.writesort4 != null){%>
							<tr>
								<td><%=list.writesort4%></td>
							</tr>
						<%}%>
						<%if(list.writesort5 != null){%>
							<tr>
								<td><%=list.writesort5%></td>
							</tr>
						<%}%>
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