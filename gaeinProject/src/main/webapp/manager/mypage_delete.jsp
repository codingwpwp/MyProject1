<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="boardWeb.util.*"%>
<%@ page import="boardWeb.vo.*"%>
<%
	Member loginUser = (Member)session.getAttribute("loginUser");
	
	Connection conn = null;
	PreparedStatement psmt = null;
	
	try{
		
		conn = DBManager.getConnection();
		String sql = "UPDATE assamember SET delyn='Y' WHERE midx = " + loginUser.getMidx();
		psmt = conn.prepareStatement(sql);
		psmt.executeUpdate();
		
		sql = "DELETE FROM assaad WHERE midx = " + loginUser.getMidx();
		psmt = conn.prepareStatement(sql);
		psmt.executeUpdate();
		
		session.invalidate();
		
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBManager.close(conn, psmt);
	}
%>