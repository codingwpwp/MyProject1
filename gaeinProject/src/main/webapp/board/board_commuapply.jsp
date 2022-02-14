<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="boardWeb.vo.*" %>
<%@ page import="boardWeb.util.*" %>
<%
	request.setCharacterEncoding("UTF-8");
	
	int lidx = Integer.parseInt(request.getParameter("lidx"));	// 게시판 번호
	
	int bidx = Integer.parseInt(request.getParameter("bidx"));	// 글 번호

	Connection conn = null;
	PreparedStatement psmt = null;
	ResultSet rs = null;
	
	int midx = 0;
	int writesortcnt = 0;
	String commutitle = "";
	String listintroduce = "";
	String writesort1 = "";
	String writesort2 = "";
	String writesort3 = "";
	String writesort4 = "";
	String writesort5 = "";
	
	try{
		conn = DBManager.getConnection();
		
		
		// 커뮤신청테이블을 조회하는과정
		String sql = "SELECT * FROM assaboard_commuapply WHERE bidx = " + bidx;
		psmt = conn.prepareStatement(sql);
		rs = psmt.executeQuery();
		if(rs.next()){
			
			commutitle = rs.getString("COMMUTITLE");
			listintroduce = rs.getString("LISTINTRODUCE");
			midx = rs.getInt("MIDX");
			writesortcnt = rs.getInt("WRITESORTCNT");
			writesort1 = rs.getString("WRITESORT1");
			writesort2 = rs.getString("WRITESORT2");
			if(rs.getString("WRITESORT3") != null){
				writesort3 = rs.getString("WRITESORT3");
			}
			if(rs.getString("WRITESORT4") != null){
				writesort4 = rs.getString("WRITESORT4");
			}
			if(rs.getString("WRITESORT5") != null){
				writesort5 = rs.getString("WRITESORT5");
			}
			
		}
		// assaboardlist에 행을 추가하는 과정
		psmt = null;
		sql = "INSERT INTO ASSABOARDLIST(LIDX, listtitle, LISTTABLE, LISTMASTERMIDX, LISTINTRODUCE, WRITESORTCNT, WRITESORT1, WRITESORT2";
		if(!writesort3.equals("")){
			sql += ", WRITESORT3";
		}
		if(!writesort4.equals("")){
			sql += ", WRITESORT4";
		}
		if(!writesort5.equals("")){
			sql += ", WRITESORT5";
		}
		sql += ") VALUES(B_LIDX_SEQ.nextval, '" + commutitle + "', 'community' || (B_LIDX_SEQ.currval - 2), " + midx + ", '" + listintroduce + "', " + writesortcnt + ", '" +writesort1  + "', '" + writesort2 +"'";
		
		if(!writesort3.equals("")){
			sql += ", '"+ writesort3 + "'";
		}
		if(!writesort4.equals("")){
			sql += ", '"+ writesort4 + "'";
		}
		if(!writesort5.equals("")){
			sql += ", '"+ writesort5 + "'";
		}
		sql += ")";
		psmt = conn.prepareStatement(sql);
		rs = psmt.executeQuery();
		
		// 신청한 사람을 커뮤장등급으로 승격하는 과정
		sql = "UPDATE assamember SET POSITION = '" + commutitle + "장' WHERE midx = " + midx;
		psmt = conn.prepareStatement(sql);
		rs = psmt.executeQuery();
		
		sql = "UPDATE assaboard_commuapply SET OKYN = 'Y' WHERE midx = " + midx;
		psmt = conn.prepareStatement(sql);
		rs = psmt.executeQuery();
		
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBManager.close(conn, psmt, rs);
	}
	
%>