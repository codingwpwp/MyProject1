<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="boardWeb.vo.*" %>
<%@ page import="boardWeb.util.*" %>
<%
	Member loginUser = (Member)session.getAttribute("loginUser");
	Connection c = null;
	PreparedStatement p = null;
	ResultSet r = null;
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
			<div id="adminpage2">
				<div id="commuList">
					<h3>전체 커뮤니티 관리</h3>
					<div id="commutable">
				<%
					try{
						c = DBManager.getConnection();
						String s = "SELECT listtitle, lidx, delyn FROM assaboardlist WHERE lidx > 2";
						p = c.prepareStatement(s);
						r = p.executeQuery();
				%>
						<table>
							<thead>
								<tr>
									<th class="col1">커뮤니티</th>
									<th class="col3">삭제여부</th>
								</tr>
							</thead>
							<tbody>
							<%while(r.next()){%>
								<tr>
									<td class="col1"><a href="<%=request.getContextPath()%>/manager/adminpage2_commu.jsp?lidx=<%=r.getInt("lidx")%>"><%=r.getString("listtitle")%></a></td>
									<td class="col2"><%=r.getString("delyn")%></td>
								</tr>
							<%}%>
							</tbody>
						</table>
					<%
						}catch(Exception e){
							e.printStackTrace();
						}finally{
							DBManager.close(c, p, r);
						}
					%>
					</div>
				</div><br>
				<div id="adminadad">
					<a href="<%=request.getContextPath()%>/manager/adminpage2_ad.jsp"><h3>광고 관리</h3></a>
				</div>
			</div>
		</div>
	<%}%>
		<%@include file="/section_asideWrap.jsp" %>
	</section>
	<%@include file="/footer.jsp" %>
</body>
</html>