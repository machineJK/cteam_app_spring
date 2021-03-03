package com.hanul.tutors;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import board.BoardPage;
import board.BoardServiceImpl;
import board.BoardVO;
import common.CommonService;
import member.MemberServiceImpl;
import member.MemberVO;

@Controller
public class BoardController {
	@Autowired private BoardServiceImpl service;
	@Autowired private CommonService common;
	
	
	@Autowired MemberServiceImpl member;
	@Autowired BoardPage page;
	//글 목록 조회
	@RequestMapping("/list.bo")
	public String list(Model model, HttpSession session,
						@RequestParam(defaultValue = "1") int curPage, String search, String keyword) {
		
//		//관리자계정 임시저장 -----
//		HashMap<String, Object> map = new HashMap<String, Object>();
//		map.put("id", "admin");
//		map.put("pw", "Pwpw1234");
//		MemberVO vo = member.member_login(map);
//		session.setAttribute("loginInfo", vo);
//		
//		//-------------------------
		session.setAttribute("category", "bo");
		//DB에서 글목록 조회해서 목록화면에 출력
		page.setCurPage(curPage);
		page.setSearch(search);
		page.setKeyword("");
		keyword="";
		model.addAttribute("page", service.board_list(page));
		
		return "board/list";
	}
}
