<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="boardWeb.vo.*" %>
<%@ page import="boardWeb.util.*" %>
<%
	request.setCharacterEncoding("UTF-8");

	String commuintro = request.getParameter("intro");
	
	int lidx = Integer.parseInt(request.getParameter("lidx"));
	
	String sql = "";
	Connection conn = null;
	PreparedStatement psmt = null;
	
	try{
		
		conn = DBManager.getConnection();
		
		sql = "UPDATE assaboardlist SET LISTINTRODUCE = '" + commuintro + "' WHERE lidx = " + lidx;
		psmt = conn.prepareStatement(sql);
		psmt.executeUpdate();
		
		
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBManager.close(conn, psmt);
	}
	
%>