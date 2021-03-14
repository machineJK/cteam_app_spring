package com.hanul.tutors;

import java.io.File;
import java.util.HashMap;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;


import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import board.BoardVO;
import common.CommonService;
import match.StudentVO;
import match.TeacherVO;
import member.MemberServiceImpl;
import member.MemberVO;

@Controller
public class MemberController {
	@Autowired private MemberServiceImpl service;
	@Autowired private CommonService common;
	
	
	@RequestMapping("/login")
	public String login(HttpSession session) {
		session.setAttribute("category", "login");
		return "member/login";
	}
	
	@ResponseBody @RequestMapping("/tutorlogin")
	public boolean login(String id, String pw, HttpSession session) {
		//화占썽에占쏙옙 占쌉뤄옙占쏙옙 占쏙옙占싱듸옙/占쏙옙占쏙옙占� 占쏙옙치占싹댐옙 회占쏙옙占쏙옙占쏙옙占쏙옙 占쏙옙회占쌔온댐옙
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("id", id);
		map.put("pw", pw);
		MemberVO vo = service.member_login(map);
		//占싸깍옙占쏙옙占쏙옙 회占쏙옙占쏙옙占쏙옙占쏙옙 占쏙옙占실울옙 占쏙옙틉畇占�
		session.setAttribute("loginInfo", vo);
		return vo==null ? false : true;
	}	
	
	private String naver_client_id = "qu_lR9gmMvoSzs_ljPzw";
	private String kakao_client_id = "77c939760d65450e90e8ae736d73979b";
	
	//카카占쏙옙占싸깍옙占싸울옙청
	@RequestMapping("/kakaologin")
	public String kakaologin(HttpSession session) {
		// https://kauth.kakao.com/oauth/authorize?client_id={REST_API_KEY}
		//&redirect_uri={REDIRECT_URI}
		//&response_type=code
		String state = UUID.randomUUID().toString();
		session.setAttribute("state", state);
		
		StringBuffer url = new StringBuffer(
			"https://kauth.kakao.com/oauth/authorize?response_type=code");
		url.append("&client_id=").append( kakao_client_id );
		url.append("&state=").append(state);
		url.append("&redirect_uri=").append("http://localhost:8080/tutors/kakaocallback");
		
		return "redirect:" + url.toString();
	}
	
	@RequestMapping("/kakaocallback")
	public String kakaocallback(HttpSession session, String state
								, String code, String error, Model model) {
		if( !state.equals( (String)session.getAttribute("state") ) 
				|| error!=null )
			return "redirect:/";
		
		//占쏙옙큰 占쌩급받깍옙
		StringBuffer url = new StringBuffer(
			"https://kauth.kakao.com/oauth/token?grant_type=authorization_code");
		url.append("&client_id=").append(kakao_client_id);
//		url.append("&client_secret=").append("K1N91CKhB2");
		url.append("&code=").append(code);
		url.append("&state=").append(state);
	
		JSONObject json = new JSONObject( common.requestAPI(url) );
		String token_type = json.getString("token_type");
		String access_token = json.getString("access_token");
		
//		curl -v -X POST "https://kauth.kakao.com/oauth/token" \
//		 -d "grant_type=authorization_code" \
//		 -d "client_id={REST_API_KEY}" \
//		 -d "redirect_uri={REDIRECT_URI}" \
//		 -d "code={AUTHORIZATION_CODE}
	
//		curl -v -X GET "https://kapi.kakao.com/v2/user/me" \
//		  -H "Authorization: Bearer {ACCESS_TOKEN}"
		
		//占쏙옙占쏙옙占쏙옙占쏙옙占� 占쏙옙占쏙옙占쏙옙占쏙옙
		url = new StringBuffer("https://kapi.kakao.com/v2/user/me");
		json = new JSONObject(
				common.requestAPI(url, token_type+" "+access_token) );
		if( !json.isEmpty() ) {
			MemberVO vo = new MemberVO();
			vo.setKakao_login("1");
			vo.setNaver_login("0");
			vo.setId( json.get("id").toString() );
			//System.out.println(json);
			json = json.getJSONObject("kakao_account");
			vo.setEmail(json.getString("email"));
			String gender 
			= json.has("gender") ? json.getString("gender") : "male";
			vo.setGender( gender.equals("female") ? "여자" : "남자" );
		
			json = json.getJSONObject("profile");
			vo.setNickname( json.getString("nickname") );
			vo.setName( json.getString("nickname") );
			//카카占쏙옙 占싸깍옙占쏙옙 占쏙옙占쏙옙占쏙옙 DB占쏙옙 占쏙옙占쏙옙占쏙옙 update, 占쏙옙占쏙옙占쏙옙 insert
			
			if( service.member_social_id(vo) ) { //id占쏙옙 占쏙옙占쏙옙占쏙옙 update
				service.member_social_update(vo);
				session.setAttribute("loginInfo", vo);
			}else { //id占쏙옙 占쏙옙占쏙옙占쏙옙 insert
				service.member_social_insert(vo);
				//model.addAttribute("needInfo", vo);
				session.setAttribute("loginInfo", vo);
				
			}
		}
		return "redirect:/";
		
	}
	
	@RequestMapping("/kakaoNaverExtra")
	public String kakaoExtra() {
		return "member/kakaoNaverExtra";
	}
	
	@RequestMapping("/insertKakaoNaverExtra")
	public String insertKakao(MemberVO vo, MultipartFile file, HttpSession session) {
		if( ! file.isEmpty() ) {
			vo.setDbimgpath( common.fileUpload(session, file, "notice") );
		}
		service.updateKakaoNaverExtra(vo);
		session.setAttribute("loginInfo", service.member_select(vo.getId()));
		return "redirect:/teacherjoin";
	}
	
	//占쏙옙占싱뱄옙占싸깍옙占싸울옙청
	@RequestMapping("/naverlogin")
	public String naverlogin(HttpSession session) {
		//https://nid.naver.com/oauth2.0/authorize?
		//response_type=code&client_id=CLIENT_ID
		//&state=STATE_STRING&redirect_uri=CALLBACK_URL
		
		//UUID 占쏙옙 占쏙옙占쏙옙占쏙옙占쌘몌옙 占쏙옙占쏙옙
		String state = UUID.randomUUID().toString();
		session.setAttribute("state", state);
		
		StringBuffer url = new StringBuffer(
			"https://nid.naver.com/oauth2.0/authorize?response_type=code");
		url.append("&client_id=").append(naver_client_id);
		url.append("&state=").append(state);
		url.append("&redirect_uri=").append("http://localhost:8080/tutors/navercallback");
		
		
		return "redirect:" + url.toString();
	}
	
	@RequestMapping("/navercallback")
	public String navercallback(HttpSession session, String state
								, String code, String error) {
		//占쏙옙占쏙옙 占쏙옙큰占쏙옙 占쏙옙치占쏙옙占쏙옙 占십거놂옙 占쌥뱄옙占쏙옙鈞占� 占쏙옙占쏙옙 占쌩삼옙占쏙옙 占쏙옙큰占쏙옙 占쌩급뱄옙占쏙옙 占쏙옙 占쏙옙占쏙옙 --> 홈占쏙옙占쏙옙
		if( !state.equals((String)session.getAttribute("state"))
				|| error!=null ) return "redirect:/";
		//占쏙옙占쏙옙처占쏙옙: code 占쏙옙占쏙옙 占쏙옙占쏙옙
		//占쏙옙占쏙옙占쏙옙큰占쏙옙 占쌩급받깍옙 占쏙옙占쏙옙 占쏙옙청
		//https://nid.naver.com/oauth2.0/token?grant_type=authorization_code
		//&client_id=?&client_secret=?&code=?&state=? 
		StringBuffer url = new StringBuffer(
			"https://nid.naver.com/oauth2.0/token?grant_type=authorization_code");
		url.append("&client_id=").append(naver_client_id);
		url.append("&client_secret=").append("wEn47tjU6x");
		url.append("&code=").append(code);
		url.append("&state=").append(state);
		JSONObject json = new JSONObject( common.requestAPI(url) );
		String access_token = json.getString("access_token");
		String token_type = json.getString("token_type");
		
		//占쏙옙占쏙옙占� 占쏙옙占쏙옙占쏙옙占쏙옙占쏙옙 占쏙옙회
		//占쏙옙청URL: https://openapi.naver.com/v1/nid/me
		//占쏙옙청占쏙옙占�: Authorization: {占쏙옙큰 타占쏙옙] {占쏙옙占쏙옙 占쏙옙큰]
		
		url = new StringBuffer("https://openapi.naver.com/v1/nid/me");
		json = new JSONObject( common.requestAPI(url, token_type+" "+access_token) );
		//resultcode, message, response
		
		if( json.getString("resultcode").equals("00")) {
			//System.out.println(json);
			json = json.getJSONObject("response");
			//email, nickname, ...
			MemberVO vo = new MemberVO();
			vo.setKakao_login("0");
			vo.setNaver_login("1");
			vo.setId(json.getString("id"));
			vo.setGender( json.has("gender") 
					    ? ( json.getString("gender").equals("F") ? "여자" :"남자" ) 
					    : "占쏙옙占쏙옙");
			vo.setName(json.has("name") ? json.getString("name") : json.getString("nickname"));
			vo.setNickname(json.has("nickname") ? json.getString("nickname") : json.getString("name"));
			vo.setEmail( json.getString("email") );
			
			//占쏙옙占싱뱄옙占싸깍옙占쏙옙占쏙옙 처占쏙옙占싱띰옙占� insert占싹곤옙, 占싣니몌옙 update
			//占쌔댐옙 占쏙옙占싱뱄옙占쏙옙占싱듸옙 占쏙옙占쏙옙占싹댐옙占쏙옙占쏙옙 占쏙옙占쏙옙 占식억옙
			if( service.member_social_id(vo) ) { //占쏙옙占싱듸옙 占쏙옙占쏙옙占�
				service.member_social_update(vo);
			}else {
				service.member_social_insert(vo);	
			}
			session.setAttribute("loginInfo", vo);
		}
		return "redirect:/";
	}
	
	//占싸그아울옙처占쏙옙 占쏙옙청
	@RequestMapping("/logout")
	public String logout(HttpSession session) {
		
		String kakao_login 
		= ((MemberVO)session.getAttribute("loginInfo")).getKakao_login();
		session.removeAttribute("loginInfo");
		
//		GET /oauth/logout
		//?client_id=?
		//&logout_redirect_uri=?
		//&state=? HTTP/1.1
//				Host: kauth.kakao.com
		//카카占쏙옙占싸깍옙占쏙옙占쏙옙 占쏙옙占� 카카占쏙옙占쏙옙占쏙옙占쏙옙 占쌉뀐옙 占싸그아울옙占실곤옙 占쏙옙占쏙옙
		if( kakao_login!=null && kakao_login.equals("1") ) {
			StringBuffer url = new StringBuffer(
					"https://kauth.kakao.com/oauth/logout"); 
			url.append("?client_id=").append(kakao_client_id);
			url.append("&logout_redirect_uri=")
						.append("http://localhost:8080/tutors");
			return "redirect:" + url.toString();
		}else
			return "redirect:/";
	}
	
	//����媛��� ��硫� �대��
	@RequestMapping("/member")
	public String member(HttpSession session) {
		session.setAttribute("category", "join");
		return "member/join";
	}
	
	//���대�� 以�蹂듭껜��
	@ResponseBody @RequestMapping("/id_check")
	public boolean id_check(String id) {
		return service.member_id_check(id);
	}
	
	//����媛���
	@RequestMapping("/join")
	public String join(MemberVO vo, MultipartFile file, HttpSession session) {
		//泥⑤��� ���쇱�� ���ㅻ㈃ �곗�댄�곌�泥댁�� ���쇱��蹂대�� �대����
		if( ! file.isEmpty() ) {
			//vo.setFilename( file.getOriginalFilename() );
			vo.setDbimgpath( common.fileUpload(session, file, "notice") );
		}
		//��硫댁���� ���ν�� ��蹂대�� DB�� ���ν�� �� 紐⑸���硫댁�쇰� �곌껐
		service.member_join(vo);
		//return "redirect:/";
		return "redirect:/";
	}
	
	//선생님 등록하기 창 이동
	@RequestMapping("/teacherjoin")
	public String teacherjoin() {
		return "member/teacherjoin";
	}

	//학생 등록하기 창 이동
	@RequestMapping("/studentjoin")
	public String studentjoin() {
		return "member/studentjoin";
	}
	
	//선생 가입
	@RequestMapping("/teacher_join")
	public String teacher_join(TeacherVO vo) {
		service.teacher_join(vo);
		return "redirect:/list.match";
	}

	//학생 가입
	@RequestMapping("/student_join")
	public String student_join(StudentVO vo) {
		service.student_join(vo);
		return "redirect:/list.match";
	}
	
	//선생 가입 중복 확인
	@ResponseBody @RequestMapping("/teacher_check")
	public boolean teacher_check(String id) {
		return service.teacher_check(id);
	}
	
	//학생 가입 중복 확인
	@ResponseBody @RequestMapping("/student_check")
	public boolean student_check(String id) {
		return service.student_check(id);
	}
	
	//占쏙옙占쏙옙占쏙옙占쏙옙 화占쏙옙 占쏙옙청
	@RequestMapping("/profile.pro")
	public String select(Model model, String id, HttpSession session) {
		session.setAttribute("category", "pro");
		model.addAttribute("vo", service.member_select(id) );
		return "member/profile";
	}
	
	//占쏙옙占쏙옙占쏙옙占쏙옙 占쏙옙占쏙옙화占쏙옙 占쏙옙청
	@RequestMapping("/modify.pro")
	public String modify(String id, Model model) {
		model.addAttribute("vo", service.member_select(id));
		return "member/modify";
	}

	@RequestMapping("/update.pro") 
	public String update(MemberVO vo, MultipartFile file
						, HttpSession session) {
		MemberVO member = service.member_select(vo.getId());
		String realFile = session.getServletContext().getRealPath("resources")
						+ "/" + member.getDbimgpath();
		
		if( !file.isEmpty() ) { 
			//파일을 첨부한 경우: 원래 없었는데 신규 첨부, 원래 있었던거 바꿔 첨부
			vo.setFilename( file.getOriginalFilename() );
			vo.setDbimgpath( common.fileUpload(session, file, "notice"));
			//원래 첨부된 파일이 있다면 물리적영역에서 파일을 삭제
			if( member.getFilename()!=null ) {
				File f = new File(realFile);
				if( f.exists() ) f.delete();
			}
			
		}else {

				//원래 첨부된 파일을 그대로 사용하는 경우
				//vo.setFilename( member.getFilename() );
				vo.setDbimgpath( member.getDbimgpath() );
			
		}
		//화면에서 입력한 정보를 DB에 변경저장한 후 보기화면으로 연결
		service.member_update(vo);
		return "redirect:profile.pro?id=" + vo.getId();
		
	}
	
	@ResponseBody @RequestMapping("/isKakaoNaverPw")
	public boolean isKakaoNaverPw(MemberVO vo) {
		return service.isKakaoNaverPw(vo);
	}
		
		
}
