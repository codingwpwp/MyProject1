<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@	page import="java.io.*"%>
<%@	page import="java.util.*"%>
<%@ page import="com.oreilly.servlet.*"%>
<%@	page import="com.oreilly.servlet.multipart.*"%>
<%			
	String directory = "C:/test/";
	int maxSize = 1024 * 1024 * 100;	
	String encoding = "UTF-8";			
	MultipartRequest multipartRequest = new MultipartRequest(request, directory, maxSize, encoding, new DefaultFileRenamePolicy());
	
	String fileName = multipartRequest.getOriginalFileName("adimage");
	String fileRealName = multipartRequest.getFilesystemName("adimage");
	
	out.write("파일명 : " + fileName + "<br>");
	out.write("실제 파일명 : " + fileRealName + "<br>");
%>