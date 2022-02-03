<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
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
							<tr>
								<td class="col1"><a href="#">공시사항123</a></td>
								<td class="col2">2022-01-01</td>
							</tr>
							<tr>
								<td class="col1"><a href="#">공지사항234</a></td>
								<td class="col2">2022-01-01</td>
							</tr>
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
							<tr>
								<td class="col1"><a href="#">자게글1</a></td>
								<td class="col2">3252</td>
							</tr>
							<tr>
								<td class="col1"><a href="#">자게글1</a></td>
								<td class="col2">3252</td>
							</tr>
							<tr>
								<td class="col1"><a href="#">자게글1</a></td>
								<td class="col2">3252</td>
							</tr>
							<tr>
								<td class="col1"><a href="#">자게글1</a></td>
								<td class="col2">3252</td>
							</tr>
							<tr>
								<td class="col1"><a href="#">자게글1</a></td>
								<td class="col2">3252</td>
							</tr>
						</tbody>
					</table>
				</div>
				<div class="table" id="tablethree">
					<span>커뮤통합조회수TOP5</span>
					<table style="margin-top: 3px;">
						<thead>
							<tr>
								<th>제목</th>
								<th>조회수</th>
								<th>추천수</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td class="col1"><a href="#">자게글1</a></td>
								<td class="col2">3252</td>
								<td class="col3">32532</td>
							</tr>
							<tr>
								<td class="col1"><a href="#">자게글1</a></td>
								<td class="col2">3252</td>
								<td class="col3">32532</td>
							</tr>
							<tr>
								<td class="col1"><a href="#">자게글1</a></td>
								<td class="col2">3252</td>
								<td class="col3">32532</td>
							</tr>
							<tr>
								<td class="col1"><a href="#">자게글1</a></td>
								<td class="col2">3252</td>
								<td class="col3">32532</td>
							</tr>
							<tr>
								<td class="col1"><a href="#">자게글1</a></td>
								<td class="col2">3252</td>
								<td class="col3">32532</td>
							</tr>
						</tbody>
					</table>
				</div>
				<div class="table" id="tablefour">
					<span>커뮤통합인싸글TOP5</span>
					<table style="margin-top: 3px;">
						<thead>
							<tr>
								<th>제목</th>
								<th>조회수</th>
								<th>추천수</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td class="col1"><a href="#">자게글1</a></td>
								<td class="col2">3252</td>
								<td class="col3">32532</td>
							</tr>
							<tr>
								<td class="col1"><a href="#">자게글1</a></td>
								<td class="col2">3252</td>
								<td class="col3">32532</td>
							</tr>
							<tr>
								<td class="col1"><a href="#">자게글1</a></td>
								<td class="col2">3252</td>
								<td class="col3">32532</td>
							</tr>
							<tr>
								<td class="col1"><a href="#">자게글1</a></td>
								<td class="col2">3252</td>
								<td class="col3">32532</td>
							</tr>
							<tr>
								<td class="col1"><a href="#">자게글1</a></td>
								<td class="col2">3252</td>
								<td class="col3">32532</td>
							</tr>
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