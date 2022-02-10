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
						<%if(maingul.noticeList != null){for(IndexNotice i : maingul.noticeList){%>
							<tr>
								<td class="col1">
									<a href="<%=request.getContextPath()%>/board/board_view.jsp?lidx=1&bidx=<%=i.getBidx()%>&writesortnum=0&nowPage=1&searchType=&searchValue="><%if(i.getSubject().length() > 9){%><%=i.getSubject().substring(0, 9)%>...<%}else{%><%=i.getSubject()%><%}%></a>
								</td>
								<td class="col2"><%=i.getWriteday()%></td>
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
						<%if(maingul.jauList != null){for(IndexGul ij : maingul.jauList){%>
							<tr>
								<td class="col1"><a href="<%=request.getContextPath()%>/board/board_view.jsp?lidx=1&bidx=<%=ij.getBidx()%>&writesortnum=0&nowPage=1&searchType=&searchValue="><%if(ij.getSubject().length() > 9){%><%=ij.getSubject().substring(0, 9)%>...<%}else{%><%=ij.getSubject()%><%}%></a></td>
								<td class="col2"><%=ij.getHit()%></td>
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
						<%if(maingul.commuhitList != null){for(IndexGul ch : maingul.commuhitList){%>
							<tr>
								<td class="col1"><a href="<%=request.getContextPath()%>/board/board_view.jsp?lidx=<%=ch.getLidx()%>&bidx=<%=ch.getBidx()%>&writesortnum=0&nowPage=1&searchType=&searchValue="><%if(ch.getSubject().length() > 9){%><%=ch.getSubject().substring(0, 9)%>...<%}else{%><%=ch.getSubject()%><%}%></a></td>
								<td class="col2"><%=ch.getCommutitle()%></td>
								<td class="col3"><%=ch.getHit()%></td>
							</tr>
						<%}}%>
						</tbody>
					</table>
				</div>
				<div class="table" id="tablefour">
					<span>커뮤통합인싸글TOP5</span>
					<table style="margin-top: 3px;">
						<thead>
							<tr>
								<th>제목</th>
								<th>커뮤</th>
								<th>추천</th>
							</tr>
						</thead>
						<tbody>
						<%if(maingul.commuthumbList != null){for(IndexGul ct : maingul.commuthumbList){%>
							<tr>
								<td class="col1"><a href="<%=request.getContextPath()%>/board/board_view.jsp?lidx=<%=ct.getLidx()%>&bidx=<%=ct.getBidx()%>&writesortnum=0&nowPage=1&searchType=&searchValue="><%if(ct.getSubject().length() > 9){%><%=ct.getSubject().substring(0, 9)%>...<%}else{%><%=ct.getSubject()%><%}%></a></td>
								<td class="col2"><%=ct.getCommutitle()%></td>
								<td class="col3"><%=ct.getThumb()%></td>
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