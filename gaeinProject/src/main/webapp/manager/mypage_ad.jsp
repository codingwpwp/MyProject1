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
			<h2>마이페이지 - 광고 관리</h2>
			<div id="mypage">
				<div id="admanager1">
					<h3 id="adinsert">광고 등록 <span id="adinsertspan">(투자한 포인트만큼 광고 노출의 확률이 올라갑니다.)</span></h3>
					<form action="mypage_adupload.jsp" method="post" enctype="multipart/form-data">
						<span id="adper">예상 노출 확률 : <span>56%</span></span><br>
						<input type="text" name="point" id="point" placeholder="투자할 포인트">pt<br>
						<input type="text" name="link" id="link" placeholder="이동할 링크(등록시 링크&이미지 수정 불가)"><br>
						<input type="file" name="adimage" accept="image/png, image/jpeg" id="adimage"> <input type="submit" value="광고등록완료!">
						<div id="imagediv"><span id="adsize">268 x 340</span><img style="width: 268px; height: 340px; background-color: white" id="preview-image"></div>
					</form>
				</div>
				<div id="admanager2">
					<h3 id="adre">광고 재투자</h3>
						투자한 포인트 : 56pt<br>
						<img style="width: 268px; height: 340px; background-color: white" id="preview-image"><br>
						등록한 링크 : <input type="text" name="adlink" value="naver.com" disabled><br>
						<span>예상 노출 확률 : 56%</span><br>
						추가 포인트 : <input type="text" name="morepoint" value=""><button>투자!</button><br>
					<button>광고 내리기</button>
				</div>
				<button onclick="location.href='<%=request.getContextPath()%>/manager/mypage.jsp'">뒤로가기</button>
			</div>
		</div>
	<%}%>
		<%@include file="/section_asideWrap.jsp" %>
	</section>
	<%@include file="/footer.jsp" %>
	<script type="text/javascript">
		// input file에 change 이벤트 부여
		const inputImage = document.getElementById("adimage")
		inputImage.addEventListener("change", e => {
			readImage(e.target)
		});
		
		function readImage(input) {
			// 인풋 태그에 파일이 있는 경우
			if(input.files && input.files[0]){
				// FileReader 인스턴스 생성
				const reader = new FileReader();
				// 이미지가 로드가 된 경우
				reader.onload = e => {
					const previewImage = document.getElementById("preview-image")
					previewImage.src = e.target.result
				}
				// reader가 이미지 읽도록 하기
				reader.readAsDataURL(input.files[0])
			}
		}
	</script>
</body>
</html>