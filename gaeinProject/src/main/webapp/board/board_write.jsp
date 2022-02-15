<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	Member loginUser = (Member)session.getAttribute("loginUser");
	
	request.setCharacterEncoding("UTF-8");
	
	int lidx = Integer.parseInt(request.getParameter("lidx"));	// 게시판 번호
	
	int writesortnum =  Integer.parseInt(request.getParameter("writesortnum"));	// 카테고리 또는 말머리

	String searchType = request.getParameter("searchType");						// 검색 종류
	if(searchType == null) searchType = "";
	String searchValue = request.getParameter("searchValue");					// 검색 값
	if(searchValue == null) searchValue = "";
	
	int nowPage = Integer.parseInt(request.getParameter("nowPage"));			// 페이지
	
	ListFilter list = new ListFilter(lidx, writesortnum, nowPage, searchType, searchValue);
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>개인프로젝트</title>
	<link rel="shortcut icon" type="image/x-icon" href="<%=request.getContextPath()%>/image/mylogo.ico">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/header.css">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/nav.css">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/board_write_section_mainWrap.css">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/section_asideWrap.css">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/footer.css">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/summernote/summernote-lite.css">
	<script src ="<%=request.getContextPath()%>/js/jquery-3.6.0.min.js"></script>
	<script src ="<%=request.getContextPath()%>/js/board_write.js"></script>
	<script src="<%=request.getContextPath()%>/summernote/summernote-lite.js"></script>
	<script src="<%=request.getContextPath()%>/summernote/summernote-ko-KR.js"></script>
</head>
<body>
	<%@include file="/header.jsp" %>
	<%@include file="/nav.jsp" %>
	<section style="margin-top: 10px;">
		<div id="mainWrap">
			<h2><a id="lista" href="<%=request.getContextPath()%>/board/board_list.jsp?lidx=<%=lidx%>&writesortnum=0"><%=list.listtitle%></a> - 등록</h2>
			<form method="post" action="<%=request.getContextPath()%>/board/board_wirteOk.jsp" onsubmit = "return gulWrite()">
			<%if(loginUser.getMidx() == list.listmastermidx || loginUser.getMidx() == 0){%>
				<label> <!-- <input> 태그의 name값은 파라미터로 넘어온 WRITESORTNUM값과 전혀 연관이 없다. -->
					<input type="radio" name="writesort" value="<%=list.writesort1%>" <%if(loginUser.getMidx() == list.listmastermidx) out.print("checked");%>><%=list.writesort1%>
				</label>
			<%}%>
				<label>
					<input type="radio" name="writesort" value="<%=list.writesort2%>" <%if(lidx == 1){%>onchange="changeGul(this)"<%}%> <%if(loginUser.getMidx() != list.listmastermidx) out.print("checked");%>><%=list.writesort2%>
				</label>
			<%if(list.writesort3 != null){%>
				<label>
					<input type="radio" name="writesort" value="<%=list.writesort3%>" <%if(lidx == 1){%>onchange="changeGul(this)"<%}%>><%=list.writesort3%>
				</label>
			<%}%>
			<%if(lidx == 1 && list.writesort4 != null){
				if(loginUser.getPosition().contains("일반")){%>
				<label>
					<input type="radio" name="writesort" value="<%=list.writesort4%>" <%if(lidx == 1){%>onchange="changeGul(this)"<%}%>><%=list.writesort4%>
				</label>
				<%}%>
			<%}else if(lidx != 1 && list.writesort4 != null){%>
				<label>
					<input type="radio" name="writesort" value="<%=list.writesort4%>"><%=list.writesort4%>
				</label>
			<%}%>
			<%if(list.writesort5 != null){%>
				<label>
					<input type="radio" name="writesort" value="<%=list.writesort5%>"><%=list.writesort5%>
				</label>
			<%}%>
				<input type="hidden" name="lidx" value="<%=lidx%>">
				<div id="submenu">
					<button type="submit">완료</button>
					<button type="button" onclick="location.href='<%=request.getContextPath()%>/board/board_list.jsp?lidx=<%=lidx%>&writesortnum=<%=writesortnum%>&nowPage=<%=nowPage%>&searchType=<%=searchType%>&searchValue=<%=searchValue%>'">취소</button>
				</div>
				<div id="gulTitle">
					<div style="margin-top:10px">
						<span>제목</span>
						<input type="text" id="gulSubject" name="subject" maxlength="25" placeholder="25자이내로 적으세요">
					</div>
				</div>
				<div id="gul">
					<textarea id="summernote" name="editordata"></textarea>
					<%if(lidx == 1){%>
					<div id="commuform">
						<span style="color:red; font-size:small;">
							*현재 카테고리에서 변경할 경우 기존에 입력한 내용들은 전부 지워집니다.<br>
							*등록한 이후 다른 카테고리로 변경 할 수 없고, 운영자가 허가한 이후엔 해당 글을 수정, 삭제를 할 수 없습니다.
						</span>
						<div>
							<span>커뮤이름 : </span>
							<input type="text" id="cTitle" name="commuTitle" maxlength="6" placeholder="2 ~ 4자리의 한글 + 커뮤" onkeyup="this.value=this.value.replace(/[^ㄱ-ㅎ가-힣]/g,'');">&nbsp;
							ex) ○○커뮤
						</div>
						<div>
							<span>소개글 : </span>
							<textarea name="commuIntroduce" maxlength="30"
							placeholder="커뮤니티의 소개글입니다. 30자 이내의 한 줄문장으로 입력하세요"></textarea>
						</div>
						<div>
							<div><span>카테고리 : </span></div>
							<div id="commumalhead">
								<input type="text" name="commumalhead1" value="공지" readonly>
								<span style="color: red; font-size: small;">*2개는 필수</span>
								<br>
								<input type="text" name="commumalhead2" placeholder="4자이내" maxlength="4">
								<img src="<%=request.getContextPath()%>/image/plus.png" width="10" onclick="commumalPlus()">&nbsp;
								<img src="<%=request.getContextPath()%>/image/minus.png" width="10" onclick="commumalMinus()">
								<br>
							</div>
						</div>
						<div>
							<span>사유 : &nbsp;&nbsp;</span>
							<textarea name="commuReason" maxlength="100"
							placeholder="성심성의것 작성해주시기 바랍니다."></textarea>
						</div>
						<input type="hidden" name="commumalheadCnt" value="2">
					</div>
					<%}%>
				</div>
			</form>
		</div>
		<%@include file="/section_asideWrap.jsp" %>
	</section>
	<%@include file="/footer.jsp" %>
</body>
</html>