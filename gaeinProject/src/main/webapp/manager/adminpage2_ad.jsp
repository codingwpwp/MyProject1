<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="boardWeb.vo.*" %>
<%@ page import="boardWeb.util.*" %>
<%
	Member loginUser = (Member)session.getAttribute("loginUser");
	AdManager ads = new AdManager();
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>개인프로젝트</title>
	<link rel="shortcut icon" type="image/x-icon" href="<%=request.getContextPath()%>/image/mylogo.ico">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/header.css">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/nav.css">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/admin_section_mainWrap3.css">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/section_asideWrap.css">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/footer.css">
	<script src ="<%=request.getContextPath()%>/js/jquery-3.6.0.min.js"></script>
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
		<%}else if(loginUser.getMidx() != 0){%>
			alert("운영자만 이용할수 있습니다");
			location.href="/gaeinProject/index.jsp";
		<%}%>
	</script>
	<%if(loginUser != null){%>
		<div id="mainWrap">
			<h2>운영자페이지</h2>
			<div id="adminpage">
				<div id="aduList">
					<h3>광고 관리</h3>
					<table id="adtable">
					<thead>
						<tr>
							<th class="col1">회원번호</th>
							<th class="col2">닉네임</th>
							<th class="col3">포인트</th>
							<th class="col4">링크</th>
							<th class="col5">이미지</th>
							<th class="col6">관리</th>
							<th class="col7">확률</th>
						</tr>
					</thead>
					<tbody>
				<%for(int i = 0; i < ads.adMembers.size(); i++){%>
						<tr>
							<td class="col1"><%=ads.adMembers.get(i).getMidx()%></td>
							<td class="col2"><a href="<%=request.getContextPath()%>/manager/adminpage_user.jsp?midx=<%=ads.adMembers.get(i).getMidx()%>" onmouseover="backgroundChFn(this)" onmouseout="backgroundChFn2(this)"><%=ads.adMembers.get(i).getNickname()%></a></td>
							<td class="col3"><span id="col3span"><%=ads.adMembers.get(i).getPoint()%></span></td>
							<td class="col4"><%=ads.adMembers.get(i).getLinks()%></td>
							<td class="col5">
								<div>
									<span onmouseover="show(this);" onmouseout="hide(this);">이미지확인</span>
									<ul>
										<li><img width="268" height="340" alt="광고" src="<%=request.getContextPath()%>/upload/<%=ads.adMembers.get(i).getFileRealName()%>"></li>
									</ul>
								</div>
							</td>
							<td class="col6"><%if(i != 0){%><button onclick="deladFn(this);">삭제</button><%}%></td>
							<td class="col7"><span class="col7span"><%=Math.round((((double)ads.adMembers.get(i).getPoint() / ads.totalpoint) * 100) * 100) / 100.0%>%</span></td>
						</tr>
				<%}%>
					</tbody>
					</table>
				</div>
				<button id="back" onclick="location.href='<%=request.getContextPath()%>/manager/adminpage2.jsp'">뒤로</button>
			</div>
		</div>
	<%}%>
		<%@include file="/section_asideWrap.jsp" %>
	</section>
	<%@include file="/footer.jsp" %>
	<script type="text/javascript">
	
		function show(obj){
			$(obj).next().find("img").show();
		}
		
		function hide(obj){
			$(obj).next().find("img").hide();
		}


		function backgroundChFn(obj){
			$(obj).parent().parent().css("background","aliceblue");
		}
		function backgroundChFn2(obj){
			$(obj).parent().parent().css("background","inherit");
		}
		
		function deladFn(obj){
			if(confirm("삭제?")){
				var midx = $(obj).parent().parent().find(".col1").html();
				$.ajax({
					url : "adminpage2_addelete.jsp",
					type : "post",
					data : "midx=" + midx,
					success : function(){
						alert('삭제되었습니다');
						location.href="/gaeinProject/manager/adminpage2_ad.jsp";
					}
				});
			}
		}
	</script>
</body>
</html>