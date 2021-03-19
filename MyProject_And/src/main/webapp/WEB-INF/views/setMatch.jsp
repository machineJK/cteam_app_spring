<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@page import="com.hanul.app.dto.MemberDTO"%>

<%@page import="com.google.gson.Gson"%>
<%@page import="com.google.gson.JsonObject"%>

<%@page import="org.springframework.ui.Model"%>
<%@page import="java.sql.*, java.sql.Date, javax.sql.*, javax.naming.*, 
					java.util.*, java.io.PrintWriter" %>

<%		
	String state = (String)request.getAttribute("setMatch");
	out.println(state);	
	
 	
%>