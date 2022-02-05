<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	Member loginUser = (Member)session.getAttribute("loginUser");
	if(loginUser == null) response.sendRedirect(request.getContextPath() + "/index.jsp");
	
	request.setCharacterEncoding("UTF-8");
	int bidx = Integer.parseInt(request.getParameter("bidx"));
	String writesort = request.getParameter("writesort");
	String nowPage = request.getParameter("nowPage");
	String searchType = request.getParameter("searchType");
	String searchValue = request.getParameter("searchValue");
	
	String cookieNumber = 1 + "-" + bidx;	//쿠키
	
	ViewFilter view = new ViewFilter(1, bidx);
	
	
	
	
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>개인프로젝트</title>
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/header.css">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/nav.css">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/board_detail_section_mainWrap.css">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/section_asideWrap.css">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/footer.css">
	<script src ="<%=request.getContextPath()%>/js/jquery-3.6.0.min.js"></script>
</head>
<body>
	<%@include file="/header.jsp" %>
	<%@include file="/nav.jsp" %>
	<section style="margin-top: 10px;">
		<div id="mainWrap">
			<h2>자유게시판</h2>
			<span><%=view.gulView.getWritesort()%></span>
			<div id="submenu">
				<button onclick="location.href='<%=request.getContextPath()%>/jauboard/board_list.jsp?writesort=<%=writesort%>&nowPage=<%=nowPage%>&searchType=<%=searchType%>&searchValue=<%=searchValue%>'">목록</button>
				<%if(loginUser != null && (loginUser.getMidx() == view.gulView.getMidx())){
				%><button>수정</button><%}%>
				<%if(loginUser != null && ((loginUser.getMidx() == view.gulView.getMidx()) || (loginUser.getMidx() == 0))){
				%><button>삭제</button><%}%>
				<%if(loginUser != null && view.gulView.getWritesort().equals("커뮤신청") && loginUser.getMidx() == 0){
				%><button>허가</button><%}%>
			</div>
			<div id="gulTitle">
				<div><%=view.gulView.getSubject()%></div>
				<div><%=view.gulView.getWriteday()%></div><br>
				<div><%=view.gulView.getNickname()%></div>
				<div>조회 <%=view.gulView.getHit()%></div>
			</div>
			<div id="gul">
				<%if(loginUser != null && !view.gulView.getWritesort().equals("커뮤신청")){%>
					<%=view.gulView.getContent() %>
				<%}else if(loginUser != null){%>
				<div><h3> 커뮤이름 : <%=view.commuapply.getCommuTitle()%></h3></div>
				<div><h3> 소개글 : <%=view.commuapply.getListIntroduce()%></h3></div>
				<div>
					<div id="commuhead">
						말머리 :
					</div>
					<div>
						<span><%=view.commuapply.getWritesort1()%></span><br><br>
						<%=view.commuapply.getWritesort2() %><br><br><%
						if(view.commuapply.getWritesort3() != null){
						%><%=view.commuapply.getWritesort3()%><br><br><%}
						if(view.commuapply.getWritesort4() != null){
						%><%=view.commuapply.getWritesort4()%><br><br><%}
						if(view.commuapply.getWritesort5() != null){
						%><%=view.commuapply.getWritesort5()%><br><br><%}%>
					</div>
				</div>
				<div><h3> 사유 : <%=view.commuapply.getCommuReason() %></h3></div>
				<%}%>
			</div>
			<%if(!view.gulView.getWritesort().equals("공지")){%>
			<div id="replyBoard">
				<h3>댓글(2)</h3>
				<div id="reply">
					<div id="replyEdit">
						<img src="<%=request.getContextPath()%>/image/pencil.png">
						<img src="<%=request.getContextPath()%>/image/x.png">
					</div>
					<div id="replyContent">
						<div>테스터</div>
						<div>댓글입니다.댓글입니다.댓글입니다.댓글입니다.댓글입니다.댓글입니다.댓글입니다.댓글입니다.댓글입니다.댓글입니다.댓글입니다.댓글입니다.댓글입니다.댓글입니다.댓글입니다.댓글입니다.댓글입니다.댓글입니다.댓글입니다.댓글입니다.댓글입니다.</div>
					</div>
					<div id="replyDate">
						2022-01-01 &nbsp;15:23
					</div>
				</div>

				<div id="reply">
					<div id="replyEdit">
						<img src="<%=request.getContextPath()%>/image/pencil.png">
						<img src="<%=request.getContextPath()%>/image/x.png">
					</div>
					<div id="replyContent">
						<div>테스터</div>
						<div>댓글입니다.댓글입니다.댓글입니다.댓글입니다.댓글입니다.댓글입니다.댓글입니다.댓글입니다.댓글입니다.댓글입니다.댓글입니다.댓글입니다.댓글입니다.댓글입니다.댓글입니다.댓글입니다.댓글입니다.댓글입니다.댓글입니다.댓글입니다.댓글입니다.</div>
					</div>
					<div id="replyDate">
						2022-01-01 &nbsp;15:23
					</div>
				</div>
				<div id="replyWrite">
					<textarea placeholder="댓글을 입력하세요"></textarea><br>
					<button>등록</button>
				</div><%} %>
			</div>
		</div>
		<%@include file="/section_asideWrap.jsp" %>
	</section>
	<%@include file="/footer.jsp" %>
</body>
</html>