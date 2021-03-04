package com.hanul.tutors;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

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
	
	//신규 글 저장처리 요청
	@RequestMapping("/insert.bo")
	public String insert(BoardVO vo, MultipartFile file, HttpSession session) {
		MemberVO member = (MemberVO)session.getAttribute("loginInfo");
		vo.setBoard_id(member.getId());
		//첨부파일이 있다면 데이터객체에 파일정보를 담는다.
		if(!file.isEmpty()) {
			vo.setBoard_image_name(file.getOriginalFilename());
			vo.setBoard_image_path(common.fileUpload(session, file, "board"));
		}
		//화면에서 입력한 정보를 저장한 후 목록화면으로 연결
		service.board_insert(vo);
		return "redirect:list.bo";
	}
	
	
	//글 신규화면 요청
	@RequestMapping("/new.bo")
	public String board() {
		return "board/new";
	}
	
	
	
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
		model.addAttribute("page", service.board_list(page));
		
		return "board/list";
	}
}
