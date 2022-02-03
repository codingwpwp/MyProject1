<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="boardWeb.util.*"%>
<%@ page import="boardWeb.vo.*"%>
<%
	request.setCharacterEncoding("UTF-8");
	String id = request.getParameter("id");
	String pw = request.getParameter("pw");
	String name = request.getParameter("name");
	String nickname = request.getParameter("nickname");
	String gender = request.getParameter("gender");
	String email = request.getParameter("email");
	
	Connection conn = null;
	PreparedStatement psmt = null;
	ResultSet rs = null;
	
	try{
		conn = DBManager.getConnection();
		String sql = "INSERT into assamember(midx, id, pw, membername, nickname, gender, email)"
					+"VALUES(b_midx_seq.nextval, ?, ?, ?, ?, ?, ?)";
		psmt = conn.prepareStatement(sql);
		psmt.setString(1, id);
		psmt.setString(2, pw);
		psmt.setString(3, name);
		psmt.setString(4, nickname);
		psmt.setString(5, gender);
		psmt.setString(6, email);
		
		int result = psmt.executeUpdate();
		if(result > 0){
			response.sendRedirect(request.getContextPath() + "/login/loginOk.jsp?id=" + id + "&pw=" + pw);
		}else{
			response.sendRedirect("join.jsp");
		}
		
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		
	}
%>

