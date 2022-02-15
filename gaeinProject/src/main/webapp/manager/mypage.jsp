<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	Member loginUser = (Member)session.getAttribute("loginUser");
	Member loginUserManager = null;
	ListFilter list = null;
	if(loginUser != null){
		loginUserManager = new Member(loginUser.getMidx());
		list = new ListFilter(loginUser.getMidx());
	}
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>개인프로젝트</title>
	<link rel="shortcut icon" type="image/x-icon" href="<%=request.getContextPath()%>/image/mylogo.ico">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/header.css">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/nav.css">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/mypage_section_mainWrap.css">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/section_asideWrap.css">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/footer.css">
	<script src ="<%=request.getContextPath()%>/js/jquery-3.6.0.min.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/js/mypage.js"></script>
</head>
<body>
	<%@include file="/header.jsp" %>
	<%@include file="/nav.jsp" %>
	<section style="margin-top: 10px;">
	<script>
		<%if(loginUser == null){%>
			alert("로그인 후 이용하세요");
			location.href="/gaeinProject/index.jsp";
		<%}%>
	</script>
	<%if(loginUserManager != null){%>
		<div id="mainWrap">
			<h2>마이페이지</h2>
			<div id="mypage">
				<div id="information">
					<h3>회원정보 변경 <span id="memo">(아이디와 이름은 변경할 수 없습니다)</span> <button onclick="changeInfo()">변경하기</button><span>가입일 : <%=loginUserManager.getJoinday()%></span></h3>
					<table>
						<tr id="row1">
							<td class="col1">아이디</td>
							<td class="col2"><input type="text" class="nomodify" name="id" value="<%=loginUserManager.getId()%>" disabled></td>
							<td class="col3">비밀번호</td>
							<td class="col4"><input type="password" name="pw" placeholder="8~20자리의 영문 + 숫자 + 특문"></td>
						</tr>
						<tr id="row2">
							<td class="col1">이름</td>
							<td class="col2"><input type="text" class="nomodify" name="name" value="<%=loginUserManager.getName()%>" disabled></td>
							<td class="col3">닉네임</td>
							<td class="col4"><input type="text" name="nickname" value="<%=loginUserManager.getNickname()%>" placeholder="2 ~ 6자리의 한글 또는 숫자"></td>
						</tr>
						<tr id="row3">
							<td class="col1">이메일</td>
							<td class="col2"><input type="email" name="email" value="<%if(loginUserManager.getEmail() != null){ out.print(loginUserManager.getEmail()); }%>"></td>
							<td class="col3">성별</td>
							<td class="col4">
								<label>
									<input type="radio" name="gender" value="M" <%if(loginUserManager.getGender() != null && loginUserManager.getGender().equals("M")){ out.print("checked"); }%>> 남
								</label>
								<label>
									<input type="radio" name="gender" value="F" <%if(loginUserManager.getGender() != null && loginUserManager.getGender().equals("F")){ out.print("checked"); }%>> 여
								</label>
							</td>
						</tr>
					</table>
				</div>
				<div id="gulList">
					<h3>작성한 글 목록 <img onclick="showgul(this)" src="<%=request.getContextPath()%>/image/plus2.png" width="13"></h3>
					<div id="gulgul">
						<table>
							<thead>
								<tr>
									<th class="col1">종류</th>
									<th class="col2">카테고리</th>
									<th class="col3">제목</th>
									<th class="col4">작성일</th>
								</tr>
							</thead>
							<tbody>
							<%for(Gul g : list.gulList){%>
								<tr>
									<td class="col1"><%=g.getListtitle()%></td>
									<td class="col2"><%=g.getWritesort()%></td>
									<td class="col3">
										<a href="<%=request.getContextPath()%>/board/board_view.jsp?lidx=<%=g.getLidx()%>&bidx=<%=g.getBidx()%>&writesortnum=0&nowPage=1">
										<%if(g.getSubject().length() > 17){%><%=g.getSubject().substring(0, 17)%>...<%}else{%><%=g.getSubject()%><%}%>
										</a>
									</td>
									<td class="col4"><%=g.getWriteday()%></td>
								</tr>
							<%}%>
							</tbody>
						</table>
					</div>
				</div>
				<button onclick="deleteInfo()">탈퇴하기</button>
			</div>
		</div>
	<%}%>
		<%@include file="/section_asideWrap.jsp" %>
	</section>
	<%@include file="/footer.jsp" %>
</body>
</html>