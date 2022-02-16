<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	Member loginUser = (Member)session.getAttribute("loginUser");

	int midx = -1;
	if(loginUser == null) midx = loginUser.getMidx();
	
	request.setCharacterEncoding("UTF-8");
	
	int lidx = Integer.parseInt(request.getParameter("lidx"));	// 게시판 번호

	int bidx = Integer.parseInt(request.getParameter("bidx"));	// 글 번호
	
	int writesortnum =  Integer.parseInt(request.getParameter("writesortnum"));	// 카테고리 넘버(글 조회할때만 사용)
	
	String searchType = request.getParameter("searchType");		// 검색 종류
	
	String searchValue = request.getParameter("searchValue");	// 검색 값
	
	String nowPage = request.getParameter("nowPage");			// 페이지
	
	ViewFilter view = new ViewFilter(lidx, bidx, midx);
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
	<script src ="<%=request.getContextPath()%>/js/board_modify.js"></script>
	<script src="<%=request.getContextPath()%>/summernote/summernote-lite.js"></script>
	<script src="<%=request.getContextPath()%>/summernote/summernote-ko-KR.js"></script>
</head>
<body onload="noBack();" onpageshow="if(event.persisted) noBack();" onunload="">
	<script type="text/javascript">
		 window.history.forward();
		 function noBack(){window.history.forward();}
	</script>
	<%@include file="/header.jsp" %>
	<%@include file="/nav.jsp" %>
	<section style="margin-top: 10px;">
		<div id="mainWrap">
			<h2><a id="lista" href="<%=request.getContextPath()%>/board/board_list.jsp?lidx=<%=lidx%>&writesortnum=0"><%=view.listtitle%></a> - 수정</h2>
			<form method="post" action="<%=request.getContextPath()%>/board/board_modifyOk.jsp" onsubmit = "return gulModify()">
				<input type="hidden" name="lidx" value="<%=lidx%>">
				<input type="hidden" name="bidx" value="<%=bidx%>">
				<%if(lidx == 1){
					if(view.gulView.getWritesort().equals("공지")){%>
						<label>
							<input type="radio" name="writesort" value="<%=view.writesort1%>" checked><%=view.writesort1%>
						</label>
					<%}%>
					<%if(!view.gulView.getWritesort().equals("커뮤신청") && !view.gulView.getWritesort().equals("공지")){%>
						<label>
							<input type="radio" name="writesort" value="<%=view.writesort2%>" <%if(view.writesort2.equals(view.gulView.getWritesort())) out.print("checked");%>><%=view.writesort2%>
						</label>
						<label>
							<input type="radio" name="writesort" value="<%=view.writesort3%>" <%if(view.writesort3.equals(view.gulView.getWritesort())) out.print("checked");%>><%=view.writesort3%>
						</label>
					<%}%>
					<%if(view.gulView.getWritesort().equals("커뮤신청")){%>
						<label>
							<input type="radio" name="writesort" value="<%=view.writesort4%>" <%if(view.writesort4.equals(view.gulView.getWritesort())){out.print("checked");}%> onchange="changeGul(this)"><%=view.writesort4%>
						</label>
					<%}%>
				<%}else{
					if(view.gulView.getWritesort().equals("공지")){%>
					<label>
						<input type="radio" name="writesort" value="<%=view.writesort1%>" checked><%=view.writesort1%>
					</label>
					<%}else{%>
						<%if(view.writesort2 != null){%>
						<label>
							<input type="radio" name="writesort" value="<%=view.writesort2%>" <%if(view.writesort2.equals(view.gulView.getWritesort())) out.print("checked");%>><%=view.writesort2%>
						</label>
						<%}%>
						<%if(view.writesort3 != null){%>
						<label>
							<input type="radio" name="writesort" value="<%=view.writesort3%>" <%if(view.writesort3.equals(view.gulView.getWritesort())) out.print("checked");%>><%=view.writesort3%>
						</label>
						<%}%>
						<%if(view.writesort4 != null){%>
						<label>
							<input type="radio" name="writesort" value="<%=view.writesort4%>" <%if(view.writesort4.equals(view.gulView.getWritesort())) out.print("checked");%>><%=view.writesort4%>
						</label>
						<%}%>
						<%if(view.writesort5 != null){%>
						<label>
							<input type="radio" name="writesort" value="<%=view.writesort5%>" <%if(view.writesort5.equals(view.gulView.getWritesort())) out.print("checked");%>><%=view.writesort5%>
						</label>
						<%}%>
					<%}%>
				<%}%>
				<div id="submenu">
					<button type="submit">완료</button>
					<button type="button" onclick="location.href='<%=request.getContextPath()%>/board/board_view.jsp?lidx=<%=lidx%>&bidx=<%=bidx%>&writesortnum=<%=writesortnum%>&nowPage=<%=nowPage%>&searchType=<%=searchType%>&searchValue=<%=searchValue%>'">취소</button>
				</div>
				<div id="gulTitle">
					<div style="margin-top:10px">
						<span>제목</span>
						<input type="text" id="gulSubject" name="subject" maxlength="25" placeholder="25자이내로 적으세요" value="<%=view.gulView.getSubject()%>">
					</div>
				</div>
				<div id="gul">
				<%if(lidx != 1 || !view.gulView.getWritesort().equals("커뮤신청")){
					%><textarea id="summernote" name="editordata"><%=view.gulView.getContent()%></textarea><%
				}else{
					%><div id="commuform">
						<div>
							<span>커뮤이름 : </span>
							<input type="text" id="cTitle" name="commuTitle" maxlength="6" placeholder="2 ~ 4자리의 한글 + 커뮤"
							onkeyup="this.value=this.value.replace(/[^ㄱ-ㅎ가-힇]/g,'');" value="<%=view.commuapply.getCommuTitle()%>">&nbsp;
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
				<input type="hidden" name="writesortnum" value="<%=writesortnum%>">
				<input type="hidden" name="nowPage" value="<%=nowPage%>">
				<input type="hidden" name="searchType" value="<%=searchType%>">
				<input type="hidden" name="searchValue" value="<%=searchValue%>">
			</form>
		</div>
		<%@include file="/section_asideWrap.jsp" %>
	</section>
	<%@include file="/footer.jsp" %>
</body>
</html>