<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="boardWeb.vo.*" %>
<%@ page import="boardWeb.util.*" %>
<%
	Member loginUser = (Member)session.getAttribute("loginUser");

	request.setCharacterEncoding("UTF-8");
	int bidx = 0;
	int midx = loginUser.getMidx();
	String writesort = request.getParameter("writesort");
	String subject = request.getParameter("subject");
	String nickname = loginUser.getNickname();
	String content = "";
	String commuTitle = "";
	String commuIntroduce = "";
	String commuReason = "";
	int commumalheadCnt = Integer.parseInt(request.getParameter("commumalheadCnt"));
	String commumalhead[] = new String[commumalheadCnt];
	
	if(writesort.equals("notice")){
		writesort = "공지";
	}else if(writesort.equals("normal")){
		writesort = "일반";
	}else if(writesort.equals("qna")){
		writesort = "질문";
	}else if(writesort.equals("commuapply")){
		writesort = "커뮤신청";
	}
	
	if(!writesort.equals("커뮤신청")){
		content = request.getParameter("editordata");
	} else {
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
	Connection conn = null;
	PreparedStatement psmt = null;
	ResultSet rs = null;
	
	try{
		conn = DBManager.getConnection();
		String sql = "INSERT INTO jauboard(bidx, midx, writesort, subject, content) "
					+"VALUES (b_jau_bidx_seq.nextval,?,?,?,?)";
		
		psmt = conn.prepareStatement(sql);
		psmt.setInt(1, midx);
		psmt.setString(2, writesort);
		psmt.setString(3, subject);
		psmt.setString(4, content);
		psmt.executeUpdate();
		
		if(writesort.equals("커뮤신청")){
			psmt = null;
			sql = "SELECT max(bidx) as bidx FROM jauboard";
			psmt = conn.prepareStatement(sql);
			rs = psmt.executeQuery();
			if(rs.next()){
				bidx = rs.getInt("bidx");
			}
			
			psmt = null;
			sql = "INSERT INTO jauboard_commuapply(bidx, midx, commutitle, listintroduce, ";
			for(int i = 0; i < commumalhead.length; i++){
				sql += "writesort" + (i + 1) + ", ";
			}
			sql += "commuReason, writesortcnt) ";
			sql += "VALUES (" + bidx + ", " + midx + ", '" + commuTitle + "', '" + commuIntroduce + "', '";
			for(int i = 0; i < commumalhead.length; i++){
				sql += commumalhead[i] + "', '";
			}
			sql += commuReason + "', '" + commumalhead.length + "')";
			psmt = conn.prepareStatement(sql);
			psmt.executeUpdate();
		}
		
		
		response.sendRedirect(request.getContextPath() + "/jauboard/board_list.jsp");
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBManager.close(conn, psmt, rs);
	}
%>