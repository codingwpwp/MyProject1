<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="boardWeb.util.*"%>
<%@ page import="boardWeb.vo.*"%>
<%
	request.setCharacterEncoding("UTF-8");
	String id = request.getParameter("id");
	String pw = request.getParameter("pw");
	
	Connection conn = null;
	PreparedStatement psmt = null;
	ResultSet rs = null;
	
	try{
		
		conn = DBManager.getConnection();
		String sql = "SELECT * FROM assamember WHERE id = ? AND pw = ? AND delyn = 'N'";
		psmt = conn.prepareStatement(sql);
		psmt.setString(1, id);
		psmt.setString(2, pw);
		rs = psmt.executeQuery();
		Member member = null;
		
		if(rs.next()){
			member = new Member();
			
			member.setMidx(rs.getInt("midx"));
			member.setPoint(rs.getInt("point"));
			member.setNickname(rs.getString("nickname"));
			member.setPosition(rs.getString("position"));
			
			session.setAttribute("loginUser", member);
		}
		
		if(member == null){
			response.sendRedirect(request.getContextPath());
		}else{
			response.sendRedirect(request.getContextPath());
		}
		
	} catch (Exception e) {
		e.printStackTrace();
	} finally{
		DBManager.close(conn, psmt, rs);
	}
%>