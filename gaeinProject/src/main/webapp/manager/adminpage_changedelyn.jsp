<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="boardWeb.vo.*" %>
<%@ page import="boardWeb.util.*" %>
<%
	request.setCharacterEncoding("UTF-8");
	
	String delyn = request.getParameter("delyn");

	int midx = Integer.parseInt(request.getParameter("midx"));
	
	String sql = "";
	Connection conn = null;
	PreparedStatement psmt = null;
	
	try{
		
		conn = DBManager.getConnection();
		
		if(delyn.equals("N")){
			sql = "UPDATE assamember SET delyn = 'Y' WHERE midx=" + midx;
			psmt = conn.prepareStatement(sql);
			psmt.executeUpdate();
		}else{
			sql = "UPDATE assamember SET delyn = 'N' WHERE midx=" + midx;
			psmt = conn.prepareStatement(sql);
			psmt.executeUpdate();
		}
		
		
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBManager.close(conn, psmt);
	}
	
%>