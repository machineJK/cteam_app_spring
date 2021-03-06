package com.hanul.app.controller;

import java.io.File;
import java.io.UnsupportedEncodingException;
import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartRequest;

import com.hanul.app.command.AModifyCommand;
import com.hanul.app.command.AModifyNoCommand;
import com.hanul.app.command.ASelectBoardCommand;
import com.hanul.app.command.ASelectMultiCommand;
import com.hanul.app.command.ASelectMultiCommand2;
import com.hanul.app.command.AnBoard2Command;
import com.hanul.app.command.AnBoardCommand;
import com.hanul.app.command.AnCommand;
import com.hanul.app.command.AnIdCheckCommand;
import com.hanul.app.command.AnJoinCommand;
import com.hanul.app.command.AnLoginCommand;
import com.hanul.app.command.AnStudentAcceptCommand;
import com.hanul.app.command.AnStudentCommand;
import com.hanul.app.command.AnTeacherCommand;
import com.hanul.app.command.GetTokenCommand;
import com.hanul.app.command.MyTeacherDetail;
import com.hanul.app.command.ReadCountCommand;
import com.hanul.app.command.SelectCommentCommand;
import com.hanul.app.command.SetMatchCommand;
import com.hanul.app.command.SetTokenCommand;
import com.hanul.app.command.anAdminMatchingCommand;
import com.hanul.app.command.anBoardDeleteCommand;
import com.hanul.app.command.anBoardUpdateCommand;
import com.hanul.app.command.anMatchedCommand;
import com.hanul.app.command.anWantMatchingCommand;

import fcm.FcmUtil;



@Controller
public class AnController {

	AnCommand command;
		
	//학생 -> 선생
	@RequestMapping(value="/setMatch", method = {RequestMethod.GET, RequestMethod.POST} )
	public String setMatch(HttpServletRequest req, Model model) {
		
		System.out.println("setMatch()");
		
		String teacher_id = (String) req.getParameter("teacher_id");
		String teacher_nickname = (String) req.getParameter("teacher_nickname");
		String student_id = (String) req.getParameter("student_id");
		String student_nickname = (String) req.getParameter("student_nickname");
		
		model.addAttribute("teacher_id", teacher_id);
		model.addAttribute("teacher_nickname", teacher_nickname);
		model.addAttribute("student_id", student_id);
		model.addAttribute("student_nickname", student_nickname);
		

		command = new SetMatchCommand();
		command.execute(model);
		
		return "setMatch";
	}
	
	//선생이 학생 승인
	@RequestMapping(value="/anStudentAccept", method = {RequestMethod.GET, RequestMethod.POST} )
	public String anStudentAccept(HttpServletRequest req, Model model) {
		
		System.out.println("setMatch()");
		
		String teacher_id = (String) req.getParameter("teacher_id");
		String student_id = (String) req.getParameter("student_id");
		String check = (String) req.getParameter("check");
		
		model.addAttribute("teacher_id", teacher_id);
		model.addAttribute("student_id", student_id);
		model.addAttribute("check", check);
		
		command = new AnStudentAcceptCommand();
		command.execute(model);
		
		return "anStudentAccept";
	}
	
	
	//내가 등록한 선생님 정보 가져오기
	@RequestMapping(value="/myTeacherDetail", method = {RequestMethod.GET, RequestMethod.POST}  )
	public String myDetail(HttpServletRequest req, Model model){
		System.out.println("myTeacherDetail()");
		
		String id = (String) req.getParameter("id");
		
		model.addAttribute("id", id);
		
		command = new MyTeacherDetail();
		command.execute(model);
		
		return "myTeacherDetail";
	}
	
	
	//알림 보내기
	@ResponseBody @RequestMapping("/sendNoti")
	public void sendNotification(String id, String name, String content, HttpServletRequest request) {
		String title = "Tutors";
	    //long user_id, String user_type,
	    
		GetTokenCommand getToken = new GetTokenCommand();
		String token = getToken.execute(id);

	    FcmUtil fcmUtill = new FcmUtil();
	    fcmUtill.send_FCM(token, title, name,  content, request);
	}

	//token 세팅
	@RequestMapping(value="/setToken", method = {RequestMethod.GET, RequestMethod.POST} )
	public String setToken(HttpServletRequest req, Model model) {
		
		System.out.println("setToken()");
		
		String id = (String) req.getParameter("id");
		String token = (String) req.getParameter("token");
		
		model.addAttribute("id", id);
		model.addAttribute("token", token);
		

		command = new SetTokenCommand();
		command.execute(model);
		
		return "setToken";
	}
		
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
	
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );
		
		return "home";
	}
	

	
	//안드로이드에서 온 정보가 여기로 넘겨짐
	@RequestMapping(value="/anJoin", method = {RequestMethod.GET, RequestMethod.POST}  )
	public String anJoin(HttpServletRequest req, Model model){
		
		//안드로이드와 연결되어있는지 확인하기
		System.out.println("anJoin()");
		
		//한글 설정
		try {
			req.setCharacterEncoding("UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		} 		
		
		//받은 정보를 request방식으로 받기
		String id = (String) req.getParameter("id");
		String pw = (String) req.getParameter("pw");
		String nickname = (String) req.getParameter("nickname");
		String name = (String) req.getParameter("name");
		String gender = (String) req.getParameter("gender");
		String birth = (String) req.getParameter("birth");
		String email = (String) req.getParameter("email");
		String addr1 = (String) req.getParameter("addr1");
		String addr2 = (String) req.getParameter("addr2");
		String dbImgPath = (String) req.getParameter("dbImgPath");
		String kakao_login = (String) req.getParameter("kakao_login");
		String naver_login = (String) req.getParameter("naver_login");
		

		
//		//데이터가 제대로 연결되어 있는지 확인
//		System.out.println(id);
//		System.out.println(passwd);
//		System.out.println(name);
//		System.out.println(phonenumber);
//		System.out.println(address);
		
		//모델에 담기(그냥 하는것)
		model.addAttribute("id", id);
		model.addAttribute("pw", pw);
		model.addAttribute("nickname", nickname);
		model.addAttribute("name", name);
		model.addAttribute("gender", gender);
		model.addAttribute("birth", birth);
		model.addAttribute("email", email);
		model.addAttribute("addr1", addr1);
		model.addAttribute("addr2", addr2);
		model.addAttribute("dbImgPath", dbImgPath);	
		model.addAttribute("kakao_login", kakao_login);	
		model.addAttribute("naver_login", naver_login);	
		
		MultipartRequest multi = (MultipartRequest)req;
		MultipartFile file = multi.getFile("image");
		
		if(file != null) {
			String fileName = file.getOriginalFilename();
			System.out.println(fileName);
			
			// 디렉토리 존재하지 않으면 생성
			makeDir(req);	
				
			if(file.getSize() > 0){			
				String realImgPath = req.getSession().getServletContext()
						.getRealPath("/resources/");
				
				System.out.println( fileName + " : " + realImgPath);
				System.out.println( "fileSize : " + file.getSize());					
												
			 	try {
			 		// 이미지파일 저장
					file.transferTo(new File(realImgPath, fileName));										
				} catch (Exception e) {
					e.printStackTrace();
				} 
									
			}else{
				// 이미지파일 실패시
				fileName = "FileFail.jpg";
				String realImgPath = req.getSession().getServletContext()
						.getRealPath("/resources/" + fileName);
				System.out.println(fileName + " : " + realImgPath);
						
			}			
			
		}

		command = new AnJoinCommand();
		command.execute(model);
		
		return "anJoin";
	}
	
	
	public void makeDir(HttpServletRequest req){
		File f = new File(req.getSession().getServletContext()
				.getRealPath("/resources"));
		if(!f.isDirectory()){
		f.mkdir();
		}	
	}
	
	//안드로이드에서 온 로그인 정보(id,pw)
	@RequestMapping(value="/anLogin", method = {RequestMethod.GET, RequestMethod.POST}  )
	public String anLogin(HttpServletRequest request, Model model){
		System.out.println("anLogin()");
		try {
			request.setCharacterEncoding("UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		} 		
		
		String id = (String) request.getParameter("id");
		String pw = (String) request.getParameter("pw");
		
		//System.out.println(id);
		//System.out.println(passwd);
		
		model.addAttribute("id", id);
		model.addAttribute("pw", pw);
		
		command = new AnLoginCommand();
		command.execute(model);
		
		return "anLogin";
	}
	
	//아이디 체크
	@RequestMapping(value="/anIdCheck", method = {RequestMethod.GET, RequestMethod.POST}  )
	public String anIdCheck(HttpServletRequest request, Model model){
		System.out.println("anIdCheck()");
		try {
			request.setCharacterEncoding("UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		} 		
		
		String id = (String) request.getParameter("id");
		String mstWho = (String) request.getParameter("mstWho");
		
		//System.out.println(id);
		
		model.addAttribute("id", id);
		model.addAttribute("mstWho", mstWho);
		
		command = new AnIdCheckCommand();
		command.execute(model);
		
		return "anIdCheck";
	}
	
	//선생 등록
	@RequestMapping(value="/anTeacher", method = {RequestMethod.GET, RequestMethod.POST}  )
	public String anTeacher(HttpServletRequest request, Model model){
		System.out.println("anTeacher()");
		
		try {
			request.setCharacterEncoding("UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		} 		
		
		String teacher_id = (String) request.getParameter("teacher_id");
		String teacher_univ = (String) request.getParameter("teacher_univ");
		String teacher_major = (String) request.getParameter("teacher_major");
		String teacher_univnum = (String) request.getParameter("teacher_univnum");
		String teacher_subject = (String) request.getParameter("teacher_subject");
		String teacher_worktime = (String) request.getParameter("teacher_worktime");
		String teacher_pay = (String) request.getParameter("teacher_pay");
		String teacher_intro = (String) request.getParameter("teacher_intro");
		String teacher_image_path = (String) request.getParameter("teacher_image_path");
		String teacher_nickname = (String) request.getParameter("teacher_nickname");
		String teacher_addr = (String) request.getParameter("teacher_addr");
		
		model.addAttribute("teacher_id", teacher_id);
		model.addAttribute("teacher_univ", teacher_univ);
		model.addAttribute("teacher_major", teacher_major);
		model.addAttribute("teacher_univnum", teacher_univnum);
		model.addAttribute("teacher_subject", teacher_subject);
		model.addAttribute("teacher_worktime", teacher_worktime);
		model.addAttribute("teacher_pay", teacher_pay);
		model.addAttribute("teacher_intro", teacher_intro);
		model.addAttribute("teacher_image_path", teacher_image_path);
		model.addAttribute("teacher_nickname", teacher_nickname);
		model.addAttribute("teacher_addr", teacher_addr);
		//System.out.println(teacher_addr);
		command = new AnTeacherCommand();
		command.execute(model);
		
		return "anTeacher";
	}
	
	//선생 등록
	@RequestMapping(value="/anStudent", method = {RequestMethod.GET, RequestMethod.POST}  )
	public String anStudent(HttpServletRequest request, Model model){
		System.out.println("anStudent()");
		
		try {
			request.setCharacterEncoding("UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		} 		
		
		String student_id = (String) request.getParameter("student_id");
		String student_subject = (String) request.getParameter("student_subject");
		String student_grade = (String) request.getParameter("student_grade");
		String student_intro = (String) request.getParameter("student_intro");
		String student_image_path = (String) request.getParameter("student_image_path");
		String student_addr = (String) request.getParameter("student_addr");
		String student_nickname = (String) request.getParameter("student_nickname");
		
		model.addAttribute("student_id", student_id);
		model.addAttribute("student_subject", student_subject);
		model.addAttribute("student_grade", student_grade);
		model.addAttribute("student_intro", student_intro);
		model.addAttribute("student_image_path", student_image_path);
		model.addAttribute("student_addr",student_addr);
		model.addAttribute("student_nickname",student_nickname);
		
		command = new AnStudentCommand();
		command.execute(model);
		
		return "anStudent";
	}
	
	//선생 리스트뷰
	@RequestMapping(value="/anSelectMulti", method = {RequestMethod.GET, RequestMethod.POST}  )
	public String anSelectMulti(HttpServletRequest req, Model model){
		System.out.println("anSelectMulti()");
		
		command = new ASelectMultiCommand();
		command.execute(model);
		
		return "anSelectMulti";
	}
	
	//학생 리스트뷰
	@RequestMapping(value="/anSelectMulti2", method = {RequestMethod.GET, RequestMethod.POST}  )
	public String anSelectMulti2(HttpServletRequest req, Model model){
		System.out.println("anSelectMulti2()");
		
		command = new ASelectMultiCommand2();
		command.execute(model);
		
		return "anSelectMulti2";
	}
	
	//매칭희망 리스트뷰
	@RequestMapping(value="/anWantMatchingList", method = {RequestMethod.GET, RequestMethod.POST}  )
	public String anWantMatchingList(HttpServletRequest request, Model model){
		System.out.println("anSelectMulti2()");
		
		try {
			request.setCharacterEncoding("UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		} 	
		
		String id = (String) request.getParameter("id");
		model.addAttribute("id", id);
		
		command = new anWantMatchingCommand();
		command.execute(model);
		
		return "anWantMatching";
	}
	
	//매칭완료 리스트
	@RequestMapping(value="/MatchedList", method = {RequestMethod.GET, RequestMethod.POST}  )
	public String MatchedList(HttpServletRequest request, Model model){
		System.out.println("anSelectMulti2()");
		
		try {
			request.setCharacterEncoding("UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		} 	
		
		String id = (String) request.getParameter("id");
		model.addAttribute("id", id);
		
		command = new anMatchedCommand();
		command.execute(model);
		
		return "anMatched";
	}
	
	//관리자한테 매칭승인요청 리스트
	@RequestMapping(value="/anAdminMatchingList", method = {RequestMethod.GET, RequestMethod.POST}  )
	public String AdminMatchingList(HttpServletRequest request, Model model){
		System.out.println("anAdminMatchingList()");
		
		command = new anAdminMatchingCommand();
		command.execute(model);
		
		return "anAdminMatching";
	}
	

	//Modify 수정화면(성공)
	@RequestMapping(value="/anUpdateMulti", method = {RequestMethod.GET, RequestMethod.POST})
	public void anUpdateMulti(HttpServletRequest req, Model model) {
		System.out.println("anUpdateMulti()");
		
		try {
			req.setCharacterEncoding("UTF-8");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		String id = (String) req.getParameter("id");
		String pw = (String) req.getParameter("pw");
		String nickname = (String) req.getParameter("nickname");
		String email = (String) req.getParameter("email");
		String dbImgPath = (String) req.getParameter("dbImgPath");
		String pDbImgPath = (String) req.getParameter("pDbImgPath");
		
		System.out.println(id);
		System.out.println(pw);
		System.out.println(nickname);
		System.out.println(email);
		System.out.println("Sub1Update:dbImgPath " + dbImgPath);
		System.out.println("Sub1Update:pDbImgPath " + pDbImgPath);
		
		model.addAttribute("id", id);
		model.addAttribute("pw", pw);
		model.addAttribute("nickname", nickname);
		model.addAttribute("email", email);
		model.addAttribute("dbImgPath", dbImgPath);
		
		// 이미지가 서로 같으면 삭제하지 않고 다르면 기존이미지 삭제
				if(!dbImgPath.equals(pDbImgPath)){			
					
					String pFileName = req.getParameter("pDbImgPath").split("/")[req.getParameter("pDbImgPath").split("/").length -1];
					String delDbImgPath = req.getSession().getServletContext().getRealPath("/resources/" + pFileName);
					
					File delfile = new File(delDbImgPath);
					System.out.println(delfile.getAbsolutePath());
					
			        if(delfile.exists()) {
			        	boolean deleteFile = false;
			            while(deleteFile != true){
			            	deleteFile = delfile.delete();
			            }	            
			            
			        }//if(delfile.exists())
				
				}//if(!dbImgPath.equals(pDbImgPath))  
				
				MultipartRequest multi = (MultipartRequest)req;
				MultipartFile file = null;
				
				file = multi.getFile("image");
					
				if(file != null) {
					String fileName = file.getOriginalFilename();
					System.out.println(fileName);
					
					// 디렉토리 존재하지 않으면 생성
					makeDir(req);	
						
					if(file.getSize() > 0){			
						String realImgPath = req.getSession().getServletContext()
								.getRealPath("/resources/");
						
						System.out.println( fileName + " : " + realImgPath);
						System.out.println( "fileSize : " + file.getSize());					
														
					 	try {
					 		// 이미지파일 저장
							file.transferTo(new File(realImgPath, fileName));						
						} catch (Exception e) {
							e.printStackTrace();
						} 
											
					}else{
						fileName = "FileFail.jpg";
						String realImgPath = req.getSession().getServletContext()
								.getRealPath("/resources/" + fileName);
						System.out.println(fileName + " : " + realImgPath);
								
					}			
					
				}
				
				command = new AModifyCommand();
				command.execute(model);		
				
	}
	@RequestMapping(value="/anUpdateMultiNo", method = {RequestMethod.GET, RequestMethod.POST})
	public void anUpdateMultiNo(HttpServletRequest req, Model model) {
		System.out.println("anUpdateMultiNo()");
		
		try {
			req.setCharacterEncoding("UTF-8");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}  
		
		String id = (String) req.getParameter("id");
		String pw = (String) req.getParameter("pw");
		String nickname = (String) req.getParameter("nickname");
		String email = (String) req.getParameter("email");
		
		command = new AModifyNoCommand();
		command.execute(model);	
		
	}
	
	@RequestMapping(value="/anBoard", method = {RequestMethod.GET, RequestMethod.POST}  )
	public String anBoard(HttpServletRequest req, Model model){
		
		//�ȵ���̵�� ����Ǿ��ִ��� Ȯ���ϱ�
		System.out.println("anBoard()");
		
		//�ѱ� ����
		try {
			req.setCharacterEncoding("UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		} 		
		
		//���� ������ request������� �ޱ�
		String board_id = (String) req.getParameter("board_id");
		String board_nickname = (String) req.getParameter("board_nickname");
		String board_title = (String) req.getParameter("board_title");
		String board_content = (String) req.getParameter("board_content");
		String board_notice = (String) req.getParameter("board_notice");
		String brdDbImgPath = (String) req.getParameter("brdDbImgPath");
		String id_image_path = (String) req.getParameter("id_image_path");
		
		//�𵨿� ���(�׳� �ϴ°�)
		model.addAttribute("board_id", board_id);
		model.addAttribute("board_nickname", board_nickname);
		model.addAttribute("board_title", board_title);
		model.addAttribute("board_content", board_content);
		model.addAttribute("board_notice", board_notice);
		model.addAttribute("board_image_path", brdDbImgPath);
		model.addAttribute("id_image_path", id_image_path);
		
		MultipartRequest multi = (MultipartRequest)req;
		MultipartFile file = multi.getFile("brdImage");
		
		if(file != null) {			
			
			String fileName = file.getOriginalFilename();
			System.out.println(fileName);
			
			// ���丮 �������� ������ ����
			makeDir(req);	
				
			if(file.getSize() > 0){			
				String realImgPath = req.getSession().getServletContext()
						.getRealPath("/resources/");
				
				System.out.println( fileName + " : " + realImgPath);
				System.out.println( "fileSize : " + file.getSize());					
												
			 	try {
			 		// �̹������� ����
					file.transferTo(new File(realImgPath, fileName));										
				} catch (Exception e) {
					e.printStackTrace();
				} 
									
			}else{
				// �̹������� ���н�
				fileName = "FileFail.jpg";
				String realImgPath = req.getSession().getServletContext()
						.getRealPath("/resources/" + fileName);
				System.out.println(fileName + " : " + realImgPath);
						
			}			
			
		} 
		command = new AnBoardCommand();
		command.execute(model);
		
		return "anBoard";		
		
	}
	
	@RequestMapping(value="/anBoard2", method = {RequestMethod.GET, RequestMethod.POST}  )
	public String anBoard2(HttpServletRequest req, Model model){
		
		System.out.println("anBoard2()");
		
		try {
			req.setCharacterEncoding("UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		} 		
		
		String board_id = (String) req.getParameter("board_id");
		String board_nickname = (String) req.getParameter("board_nickname");
		String board_content = (String) req.getParameter("board_content");
		String board_notice = (String) req.getParameter("board_notice");
		String brdDbImgPath = null;
		String id_image_path = (String) req.getParameter("id_image_path");
		String isComment = (String) req.getParameter("isComment");
		String postOriginal = (String) req.getParameter("postOriginal");
		
		model.addAttribute("board_id", board_id);
		model.addAttribute("board_nickname", board_nickname);
		model.addAttribute("board_content", board_content);
		model.addAttribute("board_notice", board_notice);
		model.addAttribute("board_image_path", brdDbImgPath);
		model.addAttribute("id_image_path", id_image_path);
		model.addAttribute("isComment", isComment);
		model.addAttribute("postOriginal", postOriginal);
		
		command = new AnBoard2Command();
		command.execute(model);
		
		return "anBoard2";			
	}
	
	@RequestMapping(value="/anSelectBoard", method = {RequestMethod.GET, RequestMethod.POST}  )
	public String anSelectBoard(HttpServletRequest req, Model model){
		System.out.println("anSelectBoard()");
		
		command = new ASelectBoardCommand();
		command.execute(model);
		
		return "anSelectBoard";
	}
	
	//댓글 불러오기
	@RequestMapping(value="/anSelectComment", method = {RequestMethod.GET, RequestMethod.POST}  )
	public String anSelectComment(HttpServletRequest req, Model model){
		System.out.println("anSelectComment()");
		
		try {
			req.setCharacterEncoding("UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		
		String postOriginal = (String) req.getParameter("postOriginal");
		model.addAttribute("postOriginal", postOriginal);
		
		command = new SelectCommentCommand();
		command.execute(model);
		
		return "anSelectComment";
	}
	
	//조회수 증가
	@RequestMapping(value="/anBoardReadCount", method = {RequestMethod.GET, RequestMethod.POST})
	public void anBoardReadCount(HttpServletRequest req, Model model) {
		System.out.println("anBoardReadCount()");
		
		try {
			req.setCharacterEncoding("UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}  
		
		String qna_ref_num = (String) req.getParameter("qna_ref_num");
		model.addAttribute("qna_ref_num", qna_ref_num);
		
		command = new ReadCountCommand();
		command.execute(model);	
		
	}
	
	//게시글 삭제
	@RequestMapping(value="/anBoardDelete", method = {RequestMethod.GET, RequestMethod.POST})
	public void anBoardDelete(HttpServletRequest req, Model model) {
		System.out.println("anBoardDelete()");
		
		try {
			req.setCharacterEncoding("UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}  
		
		String qna_ref_num = (String) req.getParameter("qna_ref_num");
		String isComment,board_id;
		model.addAttribute("qna_ref_num", qna_ref_num);
		if((String)req.getParameter("qna_ref_num") != null) {
			isComment = (String) req.getParameter("isComment");
			board_id = (String) req.getParameter("board_id");
			model.addAttribute("isComment", isComment);
		}
		command = new anBoardDeleteCommand();
		command.execute(model);	
		
	}
	
	//게시글 수정
	@RequestMapping(value="/anBoardUpdate", method = {RequestMethod.GET, RequestMethod.POST})
	public void anBoardUpdate(HttpServletRequest req, Model model) {
		System.out.println("anBoardUpdate()");
		
		try {
			req.setCharacterEncoding("UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}  
		
		MultipartRequest multi = (MultipartRequest)req;
		if(multi.getFile("brdImage") != null) {	//새로운 사진
			System.out.println("사진 있는쪽");
			String qna_ref_num = (String) req.getParameter("qna_ref_num");
			String board_content = (String) req.getParameter("board_content");
			String brdDbImgPath = (String) req.getParameter("brdDbImgPath");
			
			model.addAttribute("qna_ref_num", qna_ref_num);
			model.addAttribute("board_content", board_content);
			model.addAttribute("board_image_path", brdDbImgPath);
			
			MultipartFile file = multi.getFile("brdImage");
			if(file != null) {			
				
				String fileName = file.getOriginalFilename();
				System.out.println(fileName);
				
				makeDir(req);	
					
				if(file.getSize() > 0){			
					String realImgPath = req.getSession().getServletContext()
							.getRealPath("/resources/");
					
					System.out.println( fileName + " : " + realImgPath);
					System.out.println( "fileSize : " + file.getSize());					
													
				 	try {
						file.transferTo(new File(realImgPath, fileName));										
					} catch (Exception e) {
						e.printStackTrace();
					} 
										
				}else{
					fileName = "FileFail.jpg";
					String realImgPath = req.getSession().getServletContext()
							.getRealPath("/resources/" + fileName);
					System.out.println(fileName + " : " + realImgPath);
							
				}			
				
				command = new anBoardUpdateCommand();
				command.execute(model);
				
			}
			
			
		}else {	//기존 사진
			String qna_ref_num = (String) req.getParameter("qna_ref_num");
			String board_content = (String) req.getParameter("board_content");
			
			model.addAttribute("qna_ref_num", qna_ref_num);
			model.addAttribute("board_content", board_content);
			
			command = new anBoardUpdateCommand();
			command.execute(model);		
		}

		
		
		
	}
	

	
	
	
}

