<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="boardWeb.util.*"%>
<%@ page import="boardWeb.vo.*"%>
<%
	MainGul maingul = new MainGul();
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>개인프로젝트</title>
	<link rel="shortcut icon" type="image/x-icon" href="<%=request.getContextPath()%>/image/mylogo.ico">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/header.css">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/nav.css">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/main_section_mainWrap.css">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/section_asideWrap.css">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/footer.css">
	<script src ="<%=request.getContextPath()%>/js/jquery-3.6.0.min.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/js/section_mainWrap.js"></script>
</head>
<body>
	<%@include file="/header.jsp" %>
	<%@include file="/nav.jsp" %>
	<section style="margin-top: 10px;">
		<div id="mainWrap">
			<h2>메인페이지</h2><br>
			<div id="tables">
				<div class="table" id="tableone">
					<span>필독공지</span>
					<table style="margin-top: 3px;">
						<thead>
							<tr>
								<th>공지사항</th>
								<th>날짜</th>
							</tr>
						</thead>
						<tbody>
						<%if(maingul.noticeList != null){for(Gul g : maingul.noticeList){%>
							<tr>
								<td class="col1">
									<a class="admina" href="<%=request.getContextPath()%>/board/board_view.jsp?lidx=1&bidx=<%=g.getBidx()%>&writesortnum=0&nowPage=1&searchType=&searchValue=">
									<%if(g.getSubject().length() > 9){%>
										<%=g.getSubject().substring(0, 9)%>...
									<%}else{%>
										<%=g.getSubject()%>
									<%}%>
									</a>
								</td>
								<td class="col2" style="color: red; font-weight: bold;"><%=g.getWriteday()%></td>
							</tr>
						<%}}%>
						</tbody>
					</table>
				</div>
				<div class="table" id="tabletwo">
					<span>최근 자게글</span>
					<table style="margin-top: 3px;">
						<thead>
							<tr>
								<th>제목</th>
								<th>조회수</th>
							</tr>
						</thead>
						<tbody>
						<%if(maingul.jauList != null){for(Gul g : maingul.jauList){%>
							<tr>
								<td class="col1">
									<a href="<%=request.getContextPath()%>/board/board_view.jsp?lidx=1&bidx=<%=g.getBidx()%>&writesortnum=0&nowPage=1&searchType=&searchValue=">
									<%if(g.getSubject().length() > 9){%>
										<%=g.getSubject().substring(0, 9)%>...
									<%}else{%>
										<%=g.getSubject()%>
									<%}%>
									</a>
								</td>
								<td class="col2"><%=g.getHit()%></td>
							</tr>
						<%}}%>
						</tbody>
					</table>
				</div>
				<div class="table" id="tablethree">
					<span>커뮤통합조회수TOP5</span>
					<table style="margin-top: 3px;">
						<thead>
							<tr>
								<th>제목</th>
								<th>커뮤</th>
								<th>조회</th>
							</tr>
						</thead>
						<tbody>
						<%if(maingul.commuhitList != null){for(Gul g : maingul.commuhitList){%>
							<tr>
								<td class="col1">
									<a href="<%=request.getContextPath()%>/board/board_view.jsp?lidx=<%=g.getLidx()%>&bidx=<%=g.getBidx()%>&writesortnum=0&nowPage=1&searchType=&searchValue=">
									<%if(g.getSubject().length() > 9){%>
										<%=g.getSubject().substring(0, 9)%>...
									<%}else{%>
										<%=g.getSubject()%>
									<%}%>
									</a>
								</td>
								<td class="col2"><%=g.getListtitle()%></td>
								<td class="col3"><%=g.getHit()%></td>
							</tr>
						<%}}%>
						</tbody>
					</table>
				</div>
				<div class="table" id="tablefour">
					<span>커뮤통합추천수TOP5</span>
					<table style="margin-top: 3px;">
						<thead>
							<tr>
								<th>제목</th>
								<th>커뮤</th>
								<th>추천</th>
							</tr>
						</thead>
						<tbody>
						<%if(maingul.commuthumbList != null){for(Gul g : maingul.commuthumbList){%>
							<tr>
								<td class="col1">
									<a href="<%=request.getContextPath()%>/board/board_view.jsp?lidx=<%=g.getLidx()%>&bidx=<%=g.getBidx()%>&writesortnum=0&nowPage=1&searchType=&searchValue=">
									<%if(g.getSubject().length() > 9){%>
										<%=g.getSubject().substring(0, 9)%>...
									<%}else{%>
										<%=g.getSubject()%><%}%>
									</a>
								</td>
								<td class="col2"><%=g.getListtitle()%></td>
								<td class="col3"><%=g.getThumb()%></td>
							</tr>
						<%}}%>
						</tbody>
					</table>
				</div>
			</div>
		</div>
		<%@include file="/section_asideWrap.jsp" %>
	</section>
	<%@include file="/footer.jsp" %>
</body>
</html>