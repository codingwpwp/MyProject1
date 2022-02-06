<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	Member loginUser = (Member)session.getAttribute("loginUser");
	
	request.setCharacterEncoding("UTF-8");
	String writesort = request.getParameter("writesort");
	if(writesort == null){
		writesort = "all";
	}
	int nowPage = Integer.parseInt(request.getParameter("nowPage"));
	int bidx = Integer.parseInt(request.getParameter("bidx"));
	String searchType = request.getParameter("searchType");
	if(searchType == null){
		searchType = "";
	}
	String searchValue = request.getParameter("searchValue");
	if(searchValue == null){
		searchValue = "";
	}
	ViewFilter view = new ViewFilter(1, bidx);
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>개인프로젝트</title>
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/header.css">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/nav.css">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/board_write_section_mainWrap.css">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/section_asideWrap.css">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/footer.css">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/summernote/summernote-lite.css">
	<script src ="<%=request.getContextPath()%>/js/jquery-3.6.0.min.js"></script>
	<script src ="<%=request.getContextPath()%>/js/board_modify_section_mainWrap.js"></script>
	<script src="<%=request.getContextPath()%>/summernote/summernote-lite.js"></script>
	<script src="<%=request.getContextPath()%>/summernote/summernote-ko-KR.js"></script>
</head>
<body>
	<%@include file="/header.jsp" %>
	<%@include file="/nav.jsp" %>
	<section style="margin-top: 10px;">
		<div id="mainWrap">
			<h2>자유게시판 - 수정</h2>
			<form method="post" action="<%=request.getContextPath()%>/jauboard/board_modifyOk.jsp" onsubmit = "return gulWrite()">
			<%if(view.gulView.getWritesort().equals("공지")){%>
				<label>
					<input type="radio" name="writesort" value="notice" checked>공지
				</label>
			<%}%>
			<%if(view.gulView.getWritesort().equals("일반") || view.gulView.getWritesort().equals("질문")){%>
				<label>
					<input type="radio" name="writesort" value="normal" <%if(view.gulView.getWritesort().equals("일반")){%>checked<%}%>>일반
				</label>
				<label>
					<input type="radio" name="writesort" value="qna" <%if(view.gulView.getWritesort().equals("질문")){%>checked<%}%>>질문
				</label>
			<%}%>
			<%if(view.gulView.getWritesort().equals("커뮤신청")){%>
				<label>
					<input type="radio" name="writesort" value="commuapply" checked>커뮤신청
				</label>
			<%}%>
				<div id="submenu">
					<button type="submit">완료</button>
					<button type="button" onclick="location.href='<%=request.getContextPath()%>/jauboard/board_view.jsp?bidx=<%=bidx%>&writesort=<%=writesort%>&nowPage=<%=nowPage%>&searchType=<%=searchType%>&searchValue=<%=searchValue%>'">취소</button>
				</div>
				<div id="gulTitle">
					<div style="margin-top:10px">
						<span>제목</span>
						<input type="text" id="gulSubject" name="subject" maxlength="25" placeholder="25자이내로 적으세요" value="<%=view.gulView.getSubject()%>">
					</div>
				</div>
				<div id="gul">
				<%if(!view.gulView.getWritesort().equals("커뮤신청")){
					%><textarea id="summernote" name="editordata"><%=view.gulView.getContent()%></textarea><%
				}else{
					%><div id="commuform">
						<div>
							<span>커뮤이름 : </span>
							<input type="text" id="cTitle" name="commuTitle" maxlength="6" placeholder="2 ~ 4자리의 한글 + 커뮤"
							onkeyup="this.value=this.value.replace(/[^ㄱ-ㅎ가-힇]/g,'');"
							value="<%=view.commuapply.getCommuTitle()%>">&nbsp;
							ex) ○○커뮤
						</div>
						<div>
							<span>소개글 : </span>
							<textarea name="commuIntroduce" maxlength="30"
							placeholder="커뮤니티의 소개글입니다. 30자 이내의 한 줄문장으로 입력하세요."><%=view.commuapply.getListIntroduce()%></textarea>
						</div>
						<div>
							<div><span>말머리 : </span></div>
							<div id="commumalhead">
								<input type="text" name="commumalhead1" value="<%=view.commuapply.getWritesort1()%>" readonly>
								<span style="color: red; font-size: small;">*필수</span>
								<br>
								<input type="text" name="commumalhead2" placeholder="4자이내" maxlength="4" value="<%=view.commuapply.getWritesort2()%>">
								<img src="<%=request.getContextPath()%>/image/plus.png" width="10" onclick="commumalPlus()">&nbsp;
								<img src="<%=request.getContextPath()%>/image/minus.png" width="10" onclick="commumalMinus()">
								<br><%if(view.commuapply.getWritesort3() != null){
								%><input type="text" name="commumalhead3" placeholder="4자이내" maxlength="4" value="<%=view.commuapply.getWritesort3()%>"><br><%}%>
								<%if(view.commuapply.getWritesort4() != null){
								%><input type="text" name="commumalhead4" placeholder="4자이내" maxlength="4" value="<%=view.commuapply.getWritesort4()%>"><br><%}%>
								<%if(view.commuapply.getWritesort5() != null){
								%><input type="text" name="commumalhead5" placeholder="4자이내" maxlength="4" value="<%=view.commuapply.getWritesort5()%>"><br><%}%>
							</div>
						</div>
						<div>
							<span>사유 : &nbsp;&nbsp;</span>
							<textarea name="commuReason" maxlength="100"
							placeholder="성심성의것 작성해주시기 바랍니다."><%=view.commuapply.getCommuReason() %></textarea>
						</div>
						<input type="hidden" name="commumalheadCnt" value="<%=view.commuapply.getWritesortcnt()%>">
					</div><%}%>
				</div>
			</form>
		</div>
		<%@include file="/section_asideWrap.jsp" %>
	</section>
	<%@include file="/footer.jsp" %>
</body>
</html>