<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="boardWeb.util.*"%>
<%@ page import="boardWeb.vo.*"%>
<%@ page import="java.sql.*" %>
<%@ page import="org.json.simple.*"%>
<%
	request.setCharacterEncoding("UTF-8");

	String sql = "";
	Connection conn = null;
	PreparedStatement psmt = null;
	ResultSet rs = null;
	
	if(request.getParameter("ridx") == null){	// 댓글을 등록
		
		Member loginUser = (Member)session.getAttribute("loginUser");

		String rcontent = request.getParameter("rcontent").replace("<","&lt;");
		int lidx = Integer.parseInt(request.getParameter("lidx"));
		int bidx = Integer.parseInt(request.getParameter("bidx"));
		int midx = loginUser.getMidx();
		
		ReplyManager rwrite = new ReplyManager(lidx, bidx, midx, rcontent);
		
		JSONArray list = new JSONArray();
		JSONObject obj = new JSONObject();
		obj.put("ridx", rwrite.reply.getRidx());
		obj.put("midx", rwrite.reply.getMidx());
		obj.put("rcontent", rwrite.reply.getRcontent());
		obj.put("rdate", rwrite.reply.getRdate());
		obj.put("nickname", rwrite.reply.getNickname());
		obj.put("position", rwrite.reply.getPosition());
		list.add(obj);
		
		try{
			conn = DBManager.getConnection();
			
			sql = "SELECT * FROM assamember WHERE midx = " + loginUser.getMidx();
			psmt = conn.prepareStatement(sql);
			rs = psmt.executeQuery();
			if(rs.next()){
				Member member = new Member();
				
				member.setMidx(rs.getInt("midx"));
				member.setPoint(rs.getInt("point"));
				member.setNickname(rs.getString("nickname"));
				member.setPosition(rs.getString("position"));
				
				session.setAttribute("loginUser", member);
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			DBManager.close(conn, psmt, rs);
		}
		
		
		
		
		out.print(list.toJSONString());
		
	}else{
		if(request.getParameter("rcontent") != null){	// 댓글을 수정
			int ridx = Integer.parseInt(request.getParameter("ridx"));
			String rcontent = request.getParameter("rcontent");
			ReplyManager rmodify = new ReplyManager(ridx, rcontent);
		}else{	// 댓글을 삭제
			int ridx = Integer.parseInt(request.getParameter("ridx"));
			ReplyManager rmodify = new ReplyManager(ridx);
		}
	}
%>