<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="boardWeb.vo.*" %>
<%@ page import="boardWeb.util.*" %>
<%
	request.setCharacterEncoding("UTF-8");

	int lidx = Integer.parseInt(request.getParameter("lidx"));	// 게시판 번호
	int listmastermidx = Integer.parseInt(request.getParameter("listmastermidx"));
	
	Connection conn = null;
	PreparedStatement psmt = null;
	
	try{
		
		conn = DBManager.getConnection();
		
		String sql = "UPDATE assaboardlist SET delyn='Y', listmastermidx=0 WHERE lidx = " + lidx;
		psmt = conn.prepareStatement(sql);
		psmt.executeUpdate();
		
		psmt = null;
		sql = "UPDATE assamember SET position='일반' WHERE midx=" + listmastermidx;
		psmt = conn.prepareStatement(sql);
		psmt.executeUpdate();
		
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBManager.close(conn, psmt);
	}
%>