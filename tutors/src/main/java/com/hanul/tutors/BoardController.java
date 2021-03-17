package com.hanul.tutors;

import java.io.File;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
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
	
	//답글저장처리 요청
	@RequestMapping("/reply.bo")
	public String reply_insert(BoardVO vo) {
		service.board_comment_insert(vo);
		return "redirect:view.bo?id=" + vo.getBoard_num();
	}
	
	//댓글 삭제
	@RequestMapping("/deleteC.bo")
	public String deleteC(int board_num, HttpSession session, Model model) {
		//첨부파일이 있는 글의 경우 물리적 서버의 영역에서 파일을 삭제
		BoardVO vo = service.board_view(board_num);
		if( vo.getBoard_image_name()!=null  ) {
			File file = new File( session.getServletContext()
									.getRealPath("resources")
											+ "/" + vo.getBoard_image_path() );
			if( file.exists() ) file.delete();
		}
		//선택한 글을 DB에서 삭제한 후 목록화면으로 연결
		service.board_delete(board_num);
		
		model.addAttribute("page", page);
		model.addAttribute("url", "list.bo");
		return "redirect:list.bo?board_num=" + vo.getBoard_num();
	}
	//글 삭제 요청
	@RequestMapping("/delete.bo")
	public String delete(int board_num, HttpSession session, Model model) {
		//첨부파일이 있는 글의 경우 물리적 서버의 영역에서 파일을 삭제
		BoardVO vo = service.board_view(board_num);
		if( vo.getBoard_image_name()!=null  ) {
			File file = new File( session.getServletContext()
									.getRealPath("resources")
											+ "/" + vo.getBoard_image_path() );
			if( file.exists() ) file.delete();
		}
		//선택한 글을 DB에서 삭제한 후 목록화면으로 연결
		service.board_delete(board_num);
		
		model.addAttribute("page", page);
		model.addAttribute("url", "list.bo");
		return "board/redirect";
//		return "redirect:list.bo";
	}
	
	
	//글 수정 저장처리 요청
	@RequestMapping("/update.bo")
	public String update(BoardVO vo, String attach, HttpSession session, MultipartFile file, Model model) {
		BoardVO board = service.board_view(vo.getBoard_num());
		String uuid = session.getServletContext().getRealPath("resources")
						+ "/" + board.getBoard_image_path();
		//첨부파일 관련처리
		if( ! file.isEmpty() ) { //첨부파일 있는 경우
			vo.setBoard_image_name( file.getOriginalFilename() );
			vo.setBoard_image_path( common.fileUpload(session, file, "board") );
			
			//원래 첨부된 파일이 있었다면 서버에서 삭제
			if( board.getBoard_image_name() != null ) {
				File f = new File( uuid );
				if( f.exists() ) f.delete();
			}
		}else {
			//원래 첨부된 파일을 삭제/ 원래부터 첨부파일이 없는 경우
			if( attach.isEmpty() ) {
				if( board.getBoard_image_name() != null ) {
					File f = new File( uuid );
					if( f.exists() ) f.delete();
				}
				
			}else {
				//원래 첨부된 파일을 그대로 사용하는 경우
				vo.setBoard_image_name( board.getBoard_image_name() );
				vo.setBoard_image_path( board.getBoard_image_path() );
			}
		}
				
		//화면에서 입력한 정보를 DB에 변경 저장한 후 view 로 연결
		service.board_update(vo);
		
		model.addAttribute("url", "view.bo");
		model.addAttribute("id", vo.getBoard_num());
		return "board/redirect";
	}
	
	
	//글 수정화면 요청
	@RequestMapping("/modify.bo")
	public String modify(int id, Model model) {
		//해당 글의 정보를 DB에서 조회해와 수정화면에 출력
		model.addAttribute("vo", service.board_view(id));
		return "board/modify";
	}
	
	//글 내용 상세보기 화면 요청
	@RequestMapping("/view.bo")
	public String view(int id, Model model) {
		service.board_read(id);
		List<BoardVO> cvo = service.board_comment_list(id);
		//선택한 글의 정보를 DB에서 조회해와 보기화면에 출력
		model.addAttribute("vo", service.board_view(id));
		model.addAttribute("cvo", cvo);
		model.addAttribute("crlf", "\r\n");
		model.addAttribute("lf", "\n");
		model.addAttribute("page", page);
		return "board/view";
	}
	
	//신규 글 저장처리 요청
	@RequestMapping("/insert.bo")
	public String insert(BoardVO vo, MultipartFile file, HttpSession session) {
		MemberVO member = (MemberVO)session.getAttribute("loginInfo");
		vo.setBoard_id(member.getId());
		if(member.getId().equals("admin")){
			vo.setBoard_notice(1);
		}else {
			vo.setBoard_notice(0);
		}
		
		vo.setId_image_path(member.getDbimgpath());
		vo.setBoard_nickname(member.getNickname());
		if( ! file.isEmpty() ) {
			vo.setBoard_image_name( file.getOriginalFilename() );
			vo.setBoard_image_path( common.fileUpload(session, file, "board") );
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
						@RequestParam(defaultValue="10") int pageList,
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
		page.setKeyword(keyword);
		page.setPageList(pageList);
		model.addAttribute("realpath", session.getServletContext().getRealPath("resources"));
		model.addAttribute("page", service.board_list(page));
		model.addAttribute("crlf", "\r\n");
		model.addAttribute("lf", "\n");
		
		return "board/list";
	}
}
