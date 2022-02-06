<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="boardWeb.vo.*" %>
<%
Member loginUser = (Member)session.getAttribute("loginUser");

	request.setCharacterEncoding("UTF-8");
	String writesort = request.getParameter("writesort");
	if(writesort == null){
		writesort = "all";
	}
	
	String nowPage = request.getParameter("nowPage");
	
	String searchType = request.getParameter("searchType");
	if(searchType == null){
		searchType = "";
	}
	
	String searchValue = request.getParameter("searchValue");
	if(searchValue == null){
		searchValue = "";
	}
	
	int realnowPage = 1;
	if(nowPage != null) realnowPage = Integer.parseInt(nowPage);
	
	ListFilter list = new ListFilter(1, writesort, realnowPage, searchType, searchValue);
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>개인프로젝트</title>
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/header.css">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/nav.css">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/jau_section_mainWrap.css">
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
			<h2>자유게시판</h2>
			<span>자유게시판입니다. <span style="color: orangered;">공지를 꼭 읽어주시길 바랍니다.</span></span><br>
			<div id="malhead">
			<%if(writesort.equals("all")){%><span>전체</span>|<%
			}else{%><a href="<%=request.getContextPath()%>/jauboard/board_list.jsp?writesort=all">전체</a>|<%}
			
			if(writesort != null && writesort.equals("notice")){%><span>공지</span>|<%
			}else{%><a href="<%=request.getContextPath()%>/jauboard/board_list.jsp?writesort=notice">공지</a>|<%}
			
			if(writesort != null && writesort.equals("normal")){%><span>일반</span>|<%
			}else{%><a href="<%=request.getContextPath()%>/jauboard/board_list.jsp?writesort=normal">일반</a>|<%}
			
			if(writesort != null && writesort.equals("qna")){%><span>질문</span>|<%
			}else{%><a href="<%=request.getContextPath()%>/jauboard/board_list.jsp?writesort=qna">질문</a>|<%}
			
			if(writesort != null && writesort.equals("commuapply")){%><span>커뮤신청</span><%
			}else{%><a href="<%=request.getContextPath()%>/jauboard/board_list.jsp?writesort=commuapply">커뮤신청</a><%}%>
			</div>
			<form id="search" action="<%=request.getContextPath()%>/jauboard/board_list.jsp?writesort<%=writesort%>&nowPage=1&searchType=<%=searchType%>&searchValue=<%=searchValue%>">
				<input type="hidden" name="writesort" value="<%=writesort%>">
				<input type="hidden" name="nowPage" value="1">
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
							<th>조회</th>
						</tr>
					</thead>
					<tbody>
					<%
					for(Gul g : list.gulList){
					%><tr>
						<td class="col1"><%=g.getBidx()%></td>
						<td class="col2"><%=g.getWritesort()%></td>
						<td class="col3"><a href="<%=request.getContextPath()%>/jauboard/board_view.jsp?bidx=<%=g.getBidx()%>&writesort=<%=writesort%>&nowPage=<%=realnowPage%>&searchType=<%=searchType%>&searchValue=<%=searchValue%>">
							<%if(g.getSubject().length() > 18){
								%><%=g.getSubject().substring(0, 18)%>...
							<%}else{%><%=g.getSubject()%><%}%></a>
						</td>
						<td class="col4"
						<%if(g.getPosition().equals("운영자")){%>
							style="font-weight:bold; color: red;"
						<%}else if(!g.getPosition().equals("일반")){%>
							style="color: blue;"
						<%}%>><%if(g.getPosition().equals("운영자")){
						%><img alt="웃는개구리" src="<%=request.getContextPath()%>/image/smilefrog.jpg" width="28" style="position: relative; top: 1px;"><span style="position: relative; bottom: 8px;"><%
						}else{%><span>
						<%}%><%=g.getNickname()%></span></td>
						<td class="col5"><%=g.getWriteday()%></td>
						<td class="col6"><%=g.getHit()%></td>
					</tr>
					<%} %>
					</tbody>
				</table>
				<div id="tableBottom">
					<div id="button">
				<%if(loginUser != null){%>
					<button onclick="location.href='<%=request.getContextPath()%>/jauboard/board_write.jsp?writesort=<%=writesort%>&nowPage=<%=realnowPage%>&searchType=<%=searchType%>&searchValue=<%=searchValue%>'">등록</button>
				<%} %>
					</div>
					<div id="paging">
						<div<%if(list.paging.getStartPage() == 1) {%>
							style="visibility: hidden;"
						<%}%>>&lt;</div>
						<%for(int i = list.paging.getStartPage(); i <= list.paging.getEndPage(); i++){%>
						<%if(i == list.paging.getNowPage()){%>
							<div id="nowPage" style="cursor:default; background-color: deepskyblue;"><%=i %></div>
						<%}else{%>
						<a href="<%=request.getContextPath()%>/jauboard/board_list.jsp?writesort=<%=writesort%>&nowPage=<%=i%>&searchType=<%=searchType%>&searchValue=<%=searchValue%>"><div><%=i %></div></a>
						<%}
				  		}%>
						<div<%if(list.paging.getEndPage() == list.paging.getLastPage()){%>
							style="visibility: hidden;"
						<%} %>>&gt;</div>
					</div>
					<div id="commu">
						
					</div>
				</div>
			</div>
		</div>
		<%@include file="/section_asideWrap.jsp" %>
	</section>
	<%@include file="/footer.jsp" %>
</body>
</html>