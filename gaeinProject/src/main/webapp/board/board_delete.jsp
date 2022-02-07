<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="boardWeb.vo.*" %>
<%@ page import="boardWeb.util.*" %>
<%
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
	String writesort = request.getParameter("writesort");
	
	ViewFilter view = new ViewFilter(1, bidx, "delete");
	
	response.sendRedirect(request.getContextPath() + "/jauboard/board_list.jsp?&writesort=" + writesort + "&nowPage=" + nowPage + "&searchType=" + searchType + "&searchValue" + searchValue);
%>