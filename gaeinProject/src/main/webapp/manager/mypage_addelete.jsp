<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@	page import="java.io.*"%>
<%@	page import="java.util.*"%>
<%@ page import="java.sql.*" %>
<%@ page import="boardWeb.vo.*" %>
<%@ page import="boardWeb.util.*" %>
<%@ page import="com.oreilly.servlet.*"%>
<%@	page import="com.oreilly.servlet.multipart.*"%>
<%	
	Member loginUser = (Member)session.getAttribute("loginUser");

	String sql = "";
	Connection conn = null;
	PreparedStatement psmt = null;
	
	try{
		
		conn = DBManager.getConnection();
		
		sql = "DELETE FROM assaad WHERE midx = " + loginUser.getMidx();
		psmt = conn.prepareStatement(sql);
		psmt.executeUpdate();
		
		
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBManager.close(conn, psmt);
	}
	
%>