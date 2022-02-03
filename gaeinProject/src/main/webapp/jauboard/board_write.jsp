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
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/board_write_section_mainWrap.css">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/section_asideWrap.css">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/footer.css">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/summernote/summernote-lite.css">
	<script src ="<%=request.getContextPath()%>/js/jquery-3.6.0.min.js"></script>
	<script src ="<%=request.getContextPath()%>/js/board_write_section_mainWrap.js"></script>
	<script src="<%=request.getContextPath()%>/summernote/summernote-lite.js"></script>
	<script src="<%=request.getContextPath()%>/summernote/summernote-ko-KR.js"></script>
</head>
<body>
	<%@include file="/header.jsp" %>
	<%@include file="/nav.jsp" %>
	<section style="margin-top: 10px;">
		<div id="mainWrap">
			<h2>자유게시판 - 등록</h2>
			<form method="post" action="#" onsubmit = "return gulWrite()">
			<%if(loginUser.getPosition().equals("운영자")){%>
				<label>
					<input type="radio" name="malhead" value="notice" onchange="changeGul(this)">공지
				</label>
			<%}%>
				<label>
					<input type="radio" name="malhead" value="normal" checked onchange="changeGul(this)">일반
				</label>
				<label>
					<input type="radio" name="malhead" value="qna" onchange="changeGul(this)">질문
				</label>
			<%if(!loginUser.getPosition().equals("운영자")){%>
				<label>
					<input type="radio" name="malhead" value="commuapply" onchange="changeGul(this)">커뮤신청
				</label>
			<%}%>
				<div id="submenu">
					<button type="submit">완료</button>
					<button type="button" onclick="location.href='<%=request.getContextPath()%>/jauboard/boardList.jsp'">취소</button>
				</div>
				<div id="gulTitle">
					<div style="margin-top:10px">
						<span>제목</span>
						<input type="text" id="gulSubject" name="subject" maxlength="25">
					</div>
				</div>
				<div id="gul">
					<textarea id="summernote" name="editordata"></textarea>
					<div id="commuform">
						<span style="color:red; font-size:small;">*현재 카테고리에서 변경할 경우 기존에 입력한 내용들은 지워집니다.</span>
						<div>
							<span>커뮤이름 : </span>
							<input type="text" id="cTitle" name="commuTitle" maxlength="6" placeholder="2 ~ 4자리의 한글 + 커뮤" onkeyup="this.value=this.value.replace(/[^가-힇]/g,'');">&nbsp;
							ex) ○○커뮤
						</div>
						<div>
							<span>소개글 : </span>
							<textarea name="commuIntroduce" maxlength="30"
							placeholder="커뮤니티의 소개글입니다. 30자 이내의 한 줄문장으로 입력하세요."></textarea>
						</div>
						<div>
							<div><span>말머리 : </span></div>
							<div id="commumalhead">
								<input type="text" name="commuNotice" value="공지" readonly>
								<span style="color: red; font-size: small;">*필수</span>
								<br>
								<input type="text" name="commumalhead2" placeholder="4자이내" maxlength="4">
								<img src="<%=request.getContextPath()%>/image/plus.png" width="10" onclick="commumalPlus()">&nbsp;
								<img src="<%=request.getContextPath()%>/image/minus.png" width="10" onclick="commumalMinus()">
								<br>
							</div>
						</div>
						<div>
							<span>사유 : &nbsp;&nbsp;</span>
							<textarea name="commuReason" maxlength="100"
							placeholder="성심성의것 작성해주시기 바랍니다."></textarea>
						</div>
						<input type="hidden" name="commumlaheadCnt" value="2">
					</div>
				</div>
			</form>
		</div>
		<%@include file="/section_asideWrap.jsp" %>
	</section>
	<%@include file="/footer.jsp" %>
</body>
</html>