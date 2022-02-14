<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="boardWeb.vo.*" %>
<%@ page import="boardWeb.util.*" %>
<%
	request.setCharacterEncoding("UTF-8");

	int lidx = -1;
	if(request.getParameter("lidx") != null){
		lidx = Integer.parseInt(request.getParameter("lidx"));
	}	

	int midx = -1;
	if(request.getParameter("midx") != null){
		midx = Integer.parseInt(request.getParameter("midx"));
	}
	
	String id = "";
	if(request.getParameter("id") != null){
		id = request.getParameter("id");
	}
	
	String listtitle = "";
	if(request.getParameter("listtitle") != null){
		listtitle = request.getParameter("listtitle");
	}
	
	String check = request.getParameter("check");
	
	String sql = "";
	Connection conn = null;
	PreparedStatement psmt = null;
	ResultSet rs = null;
	
	if(check.equals("Y")){
		
		
		try{
			
			conn = DBManager.getConnection();
			
			sql = "SELECT midx FROM assamember WHERE id='" + id + "' AND delyn='N' AND position='일반'";
			psmt = conn.prepareStatement(sql);
			rs = psmt.executeQuery();
			if(rs.next()){
				out.print(rs.getInt("midx"));	// 무조건 문자열로 받아온다.
			}else{
				out.print(-1);
			}
			
			
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			DBManager.close(conn, psmt, rs);
		}
		
		
	}else if(check.equals("N")){
		
		
		try{
			
			conn = DBManager.getConnection();
			sql = "UPDATE assaboardlist SET listmastermidx=" + midx + ", delyn='N' WHERE listtitle='" + listtitle + "'";
			psmt = conn.prepareStatement(sql);
			psmt.executeUpdate();
			
			psmt = null;
			sql = "UPDATE assamember SET position = '" + listtitle + "장' WHERE midx=" + midx;
			psmt = conn.prepareStatement(sql);
			psmt.executeUpdate();
			
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			DBManager.close(conn, psmt, rs);
		}
		
		
	}
%>