<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="boardWeb.vo.*" %>
<%@ page import="boardWeb.util.*" %>
<%
	Member loginUser = (Member)session.getAttribute("loginUser");

	request.setCharacterEncoding("UTF-8");
	
	int lidx = Integer.parseInt(request.getParameter("lidx"));
	int bidx = 0;
	int midx = loginUser.getMidx();
	String writesort = request.getParameter("writesort");
	
	String subject = request.getParameter("subject").replace("<","&lt;");
	String nickname = loginUser.getNickname();
	String content = "";
	
	String commuTitle = "";
	String commuReason = "";
	String commuIntroduce = "";
	int commumalheadCnt = 0;
	String commumalhead[] = null;
	// 내용을 담는 과정
	if(lidx != 1 || !writesort.equals("커뮤신청")){	// 자유게시판&커뮤신청이 아닌경우
		
		content = request.getParameter("editordata");
		
	} else {
		commumalheadCnt = Integer.parseInt(request.getParameter("commumalheadCnt"));
		commumalhead = new String[commumalheadCnt];
		
		commuTitle = request.getParameter("commuTitle");
		commuIntroduce = request.getParameter("commuIntroduce");
		content += commuTitle + " - " + commuIntroduce;
		
		for(int i = 0; i < commumalhead.length; i++){
			commumalhead[i] = request.getParameter("commumalhead" + (i + 1));
			content += " - " + commumalhead[i];
		}
		
		commuReason = request.getParameter("commuReason");
		content += " - " + commuReason;
		
	}
	
	// DB연결 준비
	Connection conn = null;
	PreparedStatement psmt = null;
	ResultSet rs = null;
	
	// DB연결 후 쿼리 실행
	try{
		conn = DBManager.getConnection();
		
		String sql = "INSERT INTO assaboard(lidx, bidx, midx, writesort, subject, content) ";
				sql += "VALUES (?, b_bidx_seq.nextval, ?, ?, ?, ?)";		
		psmt = conn.prepareStatement(sql);
		psmt.setInt(1, lidx);
		psmt.setInt(2, midx);
		psmt.setString(3, writesort);
		psmt.setString(4, subject);
		psmt.setString(5, content);
		psmt.executeUpdate();
		
		if(lidx == 1 && writesort.equals("커뮤신청")){
			sql = "SELECT max(bidx) as bidx FROM assaboard";
			psmt = conn.prepareStatement(sql);
			rs = psmt.executeQuery();
			if(rs.next()){
				bidx = rs.getInt("bidx");
			}
			
			sql = "INSERT INTO assaboard_commuapply (bidx, midx, commutitle, listintroduce, ";
			
			for(int i = 0; i < commumalhead.length; i++){
			sql += "writesort" + (i + 1) + ", ";
			}
			
			sql += "commuReason, writesortcnt) ";
			
			
			sql += "VALUES (" + bidx + ", " + midx + ", '" + commuTitle + "', '" + commuIntroduce + "', '";
			
			for(int j = 0; j < commumalhead.length; j++){
				sql += commumalhead[j] + "', '";
			}
			
			sql += commuReason + "', " + commumalhead.length + ")";
			
			psmt = conn.prepareStatement(sql);
			psmt.executeUpdate();
		}
		
		response.sendRedirect(request.getContextPath() + "/board/board_list.jsp?lidx=" + lidx + "&writesortnum=0");
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBManager.close(conn, psmt, rs);
	}
	
	
%>