<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="boardWeb.vo.*" %>
<%@ page import="boardWeb.util.*" %>
<%
	request.setCharacterEncoding("UTF-8");

	String commutitle = request.getParameter("commutitle");

	Connection conn = null;
	PreparedStatement psmt = null;
	ResultSet rs = null;
	
	try{
		
		conn = DBManager.getConnection();
		
		String sql = "SELECT listtitle FROM ASSABOARDLIST WHERE listtitle = '" + commutitle + "'";
		psmt = conn.prepareStatement(sql);
		rs = psmt.executeQuery();
		if(rs.next()){
			out.print("exist");
		}else{
			out.print("이걸 본 당신은 올 한해 복으로 가득찰 것입니다^^");
		}
		
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBManager.close(conn, psmt, rs);
	}
	
%>