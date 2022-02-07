<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="boardWeb.vo.*" %>
<%@ page import="boardWeb.util.*" %>
<%
	Member loginUser = (Member)session.getAttribute("loginUser");

	request.setCharacterEncoding("UTF-8");
	int bidx = Integer.parseInt(request.getParameter("bidx"));
	int nowPage = Integer.parseInt(request.getParameter("nowPage"));
	String searchType = request.getParameter("searchType");
	if(searchType == null){
		searchType = "";
	}
	String searchValue = request.getParameter("searchValue");
	if(searchValue == null){
		searchValue = "";
	}
	String writesort2 = request.getParameter("writesort2");
	
	String subject = request.getParameter("subject");
	String nickname = loginUser.getNickname();
	String content = "";
	String commuTitle = "";
	String commuIntroduce = "";
	String commuReason = "";
	int commumalheadCnt = 0;
	String commumalhead[] = null;
			
	String writesort = request.getParameter("writesort");
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
	Connection conn = null;
	PreparedStatement psmt = null;
	
	try{
		conn = DBManager.getConnection();
		String sql = "UPDATE jauboard set writesort=?,subject=?,content=? WHERE bidx = " + bidx;
		psmt = conn.prepareStatement(sql);
		psmt.setString(1, writesort);
		psmt.setString(2, subject);
		psmt.setString(3, content);
		psmt.executeUpdate();
		
		if(writesort.equals("커뮤신청")){
			psmt = null;	
			sql = "UPDATE jauboard_commuapply set commutitle=?,LISTINTRODUCE=?,WRITESORTCNT=?,COMMUREASON=?";
			for(int i = 0; i < commumalhead.length; i++){
				sql += ",writesort" + (i + 1) + "='" + commumalhead[i] + "'";
			}
			sql += " WHERE bidx = " + bidx;
			psmt = conn.prepareStatement(sql);
			psmt.setString(1,commuTitle);
			psmt.setString(2,commuIntroduce);
			psmt.setInt(3,commumalhead.length);
			psmt.setString(4,commuReason);
			psmt.executeUpdate();
		}
		
		response.sendRedirect(request.getContextPath() + "/jauboard/board_view.jsp?bidx=" + bidx + "&writesort=" + writesort2 + "&nowPage=" + nowPage + "&searchType=" + searchType + "&searchValue" + searchValue);
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBManager.close(conn, psmt);
	}
%>