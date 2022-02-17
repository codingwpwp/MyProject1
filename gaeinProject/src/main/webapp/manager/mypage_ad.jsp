<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="boardWeb.vo.*" %>
<%@ page import="boardWeb.util.*" %>
<%
	Member loginUser = (Member)session.getAttribute("loginUser");
	Member loginUserManager = null;
	AdManager ads = null;
	if(loginUser != null){
		loginUserManager = new Member(loginUser.getMidx());
		ads = new AdManager(loginUser.getMidx());
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
<body onload="noBack();" onpageshow="if(event.persisted) noBack();" onunload="">
	<script type="text/javascript">
		 window.history.forward();
		 function noBack(){window.history.forward();}
	</script>
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
			<%if(ads.adSw == 0){%>
				<div id="admanager1">
					<h3 id="adinsert">광고 등록 <span id="adinsertspan">(투자한 포인트만큼 광고 노출의 확률이 올라갑니다.)</span></h3>
					<form action="mypage_adupload.jsp" method="post" enctype="multipart/form-data" onsubmit = "return adcheck()">
						<span id="adper">예상 노출 확률 : <span id="persent">0%</span></span><br>
						<input type="text" name="point" id="point" placeholder="투자할 포인트" onkeyup="pointnumFn(this); pointcheckFn();" maxlength="6">pt<br>
						<input type="text" name="link" id="link" placeholder="이동할 링크(등록시 링크&이미지 수정 불가)"><br>
						<input type="file" name="adimage" accept="image/gif, image/jpeg, image/png" id="adimage"> <input type="submit" value="광고등록완료!">
						<div id="imagediv"><span id="adsize">268 x 340</span><img style="width: 268px; height: 340px; background-color: white" id="preview-image"></div>
					</form>
				</div>
			<%}else if(ads.adSw == 1){%>
				<div id="admanager2">
					<h3 id="adre">광고 재투자</h3>
						투자한 포인트 : <%=ads.point%>pt<br>
						현재 노출 확률 : <span id="currpersent"><%=ads.persent%>%</span><br><br>
						<img style="width: 268px; height: 340px; background-color: white; border: 1px solid;" id="current-image" src="<%=request.getContextPath()%>/upload/<%=ads.filename%>"><br>
						등록한 링크 : <input type="text" id="adlink" name="adlink" value="<%=ads.link%>" disabled><br>
						<span>예상 노출 확률 : <span id="persent"><%=ads.persent%>%</span></span><br>
						추가 포인트 : <input type="text" id="morepoint" name="morepoint" value="" onkeyup="pointnumFn(this); pointcheckFn2(this);" maxlength="6">
						<button id="morebutton" onclick="morepointFn()">투자!</button><br>
					<button id="addelete" onclick="deleteadFn()">광고 내리기</button>
				</div>
			<%}%>
			<button id="backback" onclick="location.href='<%=request.getContextPath()%>/manager/mypage.jsp'">뒤로가기</button>
			</div>
		</div>
	<%}%>
		<%@include file="/section_asideWrap.jsp" %>
	</section>
	<%@include file="/footer.jsp" %>
	<script type="text/javascript">
		if(document.getElementById("adimage") != null){
			const inputImage = document.getElementById("adimage");
			inputImage.addEventListener("change", e => {
				readImage(e.target)
			});
		}
		
		function readImage(input){
			if(input.files && input.files[0]){
				const reader = new FileReader();
				reader.onload = e => {
					const previewImage = document.getElementById("preview-image");
					previewImage.src = e.target.result
				}
				reader.readAsDataURL(input.files[0])
			}
		}
		
		function pointnumFn(obj){
			obj.value=obj.value.replace(/[^0-9]/g,'');
		}
		
		function pointcheckFn(){
			var point = $("#point").val();
			if(point != ""){
				$.ajax({
					url : "mypage_ad_checkper.jsp",
					type : "post",
					data : "point=" + point,
					success : function(data){
						var per = data.trim();
						$("#persent").html(per + "%");
					}
				});
			}else{
				$("#persent").html("0%");
			}
		}
		
		function adcheck(){
			var flag = true;
			var point = $("#point").val();
			var link = $("#link").val();
			var limitpoint = <%=loginUser.getPoint()%>;
			var urlreg = /(http(s)?:\/\/)([a-z0-9\w]+\.*)+[a-z0-9]{2,4}/gi;
			var imgval = $("#adimage").val();
			
			if(point == "" || point <= 0){
				flag = false;
			}else if(point > limitpoint){
				flag = false;
			}else if(link == ""){
				flag = false;
			}else if(!urlreg.test(link)){
				flag = false;
			}else if(imgval == null || imgval == ""){
				flag = false;
			}
			
			var imgvalArr = imgval.split(".");
			var ext = imgvalArr[imgvalArr.length-1];
			
			
			if(!(ext == "jpg" || ext == "png" || ext == "gif")){
				flag = false;
			}
			
			if(flag == true){
				alert("광고를 등록했습니다");
			}else{
				alert("포인트 or 링크 or 이미지 오류");
			}
			return flag;
		}
		
		function pointcheckFn2(obj){
			var curr = $("#currpersent").html();
			var point = $(obj).val();
			if(point != ""){
				$.ajax({
					url : "mypage_ad_checkper2.jsp",
					type : "post",
					data : "point=" + point,
					success : function(data){
						var per = data.trim();
						$("#persent").html(per + "%");
					}
				});
			}else{
				$("#persent").html(curr);
			}
		}
		
		function morepointFn(){
			var point = $("input[name='morepoint']").val();
			var limitpoint = <%=loginUser.getPoint()%>;
			if(point != ""){
				if(point <= limitpoint){
					
					if(confirm("재투자 하시겠습니까?")){
						$.ajax({
							url : "mypage_adpointmore.jsp",
							type : "post",
							data : "point=" + point,
							success : function(){
								alert("재투자 완료");
								location.href="<%=request.getContextPath()%>/manager/mypage.jsp";
							}
						});
					}
					
				}else{
					alert("가진포인트보다 많이 투자했습니다");
				}
			}else{
				alert("포인트를 입력하고 투자하세요");
			}
		}
		
		function deleteadFn(){
			if(confirm("등록한 광고를 내리겠습니까?\n(투자한 포인트는 반환되지 않습니다)")){
				$.ajax({
					url : "mypage_addelete.jsp",
					type : "post",
					data : "point=" + point,
					success : function(){
						alert("내리기 완료");
						location.href="<%=request.getContextPath()%>/manager/mypage.jsp";
					}
				});
			}
		}
		
	</script>
</body>
</html>