<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="boardWeb.util.*"%>
<%@ page import="java.sql.*" %>
<%@ page import="org.json.simple.*"%>
<%
	request.setCharacterEncoding("UTF-8");
	String id = request.getParameter("id");
	
	Connection conn = null;
	PreparedStatement psmt = null;
	ResultSet rs = null;
	
	try{
		conn = DBManager.getConnection();
		
		String sql = " SELECT id from assamember where id=?";
		psmt = conn.prepareStatement(sql);
		psmt.setString(1, id);
		rs = psmt.executeQuery();
		if(rs.next()){
			out.print(rs.getString("id"));
		} else {
			out.print("checkOk");
		}
		
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBManager.close(conn, psmt, rs);
	}
%>