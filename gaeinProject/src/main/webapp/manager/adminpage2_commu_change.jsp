<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="boardWeb.vo.*" %>
<%@ page import="boardWeb.util.*" %>
<%
	request.setCharacterEncoding("UTF-8");
	
	int lidx = Integer.parseInt(request.getParameter("lidx"));
		
	int	midx = Integer.parseInt(request.getParameter("midx"));

	int	beforemidx = Integer.parseInt(request.getParameter("beforemidx"));
	
	String listtitle = request.getParameter("listtitle");
	
	String sql = "";
	Connection conn = null;
	PreparedStatement psmt = null;
	ResultSet rs = null;
		
	try{
		
		conn = DBManager.getConnection();
		sql = "UPDATE assaboardlist SET listmastermidx =" + midx + " WHERE lidx =" + lidx;
		psmt = conn.prepareStatement(sql);
		psmt.executeUpdate();
		
		psmt = null;
		sql = "UPDATE assamember SET position = '" + listtitle + "장' WHERE midx=" + midx;
		psmt = conn.prepareStatement(sql);
		psmt.executeUpdate();
		
		psmt = null;
		sql = "UPDATE assamember SET position = '일반' WHERE midx=" + beforemidx;
		psmt = conn.prepareStatement(sql);
		psmt.executeUpdate();
		
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBManager.close(conn, psmt, rs);
	}
	
		
	
%>