<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="boardWeb.vo.*"%>
<%
	Member loginUser = (Member)session.getAttribute("loginUser");
	
	request.setCharacterEncoding("UTF-8");
	
	int lidx = Integer.parseInt(request.getParameter("lidx"));
	
	ListFilter list = new ListFilter(lidx, "manager");
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>개인프로젝트</title>
	<link rel="shortcut icon" type="image/x-icon" href="<%=request.getContextPath()%>/image/mylogo.ico">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/header.css">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/nav.css">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/commuManager_section_mainWrap.css">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/section_asideWrap.css">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/footer.css">
	<script src ="<%=request.getContextPath()%>/js/jquery-3.6.0.min.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/js/commu_manager.js"></script>
</head>
<body>
	<%@include file="/header.jsp" %>
	<%@include file="/nav.jsp" %>
	<section style="margin-top: 10px;">
	<script>
		<%if(loginUser == null){%>
			location.href="/gaeinProject/index.jsp";
		<%}else if(list.listmastermidx != loginUser.getMidx()){%>
			location.href="/gaeinProject/index.jsp";
		<%}%>
	</script>
		<div id="mainWrap">
			<h2><%=list.listtitle%> 관리</h2>
			<div id="commuManager">
				<input type="hidden" name="midx" value="<%=loginUser.getMidx()%>">
				<%if(lidx != 1 && lidx != 2){%>
				<div id="titlechange">
					<span>커뮤니티 이름 변경</span><br>
					<input type="text" name="commutitle" value="<%=list.listtitle%>" disabled="disabled" maxlength="6" placeholder="2 ~ 4자리의 한글 + 커뮤">
					<input type="button" value="변경하기" onclick="titlechange(this)">
				</div>
				<div id="introchange">
					<span>소개글 변경</span><br>
					<textarea name="commuintroduce" maxlength="30" placeholder="30자 이내의 한 줄문장으로 입력하세요" disabled="disabled"><%=list.listintroduce%></textarea>
					<input type="button" value="변경하기"  onclick="introchange(this)">
				</div>
				<div id="malheadManager">
					<span>카테고리 변경</span>
					<div id="malhead">
						<table>
							<tbody>
								<tr>
									<td class="col1"><span>공지</span></td>
									<td class="col2"><span style="color: red;">*필수</span></td>
								</tr>
								<tr>
									<td class="col1"><span><input name="writesort" value="<%=list.writesort2%>" maxlength="4" placeholder="4자이내" disabled="disabled"></span><input type="hidden" name="num" value="2"></td>
									<td class="col2"><input type="button" value="변경" onclick="malheadchange(this)"></td>
								</tr>
							<%if(list.writesort3 != null){%>
								<tr>
									<td class="col1"><span><input name="writesort" value="<%=list.writesort3%>" maxlength="4" placeholder="4자이내" disabled="disabled"></span><input type="hidden" name="num" value="3"></td>
									<td class="col2"><input type="button" value="변경" onclick="malheadchange(this)"></td>
								</tr>
							<%}%>
							<%if(list.writesort4 != null){%>	
								<tr>
									<td class="col1"><span><input name="writesort" value="<%=list.writesort4%>" maxlength="4" placeholder="4자이내" disabled="disabled"></span><input type="hidden" name="num" value="4"></td>
									<td class="col2"><input type="button" value="변경" onclick="malheadchange(this)"></td>
								</tr>
							<%}%>
							<%if(list.writesort5 != null){%>	
								<tr>
									<td class="col1"><span><input name="writesort" value="<%=list.writesort5%>" maxlength="4" placeholder="4자이내" disabled="disabled"></span><input type="hidden" name="num" value="5"></td>
									<td class="col2"><input type="button" value="변경" onclick="malheadchange(this)"></td>
								</tr>
							<%}%>
							</tbody>
						</table>
					</div>
				</div>
				<%}%>
				<div id="delyn">
					<span>삭제된 글 목록</span><img src="<%=request.getContextPath()%>/image/plus2.png" width="15" style="cursor: pointer;" onclick="showhide(this)">
					<form action="<%=request.getContextPath()%>/manager/commu_manager_delynisy.jsp" method="post" onsubmit = "return changedelyn()">
						<div id="tableWrap">
							<input type="hidden" name="lidx" value="<%=lidx%>">
							<table id="delyntable">
								<thead>
									<tr>
										<th class="col1">카테고리</th>
										<th class="col2">제목</th>
										<th class="col3">닉네임</th>
										<th class="col4">작성일</th>
										<th class="col5">
											<input type="submit" id="delyisn" disabled="disabled" value="복구" style="font-size: 10px;">
											<input type="button" id="allcheck" disabled="disabled" value="전부" style="font-size: 10px;" onclick="allcheckFn()">
										</th>
									</tr>
								</thead>
								<tbody>
								<%for(Gul g : list.gulList){%>
									<tr>
										<td class="col1"><%=g.getWritesort()%></td>
										<td class="col2"><%if(g.getSubject().length() > 15){%><%=g.getSubject().substring(0, 15)%>...<%}else{%><%=g.getSubject()%><%}%></td>
										<td class="col3"><%=g.getNickname()%></td>
										<td class="col4"><%=g.getWriteday()%></td>
										<td class="col5"><input type="checkbox" name="list" value="<%=g.getBidx()%>"></td>
									</tr>
								<%}%>
								</tbody>
							</table>
						</div>
					</form>
				</div>
			</div>
		</div>
		<%@include file="/section_asideWrap.jsp" %>
	</section>
	<%@include file="/footer.jsp" %>
</body>
</html>