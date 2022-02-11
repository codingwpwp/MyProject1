<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="boardWeb.vo.*" %>
<%@ page import="boardWeb.util.*" %>
<%
	request.setCharacterEncoding("UTF-8");

	int lidx = Integer.parseInt(request.getParameter("lidx"));

	String writesortval = request.getParameter("writesort");
	
	String num = request.getParameter("num");
	
	String sql = "";
	Connection conn = null;
	PreparedStatement psmt = null;
	ResultSet rs = null;
	
	String beforeWritesort = null;
	String writesort2 = null;
	String writesort3 = null;
	String writesort4 = null;
	String writesort5 = null;
	
	int changeSw = 1;
	
	try{
		
		conn = DBManager.getConnection();
		
		sql = "SELECT writesort" + num + " FROM assaboardlist WHERE lidx = " + lidx;
		psmt = conn.prepareStatement(sql);
		rs = psmt.executeQuery();
		if(rs.next()){
			beforeWritesort = rs.getString("writesort" + num);
		}
		
		
		sql = "SELECT * FROM assaboardlist WHERE lidx = " + lidx;
		psmt = conn.prepareStatement(sql);
		rs = psmt.executeQuery();
		if(rs.next()){
			writesort2 = rs.getString("writesort2");
			if(rs.getString("writesort3") != null) writesort3 = rs.getString("writesort3");
			if(rs.getString("writesort4") != null) writesort4 = rs.getString("writesort4");
			if(rs.getString("writesort5") != null) writesort5 = rs.getString("writesort5");
		}
		
		if(writesortval.equals(writesort2)){
			changeSw = 0;
			beforeWritesort = writesort2;
		}
		if(writesort3 != null && writesortval.equals(writesort3)){
			changeSw = 0;
			beforeWritesort = writesort3;
		}
		if(writesort4 != null && writesortval.equals(writesort4)){
			changeSw = 0;
			beforeWritesort = writesort4;
		}
		if(writesort5 != null && writesortval.equals(writesort5)){
			changeSw = 0;
			beforeWritesort = writesort5;
		}
		
		if(changeSw == 1){
			sql = "UPDATE assaboard SET WRITESORT = '" + writesortval + "' WHERE lidx = " + lidx + " AND writesort = '" + beforeWritesort + "'";
			psmt = conn.prepareStatement(sql);
			psmt.executeUpdate();
			
			sql = "UPDATE assaboardlist SET WRITESORT" + num + "='" + writesortval +"' WHERE lidx = " + lidx;
			psmt = conn.prepareStatement(sql);
			psmt.executeUpdate();
			out.print("성공");
		}else{
			out.print("실패");
		}
		
		
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBManager.close(conn, psmt, rs);
	}
	
%>