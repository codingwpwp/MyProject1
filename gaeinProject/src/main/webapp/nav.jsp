<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<nav class="site nav">
	<div id="nav">
		<ul>
			<li class="menu 1" id="menu1" style="width: 80px; font-weight: bold;">
			<a href="<%=request.getContextPath()%>/jauboard/boardList.jsp?malhead=all">자유게시판</a><br>
				<ul>
					<li><a href="<%=request.getContextPath()%>/jauboard/boardList.jsp?malhead=notice">공지</a></li>
					<li><a href="<%=request.getContextPath()%>/jauboard/boardList.jsp?malhead=normal">일반</a></li>
					<li><a href="<%=request.getContextPath()%>/jauboard/boardList.jsp?malhead=qna">질문</a></li>
					<li><a href="<%=request.getContextPath()%>/jauboard/boardList.jsp?malhead=commuapply">커뮤신청</a></li>
				</ul>
			</li>
			<li class="menu 2" id="menu2" style="font-weight: bold; width: 100px;">
			<a href="<%=request.getContextPath()%>/commuboard/boardList.jsp">커뮤니티</a><br>
				<ul>
					<li><a href="#">코딩커뮤</a></li>
					<li><a href="#">축구커뮤</a></li>
					<li><a href="#">헬스커뮤</a></li>
					<li><a href="#">구인커뮤</a></li>
				</ul>
			</li>
			<li class="menu 3" id="menu3" style="width: 130px; font-weight: bold;">
			<a href="<%=request.getContextPath()%>/commujangboard/boardList.jsp">커뮤장전용게시판</a><br>
				<ul>
					<li><a href="#">공지</a></li>
					<li><a href="#">일반</a></li>
					<li><a href="#">질문</a></li>
				</ul>
			</li>
		</ul>
	</div>
</nav>