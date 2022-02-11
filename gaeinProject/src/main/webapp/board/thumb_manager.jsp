<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="boardWeb.util.*"%>
<%@ page import="boardWeb.vo.*"%>
<%@ page import="java.sql.*" %>
<%
	int lidx = Integer.parseInt(request.getParameter("lidx"));
	int bidx = Integer.parseInt(request.getParameter("bidx"));
	int midx = Integer.parseInt(request.getParameter("midx"));
	
	String sql = "";
	Connection conn = null;
	PreparedStatement psmt = null;
	ResultSet rs = null;
	
	try {
		
		conn = DBManager.getConnection();
		
		sql = "SELECT * FROM ASSATHUMBLIST WHERE lidx=? AND bidx=? AND midx=?";
		psmt = conn.prepareStatement(sql);
		psmt.setInt(1, lidx);
		psmt.setInt(2, bidx);
		psmt.setInt(3, midx);
		rs = psmt.executeQuery();
		
		if(rs.next()){
			out.print("이걸 뜯어본 당신은 행운아!");
		}else{
			
			psmt = null;
			sql = "UPDATE ASSABOARD SET THUMB = THUMB + 1 WHERE lidx=? AND bidx=?";
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, lidx);
			psmt.setInt(2, bidx);
			psmt.executeUpdate();
			
			psmt = null;
			sql = "INSERT INTO ASSATHUMBLIST VALUES(?,?,?)";
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, lidx);
			psmt.setInt(2, bidx);
			psmt.setInt(3, midx);
			psmt.executeUpdate();
			
			out.print("ok");
			
		}
		
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBManager.close(conn, psmt, rs);
	}
%>