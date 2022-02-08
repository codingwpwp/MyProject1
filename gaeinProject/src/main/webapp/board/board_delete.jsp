<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="boardWeb.vo.*" %>
<%@ page import="boardWeb.util.*" %>
<%
	request.setCharacterEncoding("UTF-8");
	
	int bidx = Integer.parseInt(request.getParameter("bidx"));	// 삭제할 글 번호
	
	int lidx = Integer.parseInt(request.getParameter("lidx"));	// 게시판 번호
	
	int writesortnum =  Integer.parseInt(request.getParameter("writesortnum"));	// 카테고리 넘버(글 조회할때만 사용)

	String nowPage = request.getParameter("nowPage");			// 페이지
	
	String searchType = request.getParameter("searchType");		// 검색 종류
	
	String searchValue = request.getParameter("searchValue");	// 검색 값
	
	Connection conn = null;
	PreparedStatement psmt = null;
	
	try{
		conn = DBManager.getConnection();
		String sql = "UPDATE assaboard SET delyn = 'Y' WHERE bidx = " + bidx;
		psmt = conn.prepareStatement(sql);
		psmt.executeUpdate();
		
		response.sendRedirect(request.getContextPath() + "/board/board_list.jsp?lidx=" + lidx +"&writesortnum=" + writesortnum + "&nowPage=" + nowPage + "&searchType=" + searchType + "&searchValue" + searchValue);
		
	} catch (Exception e) {
		e.printStackTrace();
	} finally{
		DBManager.close(conn, psmt);
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
%>