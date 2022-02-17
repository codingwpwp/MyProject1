<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="boardWeb.vo.*" %>
<%
	Member loginUser = (Member)session.getAttribute("loginUser");

	request.setCharacterEncoding("UTF-8");
	
	int midx = Integer.parseInt(request.getParameter("midx"));
	
	Member m = new Member(midx);
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>개인프로젝트</title>
	<link rel="shortcut icon" type="image/x-icon" href="<%=request.getContextPath()%>/image/mylogo.ico">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/header.css">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/nav.css">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/admin_section_mainWrap.css">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/section_asideWrap.css">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/footer.css">
	<script src ="<%=request.getContextPath()%>/js/jquery-3.6.0.min.js"></script>
	<script type="text/javascript">
		function changedel(){
			var delyn = "<%=m.getDelyn()%>";
			var position = "<%=m.getPosition()%>";
			if(delyn == "N"){
				if(position.indexOf("커뮤장") >= 0){
					alert("커뮤장은 탈퇴할 수 없습니다");
				}else{
					if(confirm("탈퇴 처리 하시겠습니까?")){
						$.ajax({
							url : "adminpage_changedelyn.jsp",
							type : "post",
							data : "delyn=" + delyn + "&midx=" + <%=m.getMidx()%>,
							success : function(){
								alert('삭제되었습니다');
								location.href="/gaeinProject/manager/adminpage_user.jsp?midx=" + <%=m.getMidx()%>;
							}
						});
					}
				}
			}else{
				if(confirm("복구 하시겠습니까?")){
					$.ajax({
						url : "adminpage_changedelyn.jsp",
						type : "post",
						data : "delyn=" + delyn + "&midx=" + <%=m.getMidx()%>,
						success : function(){
							alert('복구되었습니다');
							location.href="/gaeinProject/manager/adminpage_user.jsp?midx=" + <%=m.getMidx()%>;
						}
					});
				}
			}
		}
	</script>
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
			<div id="userdetail">
				<div id="userList">
					<h3>
						<span><%=m.getId()%></span> 관리
						<div>
							<button onclick="location.href='<%=request.getContextPath()%>/manager/adminpage.jsp'">뒤로</button>
							<button id="delyn" onclick="changedel()">탈퇴<%if(m.getDelyn().equals("Y")){ out.println("복구"); }else{ out.println("처리"); }%></button>
						</div>
					</h3>
				<div id="user">
					<table>
						<tbody>
							<tr>
								<td class="col1">
									아이디
								</td>
								<td class="col2">
									<input type="text" name="id" value="<%=m.getId()%>" disabled>
								</td>
								<td class="col3">
									비밀번호
								</td>
								<td class="col4">
									<input type="text" name="pw" value="<%=m.getPw()%>" disabled>
								</td>
							</tr>
							<tr>
								<td class="col1">
									이메일
								</td>
								<td class="col2">
									<input type="text" name="email" value="<%if(m.getEmail() != null){out.print(m.getEmail());}%>" disabled>
								</td>
								<td class="col3">
									이름
								</td>
								<td class="col4">
									<input type="text" name="name" value="<%=m.getName()%>" disabled>
								</td>
							</tr>
							<tr>
								<td class="col1">
									닉네임
								</td>
								<td class="col2">
									<input type="text" name="nickname" value="<%=m.getNickname()%>" disabled>
								</td>
								<td class="col3">
									성별
								</td>
								<td class="col4">
									<label>
										<input type="radio" name="gender" value="M" <%if(m.getGender() != null && m.getGender().equals("M")){out.print("checked");}%> disabled> 남
									</label>
									<label>
										<input type="radio" name="gender" value="F" <%if(m.getGender() != null && m.getGender().equals("F")){out.print("checked");}%> disabled> 여
									</label>
								</td>
							</tr>
							<tr>
								<td style="color: #ff0057; font-weight: bold;">포인트</td>
								<td style="font-weight: bold;"><%=m.getPoint()%>pt</td>
							</tr>
						</tbody>
					</table>
					
				</div>
				</div>
			</div>
		</div>
	<%}%>
		<%@include file="/section_asideWrap.jsp" %>
	</section>
	<%@include file="/footer.jsp" %>
</body>
</html>