<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="boardWeb.vo.*" %>
<%@ page import="boardWeb.util.*" %>
<%
	Connection connn = null;
	PreparedStatement psmtt = null;
	ResultSet rss = null;
	
	try{
		connn = DBManager.getConnection();
		String sqll = "SELECT * FROM assaboardlist WHERE lidx > 2 AND delyn='N'";
		psmtt = connn.prepareStatement(sqll);
		rss = psmtt.executeQuery();
%>
<nav class="site nav">
	<div id="nav">
		<ul>
			<li class="menu 1" id="menu1" style="width: 80px; font-weight: bold;">
			<a href="<%=request.getContextPath()%>/board/board_list.jsp?lidx=1&writesortnum=0">자유게시판</a><br>
				<ul>
					<li><a href="<%=request.getContextPath()%>/board/board_list.jsp?lidx=1&writesortnum=1">공지</a></li>
					<li><a href="<%=request.getContextPath()%>/board/board_list.jsp?lidx=1&writesortnum=2">일반</a></li>
					<li><a href="<%=request.getContextPath()%>/board/board_list.jsp?lidx=1&writesortnum=3">질문</a></li>
					<li><a href="<%=request.getContextPath()%>/board/board_list.jsp?lidx=1&writesortnum=4">커뮤신청</a></li>
				</ul>
			</li>
			<li class="menu 2" id="menu2" style="font-weight: bold; width: 100px;">
				<span style="color: black; cursor: default;">커뮤니티</span><br>
				<ul>
				<%while(rss.next()){%>
					<li><a href="<%=request.getContextPath()%>/board/board_list.jsp?lidx=<%=rss.getInt("lidx")%>&writesortnum=0"><%=rss.getString("listtitle")%></a></li>
				<%}%>
				</ul>
			</li>
			<li class="menu 3" id="menu3" style="width: 130px; font-weight: bold;">
			<a href="<%=request.getContextPath()%>/board/board_list.jsp?lidx=2&writesortnum=0">커뮤장전용게시판</a><br>
				<ul>
					<li><a href="<%=request.getContextPath()%>/board/board_list.jsp?lidx=2&writesortnum=1">공지</a></li>
					<li><a href="<%=request.getContextPath()%>/board/board_list.jsp?lidx=2&writesortnum=2">일반</a></li>
					<li><a href="<%=request.getContextPath()%>/board/board_list.jsp?lidx=2&writesortnum=3">질문</a></li>
				</ul>
			</li>
		</ul>
	</div>
</nav>
<%
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBManager.close(connn, psmtt, rss);
	}
%>