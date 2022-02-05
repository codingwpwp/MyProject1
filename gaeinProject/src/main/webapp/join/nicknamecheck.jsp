<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="boardWeb.util.*"%>
<%@ page import="java.sql.*" %>
<%@ page import="org.json.simple.*"%>
<%
	request.setCharacterEncoding("UTF-8");
	String nickname = request.getParameter("nickname");
	
	Connection conn = null;
	PreparedStatement psmt = null;
	ResultSet rs = null;
	
	try{
		conn = DBManager.getConnection();
		
		String sql = " SELECT nickname FROM assamember WHERE nickname = ?";
		psmt = conn.prepareStatement(sql);
		psmt.setString(1, nickname);
		rs = psmt.executeQuery();
		if(rs.next()){
			out.print(rs.getString("nickname"));
		} else {
			out.print("ok");
		}
		
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBManager.close(conn, psmt, rs);
	}
%>