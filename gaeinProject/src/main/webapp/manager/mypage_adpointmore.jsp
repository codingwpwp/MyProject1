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
	int point = Integer.parseInt(request.getParameter("point"));

	String sql = "";
	Connection conn = null;
	PreparedStatement psmt = null;
	ResultSet rs = null;
	
	try{
		
		conn = DBManager.getConnection();
		
		sql = "UPDATE assaad SET point = point + " + point + " WHERE midx = " + loginUser.getMidx();
		psmt = conn.prepareStatement(sql);
		psmt.executeUpdate();
		
		sql = "UPDATE assamember SET point = point - " + point + " WHERE midx = " + loginUser.getMidx();
		psmt = conn.prepareStatement(sql);
		psmt.executeUpdate();
		
		sql = "SELECT * FROM assamember WHERE midx = " + loginUser.getMidx();
		psmt = conn.prepareStatement(sql);
		rs = psmt.executeQuery();
		if(rs.next()){
			Member member = new Member();
			
			member.setMidx(rs.getInt("midx"));
			member.setPoint(rs.getInt("point"));
			member.setNickname(rs.getString("nickname"));
			member.setPosition(rs.getString("position"));
			
			session.setAttribute("loginUser", member);
		}
		
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBManager.close(conn, psmt, rs);
	}
	
%>