<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="boardWeb.vo.*" %>
<%@ page import="boardWeb.util.*" %>
<%
	request.setCharacterEncoding("UTF-8");

	String commutitle = request.getParameter("commutitle");
	
	int lidx = Integer.parseInt(request.getParameter("lidx"));
	
	int midx = Integer.parseInt(request.getParameter("midx"));
	
	String sql = "";
	Connection conn = null;
	PreparedStatement psmt = null;
	ResultSet rs = null;
	ResultSet rsMidx = null;
	
	try{
		
		conn = DBManager.getConnection();
		
		sql = "SELECT listtitle FROM assaboardlist WHERE listtitle = '" + commutitle + "'";
		psmt = conn.prepareStatement(sql);
		rs = psmt.executeQuery();
		if(rs.next()){
			out.print("존재한다");
		}else{
			sql = "UPDATE assaboardlist SET listtitle = '" + commutitle + "' WHERE lidx = " + lidx;
			psmt = conn.prepareStatement(sql);
			psmt.executeUpdate();
			
			sql = "UPDATE ASSAMEMBER SET position = '" + commutitle + "장' WHERE midx = " + midx;
			psmt = conn.prepareStatement(sql);
			psmt.executeUpdate();
			
			Member member = null;
			
			sql = "SELECT * FROM ASSAMEMBER WHERE midx = " + midx;
			psmt = conn.prepareStatement(sql);
			rsMidx = psmt.executeQuery();
			
			if(rsMidx.next()){
				member = new Member();
				
				member.setMidx(rsMidx.getInt("MIDX"));
				member.setNickname(rsMidx.getString("NICKNAME"));
				member.setPosition(rsMidx.getString("POSITION"));
				
				session.setAttribute("loginUser", member);
			}
			
		}
		
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBManager.close(conn, psmt, rs, rsMidx);
	}
	
%>