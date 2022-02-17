<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="boardWeb.vo.*" %>
<%@ page import="boardWeb.util.*" %>
<%
	request.setCharacterEncoding("UTF-8");
	
	int lidx = Integer.parseInt(request.getParameter("lidx"));	// 게시판 번호
	
	int bidx = Integer.parseInt(request.getParameter("bidx"));	// 글 번호
	
	
	Commuapply commuapply = new Commuapply();
	Connection conn = null;
	PreparedStatement psmt = null;
	ResultSet rs = null;
	
	try{
		conn = DBManager.getConnection();
		
		
		// 커뮤신청테이블을 조회하는 과정
		String sql = "SELECT * FROM assaboard_commuapply WHERE bidx = " + bidx;
		psmt = conn.prepareStatement(sql);
		rs = psmt.executeQuery();
		if(rs.next()){
			
			commuapply.setCommuTitle(rs.getString("commutitle"));
			commuapply.setListIntroduce(rs.getString("listintroduce"));
			commuapply.setMidx(rs.getInt("midx"));
			commuapply.setWritesortcnt(rs.getInt("writesortcnt"));
			commuapply.setWritesort1(rs.getString("writesort1"));
			commuapply.setWritesort2(rs.getString("writesort2"));
			if(rs.getString("writesort3") != null) commuapply.setWritesort3(rs.getString("writesort3"));
			if(rs.getString("writesort4") != null) commuapply.setWritesort4(rs.getString("writesort4"));
			if(rs.getString("writesort5") != null) commuapply.setWritesort5(rs.getString("writesort5"));
			
		}
		// assaboardlist에 행을 추가하는 과정(게시판을 추가하는 과정)
		sql = "INSERT INTO assaboardlist(lidx, listtitle, listtable, listmastermidx, listintroduce, writesortcnt, writesort1, writesort2";
		if(commuapply.getWritesort3() != null){
			sql += ", writesort3";
		}
		if(commuapply.getWritesort4() != null){
			sql += ", writesort4";
		}
		if(commuapply.getWritesort5() != null){
			sql += ", writesort5";
		}
		sql += ") VALUES(b_lidx_seq.nextval, '" + commuapply.getCommuTitle() + "', 'community' || (b_lidx_seq.currval - 2), " + commuapply.getMidx() + ", ";
		sql += "'" + commuapply.getListIntroduce() + "', " + commuapply.getWritesortcnt() + ", '" + commuapply.getWritesort1()  + "', '" + commuapply.getWritesort2() +"'";
		if(commuapply.getWritesort3() != null) sql += ", '"+ commuapply.getWritesort3() + "'";
		if(commuapply.getWritesort4() != null) sql += ", '"+ commuapply.getWritesort4() + "'";
		if(commuapply.getWritesort5() != null) sql += ", '"+ commuapply.getWritesort5() + "'";
		
		sql += ")";
		psmt = conn.prepareStatement(sql);
		rs = psmt.executeQuery();
		
		// 신청한 사람을 커뮤장등급으로 승격하는 과정
		sql = "UPDATE assamember SET POSITION = '" + commuapply.getCommuTitle() + "장' WHERE midx = " + commuapply.getMidx();
		psmt = conn.prepareStatement(sql);
		rs = psmt.executeQuery();
		
		// 신청한 커뮤니티의 허가여부를 Y로 변경하는 과정
		sql = "UPDATE assaboard_commuapply SET OKYN = 'Y' WHERE midx = " + commuapply.getMidx();
		psmt = conn.prepareStatement(sql);
		rs = psmt.executeQuery();
		
		// 포인트 +30
		sql = "UPDATE assamember SET point = point + 30 WHERE midx = " + commuapply.getMidx();
		psmt = conn.prepareStatement(sql);
		psmt.executeUpdate();
		
		
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBManager.close(conn, psmt, rs);
	}
	
%>