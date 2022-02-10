<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="boardWeb.util.*"%>
<%@ page import="boardWeb.vo.*"%>
<%
	Member loginUser = (Member)session.getAttribute("loginUser");

	request.setCharacterEncoding("UTF-8");
	
	String pw = request.getParameter("pw");
	String nickname = request.getParameter("nickname");
	String email = "";
	if(request.getParameter("email") != null) email = request.getParameter("email");
	String gender = "";
	if(request.getParameter("gender") != null) gender = request.getParameter("gender");
	
	Connection conn = null;
	PreparedStatement psmt = null;
	ResultSet rs = null;
	
	try{
		
		conn = DBManager.getConnection();
		
		String sql = "UPDATE ASSAMEMBER SET pw='" + pw + "', nickname='" + nickname + "'";
		if(!email.equals("")){
			sql += ", email='" + email + "'";
		}
		if(!gender.equals("")){
			sql += ", gender='" + gender + "'";
		}
		sql += " WHERE midx = " + loginUser.getMidx();
		
		psmt = conn.prepareStatement(sql);
		psmt.executeUpdate();
		
		sql = "SELECT * FROM assamember WHERE midx = " + loginUser.getMidx();
		psmt = conn.prepareStatement(sql);
		rs = psmt.executeQuery();
		if(rs.next()){
			Member member = new Member();
			
			member.setMidx(rs.getInt("midx"));
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