<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% Member loginUser = (Member)session.getAttribute("loginUser"); %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>개인프로젝트</title>
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/header.css">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/nav.css">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/commuMain_section_mainWrap.css">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/section_asideWrap.css">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/footer.css">
	<script src ="<%=request.getContextPath()%>/js/jquery-3.6.0.min.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/js/.js"></script>
</head>
<body>
	<%@include file="/header.jsp" %>
	<%@include file="/nav.jsp" %>
	<section style="margin-top: 10px;">
		<div id="mainWrap">
			<h2>커뮤니티</h2>
			<span>여러 커뮤니티들이 모여있습니다.</span><br>
			<div id="malhead">
				<span>전체</span>|<a href="#">코딩</a>|<a href="#">축구</a>|<a href="#">헬스</a>|<a href="#">구인</a>
			</div>
			<form id="search">
				<select name="searchType">
					<option value="subject" selected>제목</option>
					<option value="writer">작성자</option>
					<option value="content">내용</option>
				</select>
				<input type="text" name="searchValue" placeholder="내용을 입력하세요">
				<input type="submit" value="검색">
			</form>
			<div class="board">
				<table id="jauboard">
					<thead>
						<tr>
							<th>번호</th>
							<th>카테고리</th>
							<th>제목</th>
							<th>글쓴이</th>
							<th>작성일</th>
							<th>조회</th>
							<th>추천</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td class="col1">10</td>
							<td class="col2">축구</td>
							<td class="col3"><a href="#">공지사항맨이다</a></td>
							<td class="col4">운영자</td>
							<td class="col5">2022-01-01</td>
							<td class="col6">999999</td>
							<td class="col7">999999</td>
						</tr>
						<tr>
							<td class="col1">10</td>
							<td class="col2">코딩</td>
							<td class="col3"><a href="#">공지사항맨이다</a></td>
							<td class="col4">운영자</td>
							<td class="col5">2022-01-01</td>
							<td class="col6">999999</td>
							<td class="col7">999999</td>
						</tr>
						<tr>
							<td class="col1">10</td>
							<td class="col2">헬스</td>
							<td class="col3"><a href="#">공지사항맨이다</a></td>
							<td class="col4">운영자</td>
							<td class="col5">2022-01-01</td>
							<td class="col6">999999</td>
							<td class="col7">999999</td>
						</tr>
						<tr>
							<td class="col1">10</td>
							<td class="col2">구인</td>
							<td class="col3"><a href="#">공지사항맨이다</a></td>
							<td class="col4">운영자</td>
							<td class="col5">2022-01-01</td>
							<td class="col6">999999</td>
							<td class="col7">999999</td>
						</tr>
						<tr>
							<td class="col1">10</td>
							<td class="col2">축구</td>
							<td class="col3"><a href="#">공지사항맨이다</a></td>
							<td class="col4">운영자</td>
							<td class="col5">2022-01-01</td>
							<td class="col6">999999</td>
							<td class="col7">999999</td>
						</tr>
						<tr>
							<td class="col1">10</td>
							<td class="col2">버거킹</td>
							<td class="col3"><a href="#">공지사항맨이다</a></td>
							<td class="col4">운영자</td>
							<td class="col5">2022-01-01</td>
							<td class="col6">999999</td>
							<td class="col7">999999</td>
						</tr>
						<tr>
							<td class="col1">10</td>
							<td class="col2">코딩</td>
							<td class="col3"><a href="#">공지사항맨이다</a></td>
							<td class="col4">운영자</td>
							<td class="col5">2022-01-01</td>
							<td class="col6">999999</td>
							<td class="col7">999999</td>
						</tr>
						<tr>
							<td class="col1">10</td>
							<td class="col2">코딩</td>
							<td class="col3"><a href="#">공지사항맨이다</a></td>
							<td class="col4">운영자</td>
							<td class="col5">2022-01-01</td>
							<td class="col6">999999</td>
							<td class="col7">999999</td>
						</tr>
						<tr>
							<td class="col1">10</td>
							<td class="col2">구인</td>
							<td class="col3"><a href="#">공지사항맨이다</a></td>
							<td class="col4">운영자</td>
							<td class="col5">2022-01-01</td>
							<td class="col6">999999</td>
							<td class="col7">999999</td>
						</tr>
						<tr>
							<td class="col1">10</td>
							<td class="col2">버거킹</td>
							<td class="col3"><a href="#">공지사항맨이다</a></td>
							<td class="col4">운영자</td>
							<td class="col5">2022-01-01</td>
							<td class="col6">999999</td>
							<td class="col7">999999</td>
						</tr>
					</tbody>
				</table>
				<div id="tableBottom">
					<div id="button">
				<%if(loginUser != null){%>
					<button onclick="location.href=''">등록</button>
				<%} %>
					</div>
					<div id="paging">
						<div>&lt;</div>
						<div>1</div>
						<div>2</div>
						<div>3</div>
						<div>4</div>
						<div>5</div>
						<div>6</div>
						<div>&gt;</div>
					</div>
					<div id="commu">
							
					</div>
				</div>
			</div>
		</div>
		<%@include file="/section_asideWrap.jsp" %>
	</section>
	<%@include file="/footer.jsp" %>
</body>
</html>