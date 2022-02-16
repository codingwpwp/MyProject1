<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="boardWeb.vo.*" %>
<%@ page import="boardWeb.util.*" %>
<%
	Member loginUser = (Member)session.getAttribute("loginUser");
	
	request.setCharacterEncoding("UTF-8");

	int lidx = Integer.parseInt(request.getParameter("lidx"));	// 게시판 번호
	
	ListFilter list = new ListFilter(lidx, "info");
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>개인프로젝트</title>
	<link rel="shortcut icon" type="image/x-icon" href="<%=request.getContextPath()%>/image/mylogo.ico">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/header.css">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/nav.css">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/admin_section_mainWrap2.css">
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
				<h3>커뮤니티 정보 <button onclick="location.href='<%=request.getContextPath()%>/manager/adminpage2.jsp'">뒤로</button></h3>
				<ul id="commuinfo">
					<li>커뮤니티 이름 : <%=list.listtitle%></li>
					<li>개설일 : <%=list.listday%></li>
					<li>커뮤장 : <%=list.m.getNickname()%><%if(list.m.getNickname().equals("운영자")){%>(임시)<%}%></li>
					<li>
						카테고리
						<ol>
							<li><%=list.writesort1%></li>
							<li><%=list.writesort2%></li>
					<%if(list.writesort3 != null){%>
							<li><%=list.writesort3%></li>
					<%}%>
					<%if(list.writesort4 != null){%>
							<li><%=list.writesort4%></li>
					<%}%>
					<%if(list.writesort5 != null){%>
							<li><%=list.writesort5%></li>
					<%}%>
						</ol>
					</li>
					<li>24시간동안 올라온 글 갯수 : <span><%=list.cnt%></span>개</li>
				</ul>
				<div id="commubutton">
					<button onclick="commudelete(this)">커뮤니티 <%if(list.delyn.equals("N")){%>해체<%}else{%>복구<%}%></button>
					<button onclick="commujangchange(this)">커뮤장 위임</button>
				</div>
			</div>
		</div>
	<%}%>
		<%@include file="/section_asideWrap.jsp" %>
	</section>
	<%@include file="/footer.jsp" %>
	<script type="text/javascript">
		function commudelete(obj){
			var delyn = $(obj).html();
			if(delyn == "커뮤니티 해체"){
				console.log(3);
				if(confirm("해체 하시겠습니까?")){
					$.ajax({
						url : "adminpage2_commu_delete.jsp",
						type : "post",
						data : "lidx=" + <%=lidx%> + "&listmastermidx=" + <%=list.listmastermidx%>,
						success : function(){
							alert('해체되었습니다');
							location.href="/gaeinProject/manager/adminpage2_commu.jsp?lidx=" + <%=lidx%>;
						}
					});
				}
			}else{
				
				
				var commujangmidx = -1;
				if(confirm("복구 하시겠습니까?")){
					
					
					var commujang = prompt("커뮤장으로 임명할 아이디를 정확히 입력하세요");
					
					if(commujang != null){
						commujang = commujang.trim();
					}
					
					if(commujang != null && commujang != false && commujang != undefined && undefined != "" && undefined != "undefined" && undefined != "null"){
						
						$.ajax({
							url : "adminpage2_commu_deleteno.jsp",
							type : "post",
							data : "id=" + commujang + "&check=Y",
							success : function(data){
								var midx = Number(data.trim());
								if(midx != -1){
									
									commujangmidx = midx;
									
									$.ajax({
										url : "adminpage2_commu_deleteno.jsp",
										type : "post",
										data : "midx=" + commujangmidx + "&check=N&listtitle=<%=list.listtitle%>" + "&lidx=" + <%=lidx%>,
										success : function(){
											alert("변경되었습니다");
											location.href="/gaeinProject/manager/adminpage2_commu.jsp?lidx=" + <%=lidx%>;
										}
									});
									
								}else{
									alert("존재하지 않는 회원이거나 커뮤장을 맡고있는 회원입니다");
								}
							}
						});
						
					}else{
						alert("제대로 입력하세요");
					}
					
					
				}
				
				
			}
		}
		
		function commujangchange(obj){
			if($(obj).prev().html() == "커뮤니티 복구"){
				 alert("해체된 커뮤니티는 위임할 수 없습니다");
			}else{
				
				
				if(confirm("복구 하시겠습니까?")){
					
					
					var commujang = prompt("커뮤장으로 임명할 아이디를 정확히 입력하세요");
					
					if(commujang != null){
						commujang = commujang.trim();
					}
					
					if(commujang != null && commujang != false && commujang != undefined && undefined != "" && undefined != "undefined" && undefined != "null"){
						
						$.ajax({
							url : "adminpage2_commu_deleteno.jsp",
							type : "post",
							data : "id=" + commujang + "&check=Y",
							success : function(data){
								var midx = Number(data.trim());
								if(midx != -1){
									commujangmidx = midx;
									
									$.ajax({
										url : "adminpage2_commu_change.jsp",
										type : "post",
										data : "midx=" + commujangmidx + "&beforemidx=" + <%=list.listmastermidx%> + "&listtitle=<%=list.listtitle%>" + "&lidx=" + <%=lidx%>,
										success : function(){
											alert("변경되었습니다");
											location.href="/gaeinProject/manager/adminpage2_commu.jsp?lidx=" + <%=lidx%>;
										}
									});
									
								}else{
									alert("존재하지 않는 회원이거나 커뮤장을 맡고있는 회원입니다");
								}
							}
						});
						
					}else{
						alert("제대로 입력하세요");
					}
					
					
				}
				
				
			}
			
		}
	
	
	
	
	
	
	
	
	</script>
</body>
</html>