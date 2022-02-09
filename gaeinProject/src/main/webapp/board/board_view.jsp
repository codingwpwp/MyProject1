<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="boardWeb.util.*"%>
<%@ page import="boardWeb.vo.*"%>
<%
	Member loginUser = (Member)session.getAttribute("loginUser");
	
	int midx = -1;
	if(loginUser != null) midx = loginUser.getMidx();
	
	int nologin = 0;
	if(loginUser == null) nologin = 1;
	
	request.setCharacterEncoding("UTF-8");
	
	int lidx = Integer.parseInt(request.getParameter("lidx"));	// 게시판 번호

	int bidx = Integer.parseInt(request.getParameter("bidx"));	// 글 번호
	
	int writesortnum =  Integer.parseInt(request.getParameter("writesortnum"));	// 카테고리 또는 말머리
	
	String searchType = request.getParameter("searchType");		// 검색 종류
	if(searchType == null) searchType = "";
	
	String searchValue = request.getParameter("searchValue");	// 검색 값
	if(searchValue == null) searchValue = "";
	
	String nowPage = request.getParameter("nowPage");			// 페이지
	
	
	// 쿠키 관리
	int visitSwitch = 0;
	String cookiesql = "";
	String cookieName = "";
	if(loginUser != null){
		cookieName = lidx + "-" + bidx + "-" +  loginUser.getMidx();	// 게시판번호(lidx) - 게시글번호 - 회원번호(midx)로 쿠키이름만 생성
	}
	Connection conn = null;
	PreparedStatement psmt = null;
	
	try{
		conn = DBManager.getConnection();
		
		Cookie[] cookies = request.getCookies();
		
		if(loginUser != null){
			
			if(cookies != null){
				for(Cookie cook : cookies){
					if(cook.getName().equals(cookieName) && cook.getValue().equals("viewed")){
						visitSwitch = 1;
						break;
					}
				}
			}
			
			if(visitSwitch == 0){
				cookiesql = "UPDATE assaboard SET hit = hit + 1 WHERE bidx = " + bidx;
				psmt = conn.prepareStatement(cookiesql);
				int result = psmt.executeUpdate();
				if(result == 1){
					Cookie cookie = new Cookie(cookieName, "viewed");
					cookie.setMaxAge(60 * 60 * 24);
					response.addCookie(cookie);
				}
			}
			
		}
	} catch (Exception e) {
		e.printStackTrace();
	} finally{
		DBManager.close(conn, psmt);
	}
	
	// 게시글 상세조회 + 댓글조회
	ViewFilter view = new ViewFilter(lidx, bidx, midx);
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
		<script>
			var nologin = <%=nologin%>;
			if(nologin == 1){
				alert('회원가입이후 이용할 수 있습니다');
				location.href="/gaeinProject/join/join.jsp";
			}
		</script>
		<div id="mainWrap">
			<h2><%=view.listtitle%> - 조회</h2>
			<span><%=view.gulView.getWritesort()%></span>
			<div id="submenu">
				<button onclick="location.href='<%=request.getContextPath()%>/board/board_list.jsp?lidx=<%=lidx%>&writesortnum=<%=writesortnum%>&nowPage=<%=nowPage%>&searchType=<%=searchType%>&searchValue=<%=searchValue%>'">목록</button>
				<%if(loginUser != null && loginUser.getMidx() == view.gulView.getMidx()){ if(!view.commuapply.getOkyn().equals("Y")){
				%><button onclick="location.href='<%=request.getContextPath()%>/board/board_modify.jsp?lidx=<%=lidx%>&bidx=<%=bidx%>&writesortnum=<%=writesortnum%>&writesort=<%=view.gulView.getWritesort()%>&nowPage=<%=nowPage%>&searchType=<%=searchType%>&searchValue=<%=searchValue%>'">수정</button><%}}%>
				<%if(loginUser != null && (loginUser.getMidx() == view.gulView.getMidx() || loginUser.getMidx() == view.listmastermidx)){ if(!view.commuapply.getOkyn().equals("Y")){
				%><button onclick="location.href='<%=request.getContextPath()%>/board/board_delete.jsp?lidx=<%=lidx%>&bidx=<%=bidx%>&writesortnum=<%=writesortnum%>&nowPage=<%=nowPage%>&searchType=<%=searchType%>&searchValue=<%=searchValue%>'">삭제</button><%}}%>
				<%if(loginUser != null && lidx == 1 && view.gulView.getWritesort().equals("커뮤신청") && loginUser.getMidx() == 0 && view.commuapply.getOkyn() != null && view.commuapply.getOkyn().equals("N")){
				%><button onclick= "commuapplyFn();">허가</button><%}%>
			</div>
			<div id="gulTitle">
				<div><%=view.gulView.getSubject()%></div>
				<div><%=view.gulView.getWriteday()%></div><br>
				<div><%=view.gulView.getNickname()%></div>
				<div>조회 <%=view.gulView.getHit()%></div>
			</div>
			<div id="gul">
				<%if(loginUser != null && !(lidx == 1 && view.gulView.getWritesort().equals("커뮤신청"))){%>
					<%=view.gulView.getContent()%>
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
			<%if(loginUser != null && lidx != 1 && lidx != 2){%>
			<div id="thumb">
				<%if(view.thumbSw == 1){%><img src="<%=request.getContextPath()%>/image/thumbOk.jpg" width="60" onclick="thumb(this)"><%
				}else{%><img src="<%=request.getContextPath()%>/image/thumbNot.jpg" width="60" onclick="thumb(this)"><%}%><br>
				<span><%=view.gulView.getThumb()%></span>
			</div>
			<%}%>
			<%if(loginUser != null && (lidx != 1 || !view.gulView.getWritesort().equals("공지")) && (lidx != 2 || !view.gulView.getWritesort().equals("공지"))){%>
			<div id="replyBoard">
				<h3>댓글(<span id="replycnt"><%=view.replycnt %></span>)</h3>
				<div id="replylist">
				<%for(Reply r : view.replyList){%>
					<div class="reply">
						<input type="hidden" name="ridx" value="<%=r.getRidx()%>">
						<input type="hidden" name="midx" value="<%=r.getMidx()%>">
						<div class="replyEdit">
							<%if(loginUser.getMidx() == r.getMidx()){%>
							<img src="<%=request.getContextPath()%>/image/pencil.png" onclick="modifyReply(this)">
							<%}if((loginUser.getMidx() == r.getMidx()) || loginUser.getPosition().equals("운영자")){%>
							<img src="<%=request.getContextPath()%>/image/x.png" onclick="deleteReply(this)">
							<%}%>
						</div>
						<div class="replyContent">
							<div<%if(r.getPosition().equals("운영자")){%> id="admintd"<%}%>>
							<%if(r.getPosition().equals("운영자")){%>
								<img src="<%=request.getContextPath()%>/image/smilefrog.jpg">
							<%}%><span<%if(r.getPosition().contains("커뮤장")){%>
								id="commujang"
							<%}%>><%=r.getNickname()%></span></div>
							<div><%=r.getRcontent()%></div>
						</div>
						<div class="replyDate">
							<%=r.getRdate()%><%if(r.getModifyyn().equals("Y")){%> (수정됨)<%}%>
						</div>
					</div>
				<%} %>
				</div>
				<div id="replyWrite">
					<form name="replyWrite">
						<input type="hidden" name="midx" value="<%=loginUser.getMidx()%>">
						<input type="hidden" name="lidx" value="<%=lidx%>">
						<input type="hidden" name="bidx" value="<%=bidx%>">
						<textarea name="rcontent" placeholder="댓글을 입력하세요" maxlength="110"></textarea><br>
						<button type="button" onclick="insertReply()">등록</button>
					</form>
				</div>
			<%} %>
			</div>
		</div>
		<%if(lidx != 1 && lidx != 2){%><script src ="<%=request.getContextPath()%>/js/board_view_thumb.js"></script><%}%>
		<%if(!(lidx == 1 && view.gulView.getWritesort().equals("공지")) && !(lidx == 2 && view.gulView.getWritesort().equals("공지"))){%><script src ="<%=request.getContextPath()%>/js/board_view_reply.js"></script><%}%>
		<%@include file="/section_asideWrap.jsp" %>
	</section>
	<%@include file="/footer.jsp" %>
	<script type="text/javascript">
		function commuapplyFn(){
			if(confirm("커뮤니티 개설을 허가하시겠습니까?")){
				location.href= "<%=request.getContextPath()%>/board/board_commuApply.jsp?lidx=<%=lidx%>&bidx=<%=bidx%>";
			}
		}
	</script>
</body>
</html>