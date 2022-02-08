<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="boardWeb.vo.*" %>
<%
	Member loginUser = (Member)session.getAttribute("loginUser");

	request.setCharacterEncoding("UTF-8");
	
	int lidx = Integer.parseInt(request.getParameter("lidx"));	// 게시판 번호
	
	int writesortnum =  Integer.parseInt(request.getParameter("writesortnum"));	// 카테고리 또는 말머리
	
	String searchType = request.getParameter("searchType");		// 검색 종류
	if(searchType == null) searchType = "";
	
	String searchValue = request.getParameter("searchValue");	// 검색 값
	if(searchValue == null) searchValue = "";
	
	String nowPage = request.getParameter("nowPage");			// 페이지
	int realnowPage = 1;
	if(nowPage != null) realnowPage = Integer.parseInt(nowPage);
	
	ListFilter list = new ListFilter(lidx, writesortnum, realnowPage, searchType, searchValue);
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>개인프로젝트</title>
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/header.css">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/nav.css">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/board_list_section_mainWrap.css">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/section_asideWrap.css">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/footer.css">
	<script src ="<%=request.getContextPath()%>/js/jquery-3.6.0.min.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/js/section_mainWrap.js"></script>
</head>
<body>
	<%@include file="/header.jsp" %>
	<%@include file="/nav.jsp" %>
	<section style="margin-top: 10px;">
		<div id="mainWrap">
			<h2><%=list.listtitle%></h2>
			<span><%=list.listintroduce%> <%if(lidx == 1){%><span style="color: orangered;">공지를 꼭 읽어주시길 바랍니다.</span></span><br><%}%>
			<div id="malhead">
			<%if(writesortnum == 0){
				%><span>전체</span>|<%
			}else{%><a href="<%=request.getContextPath()%>/board/board_list.jsp?lidx=<%=lidx%>&writesortnum=0">전체</a>|<%}
			if(writesortnum == 1){
				%><span><%=list.writesort1%></span>|<%
			}else{%><a href="<%=request.getContextPath()%>/board/board_list.jsp?lidx=<%=lidx%>&writesortnum=1"><%=list.writesort1%></a>|<%}
			if(writesortnum == 2){
				%><span><%=list.writesort2%></span>|<%
			}else{%><a href="<%=request.getContextPath()%>/board/board_list.jsp?lidx=<%=lidx%>&writesortnum=2"><%=list.writesort2%></a><%if(list.writesort3 != null){%>|<%}}
			if(list.writesort3 != null){
				if(writesortnum == 3){
				%><span><%=list.writesort3%></span>|
				<%}else{%><a href="<%=request.getContextPath()%>/board/board_list.jsp?lidx=<%=lidx%>&writesortnum=3"><%=list.writesort3%></a><%if(list.writesort4 != null){%>|<%}}
			}
			if(list.writesort4 != null){
				if(writesortnum == 4){
				%><span><%=list.writesort4%></span>|
				<%}else{%><a href="<%=request.getContextPath()%>/board/board_list.jsp?lidx=<%=lidx%>&writesortnum=4"><%=list.writesort4%></a><%if(list.writesort5 != null){%>|<%}}
			}
			if(list.writesort5 != null){
				if(writesortnum == 5){
				%><span><%=list.writesort5%></span>
				<%}else{%><a href="<%=request.getContextPath()%>/board/board_list.jsp?lidx=<%=lidx%>&writesortnum=5"><%=list.writesort5%></a><%}
			}%>
			</div>
			<form id="search" action="<%=request.getContextPath()%>/board/board_list.jsp?lidx=<%=lidx%>&writesortnum=<%=writesortnum%>&searchType=<%=searchType%>&searchValue=<%=searchValue%>">
				<input type="hidden" name="lidx" value="<%=lidx%>">
				<input type="hidden" name="writesortnum" value="<%=writesortnum%>">
				<select name="searchType">
					<option value="subject" <%if(searchType != null && searchType.equals("subject")) out.print("selected"); %>>제목</option>
					<option value="nickname" <%if(searchType != null && searchType.equals("nickname")) out.print("selected"); %>>닉네임</option>
					<option value="content" <%if(searchType != null && searchType.equals("content")) out.print("selected"); %>>내용</option>
				</select>
				<input type="text" name="searchValue" placeholder="11자 이내로 검색하세요" maxlength="10" <%if(searchValue != null && !searchValue.equals("") && !searchValue.equals("null")) out.print("value='" + searchValue + "'");%>>
				<input type="submit" value="검색">
			</form>
			<div class="board">
				<table id="jauboard" class="boardlist">
					<thead>
						<tr>
							<th>번호</th>
							<th>카테고리</th>
							<th>제목</th>
							<th>닉네임</th>
							<th>작성일</th>
							<th>조회</th><%
if(lidx != 1 && lidx != 2){%><th>추천</th><%}%>
						</tr>
					</thead>
					<tbody>
					<%for(Gul g : list.gulList){%>
						<tr>
							<td class="col1"><%=g.getNum()%></td>
							<td class="col2"><%=g.getWritesort()%></td>
							<td class="col3"><a href="<%=request.getContextPath()%>/board/board_view.jsp?lidx=<%=lidx%>&bidx=<%=g.getBidx()%>&writesortnum=<%=writesortnum%>&nowPage=<%=realnowPage%>&searchType=<%=searchType%>&searchValue=<%=searchValue%>">
							<%if(g.getSubject().length() > 17){
								%><%=g.getSubject().substring(0, 17)%>...<%
							}else{%><%=g.getSubject()%><%}%></a>
							</td>
							<td class="col4"
								<%if(g.getPosition().equals("운영자")){%>
									style="font-weight:bold; color: red;"
								<%}else if(!g.getPosition().equals("일반")){%>
									style="color: blue;"
								<%}%>>
								<%if(g.getPosition().equals("운영자")){%>
								<img alt="웃는개구리" src="<%=request.getContextPath()%>/image/smilefrog.jpg" width="28" style="position: relative; top: 1px;"><span style="position: relative; bottom: 8px;">
								<%}else{%><span><%}%><%=g.getNickname()%></span>
							</td>
							<td class="col5"><%=g.getWriteday()%></td>
							<td class="col6"><%=g.getHit()%></td>
							<%if(lidx != 1 && lidx != 2){%>
							<td class="col7"><%=g.getThumb()%></td>
							<%}%>
						</tr>
					<%}%>
					</tbody>
				</table>
				<div id="tableBottom">
					<div id="button">
				<%if(loginUser != null){%>
					<button onclick="location.href='<%=request.getContextPath()%>/board/board_write.jsp?lidx=<%=lidx%>&writesortnum=<%=writesortnum%>&nowPage=<%=realnowPage%>&searchType=<%=searchType%>&searchValue=<%=searchValue%>'">등록</button>
				<%}%>
					</div>
					<div id="paging">
						<div<%if(list.paging.getStartPage() == 1){%>
							style="visibility: hidden;"
						<%}%>><a href="'<%=request.getContextPath()%>/board/board_list.jsp?lidx=<%=lidx%>&writesortnum=<%=writesortnum%>&nowPage=<%=list.paging.getStartPage() - 1%>&searchType=<%=searchType%>&searchValue=<%=searchValue%>'">&lt;</a>
						</div>
						<%for(int i = list.paging.getStartPage(); i <= list.paging.getEndPage(); i++){%>
							<%if(i == list.paging.getNowPage()){%>
							<div id="nowPage" style="cursor:default; background-color: deepskyblue;"><%=i %></div>
							<%}else{%>
							<a href="<%=request.getContextPath()%>/jauboard/board_list.jsp?writesortnum=<%=writesortnum%>&nowPage=<%=i%>&searchType=<%=searchType%>&searchValue=<%=searchValue%>"><div><%=i %></div></a>
							<%}
				  		}%>
						<div<%if(list.paging.getEndPage() == list.paging.getLastPage()){%>
							style="visibility: hidden;"
						<%}%>><a href="'<%=request.getContextPath()%>/board/board_list.jsp?lidx=<%=lidx%>&writesortnum=<%=writesortnum%>&nowPage=<%=list.paging.getEndPage() + 1%>&searchType=<%=searchType%>&searchValue=<%=searchValue%>'">&gt;</a>
						</div>
					</div>
					<div id="commu">
					<%if((loginUser != null) && (list.listmastermidx == loginUser.getMidx()) && lidx != 1 && lidx != 2){%>
						<button>커뮤니티관리</button>					
					<%}%>	
					</div>
				</div>
			</div>
		</div>
		<%@include file="/section_asideWrap.jsp" %>
	</section>
	<%@include file="/footer.jsp" %>
</body>
</html>