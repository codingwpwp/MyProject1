<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="boardWeb.vo.*" %>
<%@ page import="boardWeb.util.*" %>
<%
	request.setCharacterEncoding("UTF-8");
	int bidx = Integer.parseInt(request.getParameter("bidx"));
	int nowPage = Integer.parseInt(request.getParameter("nowPage"));
	String writesort = request.getParameter("writesort");
	String searchType = request.getParameter("searchType");
	String searchValue = request.getParameter("searchValue");
	
	Connection conn = null;
	PreparedStatement psmt = null;
	Statement smt = null;
	ResultSet rs = null;
	ResultSet rs2 = null;
	
	int midx = 0;
	String commutitle = "";
	
	try{
		conn = DBManager.getConnection();
		
		// 커뮤신청에 있는 글을 호출하는 과정
		String sql = "SELECT * FROM JAUBOARD_COMMUAPPLY WHERE bidx = " + bidx;
		psmt = conn.prepareStatement(sql);
		rs = psmt.executeQuery();
		if(rs.next()){
			
			midx = rs.getInt("midx");
			commutitle = rs.getString("COMMUTITLE");
			
			// boardlist에 신청한 커뮤니티를 추가하는 과정
			psmt = null;
			sql = "INSERT INTO boardlist(lidx, listtitle, listtable, listmastermidx, LISTINTRODUCE, writesortcnt";
			for(int i = 0; i < rs.getInt("WRITESORTCNT"); i++){
				sql += ", writesort" + (i + 1);
			}
			sql += ") ";
			sql += "VALUES(b_lidx_seq.NEXTVAL, '" + commutitle + "', 'community' || b_lidx_seq.CURRVAL, " + midx + ", '" + rs.getString("LISTINTRODUCE") + "', " + rs.getInt("WRITESORTCNT");
			for(int i = 0; i < rs.getInt("WRITESORTCNT"); i++){
				sql += ", '" + rs.getString("writesort" + (i + 1)) + "'";
			}
			sql += ")";
			psmt = conn.prepareStatement(sql);
			psmt.executeUpdate();
			
			// 테이블을 추가하는 과정
			psmt = null;
			sql = "CREATE TABLE " + rs.getString("commutitle") + "( ";
			sql += "bidx NUMBER PRIMARY KEY,";
			sql += "midx NUMBER NOT NULL,";
			sql += "write";
			sql += ")";
			
		}
		
		
		
		
		
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBManager.close(conn, psmt, smt, rs);
		if(rs2 != null){
			rs2.close();
		}
	}
	
	response.sendRedirect(request.getContextPath() + "/jauboard/board_list.jsp?&writesort=" + writesort + "&nowPage=" + nowPage + "&searchType=" + searchType + "&searchValue" + searchValue);
%>