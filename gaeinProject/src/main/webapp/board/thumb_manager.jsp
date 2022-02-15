<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="boardWeb.util.*"%>
<%@ page import="boardWeb.vo.*"%>
<%@ page import="java.sql.*" %>
<%
	int bidx = Integer.parseInt(request.getParameter("bidx"));
	int midx = Integer.parseInt(request.getParameter("midx"));
	
	String sql = "";
	Connection conn = null;
	PreparedStatement psmt = null;
	ResultSet rs = null;
	
	try {
		
		conn = DBManager.getConnection();
		
		sql = "SELECT * FROM ASSATHUMBLIST WHERE bidx=? AND midx=?";
		psmt = conn.prepareStatement(sql);
		psmt.setInt(1, bidx);
		psmt.setInt(2, midx);
		rs = psmt.executeQuery();
		
		if(rs.next()){
			out.print("^^");
		}else{
			
			psmt = null;
			sql = "UPDATE ASSABOARD SET THUMB = THUMB + 1 WHERE bidx=?";
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, bidx);
			psmt.executeUpdate();
			
			psmt = null;
			sql = "INSERT INTO ASSATHUMBLIST VALUES(?,?)";
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, bidx);
			psmt.setInt(2, midx);
			psmt.executeUpdate();
			
			out.print("ok");
			
		}
		
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBManager.close(conn, psmt, rs);
	}
%>