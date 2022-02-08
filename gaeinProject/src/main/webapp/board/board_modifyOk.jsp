<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="boardWeb.vo.*" %>
<%@ page import="boardWeb.util.*" %>
<%
	Member loginUser = (Member)session.getAttribute("loginUser");

	request.setCharacterEncoding("UTF-8");
	
	int lidx = Integer.parseInt(request.getParameter("lidx"));	// 게시판 번호
	
	int bidx = Integer.parseInt(request.getParameter("bidx"));	// 글 번호
	
	int writesortnum =  Integer.parseInt(request.getParameter("writesortnum"));	// 카테고리 넘버(글 조회할때만 사용)
	
	String writesort = request.getParameter("writesort");		// 카테고리
	
	String searchType = request.getParameter("searchType");		// 검색 종류
	
	String searchValue = request.getParameter("searchValue");	// 검색 값
	
	String nowPage = request.getParameter("nowPage");			// 페이지
	
	String subject = request.getParameter("subject");
	
	String nickname = loginUser.getNickname();
	
	String content = "";
	
	// 커뮤신청인 경우
	String commuTitle = "";
	
	String commuIntroduce = "";
	
	String commuReason = "";
	
	int commumalheadCnt = 0;
	
	String commumalhead[] = null;
	
	// 글 수정전 변수에 값 대입
	if(!writesort.equals("커뮤신청")){
		content = request.getParameter("editordata");
	}else{
		
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
	
	// 글 수정
	try{
		conn = DBManager.getConnection();
		String sql = "UPDATE assaboard set writesort=?,subject=?,content=? WHERE bidx = " + bidx;
		psmt = conn.prepareStatement(sql);
		psmt.setString(1, writesort);
		psmt.setString(2, subject);
		psmt.setString(3, content);
		psmt.executeUpdate();
		
		if(writesort.equals("커뮤신청")){
			psmt = null;	
			sql = "UPDATE assaboard_commuapply set commutitle=?,LISTINTRODUCE=?,WRITESORTCNT=?,COMMUREASON=?";
			for(int i = 0; i < commumalhead.length; i++){
				sql += ",writesort" + (i + 1) + "='" + commumalhead[i] + "'";
			}
			for(int i = (commumalhead.length + 1); i <= 5; i++){
				sql += ", writesort" + i + " = NULL";
			}
			sql += " WHERE bidx = " + bidx;
			psmt = conn.prepareStatement(sql);
			psmt.setString(1,commuTitle);
			psmt.setString(2,commuIntroduce);
			psmt.setInt(3,commumalhead.length);
			psmt.setString(4,commuReason);
			psmt.executeUpdate();
		}
		
		response.sendRedirect(request.getContextPath() + "/board/board_view.jsp?lidx=" + lidx + "&bidx=" + bidx + "&writesortnum=" + writesortnum + "&nowPage=" + nowPage + "&searchType=" + searchType + "&searchValue" + searchValue);
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBManager.close(conn, psmt);
	}
%>