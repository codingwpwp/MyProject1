<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>개인프로젝트</title>
	<link rel="shortcut icon" type="image/x-icon" href="<%=request.getContextPath()%>/image/mylogo.ico">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/header.css">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/nav.css">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/joinWrap.css">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/footer.css">
	<script src ="<%=request.getContextPath()%>/js/jquery-3.6.0.min.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/js/joinWrap.js"></script>
</head>
<body onload="noBack();" onpageshow="if(event.persisted) noBack();" onunload="">
	<script type="text/javascript">
		 window.history.forward();
		 function noBack(){window.history.forward();}
	</script>
	<%@include file="/header.jsp" %>
	<%@include file="/nav.jsp" %>
	<section style="margin-top: 10px;">
		<div id="joinWrap">
			<form method="post" action="<%=request.getContextPath()%>/join/joinOk.jsp" id="join" onsubmit = "return joincheck()">
				<h2>회원가입</h2>
				<span style="font-size: small;">*필수</span><br>
				<div id="memberid">
					<span>*</span>아이디
					<span class="checkspan"></span>
					<button type="button" onclick="idcheckFn()"><span>*</span>중복확인</button><br>
					<input type="text" class="impor" name="id" id="id" placeholder="8 ~ 20자리의 영문 + 숫자" onblur="idcheckFn2(this)">
				</div>
				<div id="memberpw">
					<span>*</span>비밀번호
					<span class="checkspan"></span><br>
					<input type="password" class="impor" name="pw" id="pw" placeholder="8 ~ 20자리의 영문 + 숫자 + 특수문자">
				</div>
				<div id="memberpwre">
					<span>*</span>비밀번호 확인
					<span class="checkspan"></span><br>
					<input type="password" class="impor" name="pwre" id="pwre" placeholder="비밀번호를 재입력하세요">
				</div>
				<div id="name">
					<span>*</span>이름
					<span class="checkspan"></span><br>
					<input type="text" class="impor" name="name" id="name" placeholder="2 ~ 5자리의 한글">
				</div>
				<div id="membernickname">
					<span style="color: #2980b9; font-size: small;">닉네임은 본인을 대표합니다</span><br>
					<span>*</span>닉네임
					<span class="checkspan"></span>
					<button type="button" onclick="nicknamecheckFn()"><span>*</span>중복확인</button><br>
					<input type="text" class="impor" name="nickname" id="nickname" placeholder="2 ~ 6자리의 한글 또는 숫자" onblur="nicknamecheckFn2(this)">
				</div>
				
				<div id="membergender">
					성별<br>
					<label>
						<input type="radio" name="gender" value="M">남
					</label>
					<label>
						<input type="radio" name="gender" value="F">여
					</label>
				</div>
				<div id="memberemail">
					이메일<br>
					<input type="email" name="email">
				</div>
				<div>
					<input type="submit" value="가입완료">
					<button type="button" onclick="location.href='<%=request.getContextPath()%>/index.jsp'">취소</button>
				</div>
			</form>
		</div>
	</section>
	<%@include file="/footer.jsp" %>
</body>
</html>