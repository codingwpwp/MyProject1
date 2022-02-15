<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="boardWeb.util.*"%>
<%@ page import="boardWeb.vo.*"%>
<%
	Member loginUser = (Member)session.getAttribute("loginUser");
	
	int midx = -1;
	if(loginUser != null) midx = loginUser.getMidx();
	
	int nologinSw = 0;
	if(loginUser == null) nologinSw = 1;
	
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
	int visitSwitch = 0;	// 게시글의 조회여부를 결정짓는 변수
	
	String cookiesql = "";	// 쿠키관련 쿼리문
	
	String cookieName = "";	// 쿠키이름
	
	if(loginUser != null){	// 조건문 안걸면 오류뜸
		cookieName = lidx + "-" + bidx + "-" +  loginUser.getMidx();	// 게시판번호(lidx) - 게시글번호 - 회원번호(midx)로 쿠키이름만 생성
	}
	Connection conn = null;
	PreparedStatement psmt = null;
	
	try{
		conn = DBManager.getConnection();
		
		Cookie[] cookies = request.getCookies();	// 쿠키들 들어있는 객체생성
		
		if(loginUser != null){
			
			if(cookies != null){
				for(Cookie cook : cookies){	// 쿠키객체안의 쿠키물 확인하는 반복문
					if(cook.getName().equals(cookieName) && cook.getValue().equals("viewed")){	// 쿠키이름과 그에대한 값이 존재하는경우
						visitSwitch = 1;	// 게시글을 조회한 이력이 있다.
						break;	// 이건 빼도되고 안빼도 됨. 속도 높이려고 break한거.
					}
				}
			}
			
			if(visitSwitch == 0){	// 조회한 이력이 없을 경우
				cookiesql = "UPDATE assaboard SET hit = hit + 1 WHERE bidx = " + bidx;	// 조회수 1 올려줌
				psmt = conn.prepareStatement(cookiesql);
				int result = psmt.executeUpdate();
				if(result == 1){
					Cookie cookie = new Cookie(cookieName, "viewed");	// 쿠키 이름과 그에대한 값("viewed")을 생성
					cookie.setMaxAge(60 * 60 * 24);	// 24시간으로 설정
					response.addCookie(cookie);		// 생성한걸 쿠키객체에 집어 넣음
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
	
	// 삭제버튼이 나오는 경우
	int deleteSw = 0;
	if(loginUser != null){	// 로그인을 했을때
		if(view.gulView.getMidx() != 0){	// 운영자가 작성한 글이 아닐 때
			if(loginUser.getMidx() == 0 && !view.commuapply.getOkyn().equals("Y")){	// 운영자가 로그인하고 특정글(커뮤신청)이 허가가 난 경우를 제외한 경우
				deleteSw = 1;
			}else{	// 운영자가 아닌 사람이 로그인을 했을 경우
				if(lidx == 1){	// 자유게시판인 경우
					if(!view.commuapply.getOkyn().equals("Y")){	// 카테고리가 커뮤신청에서 허가가 나지않았을때
						if(loginUser.getMidx() == view.gulView.getMidx()){	// 본인이 작성한 글인 경우
							deleteSw = 1;
						}
					}
				}else if(lidx == 2){	// 커뮤장전용게시판일때 
					if(loginUser.getMidx() == 0){	// 운영자인 경우
						deleteSw = 1;
					}
				}else{
					if(loginUser.getMidx() == view.listmastermidx){	// 커뮤장인 경우
						deleteSw = 1;
					}else if(loginUser.getMidx() == view.gulView.getMidx()){	// 본인이 작성한 경우
						deleteSw = 1;
					}
				}
			}
		}else{	// 운영자가 작성한 글일 때
			if(loginUser.getMidx() == 0){
				deleteSw = 1;
			}
		}
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
			var nologin = <%=nologinSw%>;
			if(nologin == 1){
				alert('회원가입이후 이용할 수 있습니다');
				location.href="/gaeinProject/join/join.jsp";
			}
		</script>
		<div id="mainWrap">
			<h2><a id="lista" href="<%=request.getContextPath()%>/board/board_list.jsp?lidx=<%=lidx%>&writesortnum=0"><%=view.listtitle%></a><span style="font-size: 17px; color: gray;">(<%=view.gulView.getWritesort()%>)</span></h2>
			<span></span>
			<div id="submenu">
				<button onclick="location.href='<%=request.getContextPath()%>/board/board_list.jsp?lidx=<%=lidx%>&writesortnum=<%=writesortnum%>&nowPage=<%=nowPage%>&searchType=<%=searchType%>&searchValue=<%=searchValue%>'">목록</button>
				<%if(loginUser != null && loginUser.getMidx() == view.gulView.getMidx()){ if(!view.commuapply.getOkyn().equals("Y")){
				%><button onclick="location.href='<%=request.getContextPath()%>/board/board_modify.jsp?lidx=<%=lidx%>&bidx=<%=bidx%>&writesortnum=<%=writesortnum%>&writesort=<%=view.gulView.getWritesort()%>&nowPage=<%=nowPage%>&searchType=<%=searchType%>&searchValue=<%=searchValue%>'">수정</button><%}}%>
				<%if(deleteSw == 1){
				%><button onclick="location.href='<%=request.getContextPath()%>/board/board_delete.jsp?lidx=<%=lidx%>&bidx=<%=bidx%>&writesortnum=<%=writesortnum%>&nowPage=<%=nowPage%>&searchType=<%=searchType%>&searchValue=<%=searchValue%>'">삭제</button><%}%>
				<%if(loginUser != null && lidx == 1 && view.gulView.getWritesort().equals("커뮤신청") && loginUser.getMidx() == 0 && view.commuapply.getOkyn() != null && view.commuapply.getOkyn().equals("N")){
				%><button onclick= "commuapplyFn()">허가</button><%}%>
			</div>
			<div id="gulTitle">
				<div><%=view.gulView.getSubject()%></div>
				<div><%=view.gulView.getWriteday()%></div><br>
				<div><span <%if(view.gulView.getPosition().equals("운영자")){
				%>id="admin"<%}else if(view.gulView.getPosition().contains("커뮤장")){
				%>id="commujang"<%}%>><%if(view.gulView.getPosition().equals("운영자")){%><img src="<%=request.getContextPath()%>/image/smilefrog.jpg" width="15"><%}%><%=view.gulView.getNickname()%></span></div>
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
						카테고리 :
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
							<img src="<%=request.getContextPath()%>/image/pencil.png" onclick="modifyReply(this)"><%
							}
							int replydeleteSw = 0;
							if(r.getMidx() == 0){
								if(loginUser.getMidx() == 0){
									replydeleteSw = 1;
								}
							}else{
								if(loginUser.getPosition().equals("운영자")){
									replydeleteSw = 1;
								}else if(loginUser.getPosition().contains("커뮤장")){
									if(loginUser.getMidx() == view.listmastermidx){
										replydeleteSw = 1;
									}
								}else if(loginUser.getPosition().equals("일반")){
									if(loginUser.getMidx() == r.getMidx()){
										replydeleteSw = 1;
									}
								}
							}
							if(replydeleteSw == 1){%><img src="<%=request.getContextPath()%>/image/x.png" onclick="deleteReply(this)"><%}%>
						</div><!-- (loginUser.getMidx() == r.getMidx() || loginUser.getPosition().equals("운영자") || loginUser.getMidx() == view.listmastermidx) && !(r.getNickname().equals("운영자") && loginUser.getMidx() == 0) -->
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
						<input type="hidden" name="lidx" value="<%=lidx%>">	
						<input type="hidden" name="midx" value="<%=loginUser.getMidx()%>">
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
				
				
				$.ajax({
					url : "<%=request.getContextPath()%>/board/board_commucheck.jsp",
					type : "post",
					data : "commutitle=" + "<%=view.commuapply.getCommuTitle()%>",
					success : function(data){
						
						var result = data.trim();
						if(result == "exist"){
							alert('이미 존재하는 커뮤니티 입니다');
						}else{
							$.ajax({
								url : "<%=request.getContextPath()%>/board/board_commuapply.jsp",
								type : "post",
								data : "lidx=" + <%=lidx%> + "&bidx=" + <%=bidx%>,
								success : function(){
									alert('개설되었습니다');
									location.href= "<%=request.getContextPath()%>/board/board_list.jsp?&lidx=1&writesortnum=0";
								}
							});
						}
						
					}
				});
				
				
			}
		}
	</script>
</body>
</html>