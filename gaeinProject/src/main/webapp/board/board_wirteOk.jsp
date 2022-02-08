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
	
	String subject = request.getParameter("subject");
	String nickname = loginUser.getNickname();
	String content = "";
	
	String commuTitle = "";
	String commuReason = "";
	String commuIntroduce = "";
	
	int commumalheadCnt = Integer.parseInt(request.getParameter("commumalheadCnt"));
	String commumalhead[] = new String[commumalheadCnt];
	
	// 내용을 담는 과정
	if(lidx != 1 || !writesort.equals("커뮤신청")){	// 자유게시판&커뮤신청이 아닌경우
		
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
	
	// DB연결 준비
	Connection conn = null;
	PreparedStatement psmt = null;
	ResultSet rs = null;
	
	System.out.println(content);
	// DB연결 후 쿼리 실행
	try{
		conn = DBManager.getConnection();
		
		String sql = "INSERT INTO assaboard(lidx, bidx, midx, writesort, subject, content) ";
				sql += "VALUES (" + lidx + ", b_bidx_seq.nextval, " + midx + ", '" + writesort + "', '" + subject + "',";
				
				int i = 0;
				while(i < content.length()){
					
				}
				
				
				sql += ")";
		psmt = conn.prepareStatement(sql);
		psmt.executeUpdate();
		
		if(lidx == 1 && writesort.equals("커뮤신청")){
			sql = "SELECT b_bidx_seq.currval FROM DUAL";
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
			for(int i = 0; i < commumalhead.length; i++){
				sql += commumalhead[i] + "', '";
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