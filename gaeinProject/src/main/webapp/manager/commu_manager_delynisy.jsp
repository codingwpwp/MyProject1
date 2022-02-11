<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="boardWeb.vo.*" %>
<%@ page import="boardWeb.util.*" %>
<%
	request.setCharacterEncoding("UTF-8");
	int lidx = Integer.parseInt(request.getParameter("lidx"));
	
	String[] stringBidx = request.getParameterValues("list");
	int[] bidxs = new int[stringBidx.length];
	for(int i = 0; i < bidxs.length; i++){
		bidxs[i] = Integer.parseInt(stringBidx[i]);
	}

	String sql = "";
	Connection conn = null;
	PreparedStatement psmt = null;
	
	try{
		
		conn = DBManager.getConnection();
		
		sql = "UPDATE assaboard SET delyn='N' WHERE";
		
		if(bidxs.length == 1){
			sql += " bidx = " + bidxs[0];
		}else{
			
			for(int i = 0; i < bidxs.length - 1; i++){
				sql += " bidx = " + bidxs[i] + " OR";
			}
			sql += " bidx = " + bidxs[bidxs.length - 1];
			
		}
		
		psmt = conn.prepareStatement(sql);
		psmt.executeUpdate();
		
		response.sendRedirect(request.getContextPath() + "/manager/commu_manager.jsp?lidx=" + lidx);
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBManager.close(conn, psmt);
	}
	
%>