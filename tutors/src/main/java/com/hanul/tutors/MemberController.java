package com.hanul.tutors;

import java.util.HashMap;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import common.CommonService;
import member.MemberServiceImpl;
import member.MemberVO;

@Controller
public class MemberController {
	@Autowired private MemberServiceImpl service;
	
	//�α��� ������ �� ȭ���̵�
	@RequestMapping("/login")
	public String login(HttpSession session) {
		session.setAttribute("category", "login");
		return "member/login";
	}
	
	@ResponseBody @RequestMapping("/tutorlogin")
	public boolean login(String id, String pw, HttpSession session) {
		//ȭ�鿡�� �Է��� ���̵�/����� ��ġ�ϴ� ȸ�������� ��ȸ�ؿ´�
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("id", id);
		map.put("pw", pw);
		MemberVO vo = service.member_login(map);
		//�α����� ȸ�������� ���ǿ� ��Ƶд�
		session.setAttribute("loginInfo", vo);
		return vo==null ? false : true;
	}	
	
	private String naver_client_id = "qu_lR9gmMvoSzs_ljPzw";
	private String kakao_client_id = "77c939760d65450e90e8ae736d73979b";
	
	//īī���α��ο�û
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
								, String code, String error) {
		if( !state.equals( (String)session.getAttribute("state") ) 
				|| error!=null )
			return "redirect:/";
		
		//��ū �߱޹ޱ�
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
		
		//��������� ��������
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
			vo.setGender( gender.equals("female") ? "����" : "����" );
		
			json = json.getJSONObject("profile");
			vo.setNickname( json.getString("nickname") );
			vo.setName( json.getString("nickname") );
			//īī�� �α��� ������ DB�� ������ update, ������ insert
			
			if( service.member_social_id(vo) ) { //id�� ������ update
				service.member_social_update(vo);
			}else { //id�� ������ insert
				service.member_social_insert(vo);
			}
			session.setAttribute("loginInfo", vo);
		}
		return "redirect:/";
	}
	
	//���̹��α��ο�û
	@RequestMapping("/naverlogin")
	public String naverlogin(HttpSession session) {
		//https://nid.naver.com/oauth2.0/authorize?
		//response_type=code&client_id=CLIENT_ID
		//&state=STATE_STRING&redirect_uri=CALLBACK_URL
		
		//UUID �� �������ڸ� ����
		String state = UUID.randomUUID().toString();
		session.setAttribute("state", state);
		
		StringBuffer url = new StringBuffer(
			"https://nid.naver.com/oauth2.0/authorize?response_type=code");
		url.append("&client_id=").append(naver_client_id);
		url.append("&state=").append(state);
		url.append("&redirect_uri=").append("http://localhost:8080/tutors/navercallback");
		
		
		return "redirect:" + url.toString();
	}
	
	@Autowired private CommonService common;
	
	@RequestMapping("/navercallback")
	public String navercallback(HttpSession session, String state
								, String code, String error) {
		//���� ��ū�� ��ġ���� �ʰų� �ݹ���з� ���� �߻��� ��ū�� �߱޹��� �� ���� --> Ȩ����
		if( !state.equals((String)session.getAttribute("state"))
				|| error!=null ) return "redirect:/";
		//����ó��: code ���� ����
		//������ū�� �߱޹ޱ� ���� ��û
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
		
		//����� ���������� ��ȸ
		//��ûURL: https://openapi.naver.com/v1/nid/me
		//��û���: Authorization: {��ū Ÿ��] {���� ��ū]
		
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
					    ? ( json.getString("gender").equals("F") ? "����" :"����" ) 
					    : "����");
			vo.setName(json.has("name") ? json.getString("name") : json.getString("nickname"));
			vo.setNickname(json.has("nickname") ? json.getString("nickname") : json.getString("name"));
			vo.setEmail( json.getString("email") );
			
			//���̹��α����� ó���̶�� insert�ϰ�, �ƴϸ� update
			//�ش� ���̹����̵� �����ϴ����� ���� �ľ�
			if( service.member_social_id(vo) ) { //���̵� �����
				service.member_social_update(vo);
			}else {
				service.member_social_insert(vo);	
			}
			session.setAttribute("loginInfo", vo);
		}
		return "redirect:/";
	}
	
	//�α׾ƿ�ó�� ��û
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
		//īī���α����� ��� īī�������� �Բ� �α׾ƿ��ǰ� ����
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
	
	//회원가입 화면 이동
	@RequestMapping("/member")
	public String member(HttpSession session) {
		session.setAttribute("category", "join");
		return "member/join";
	}
	
	//아이디 중복체크
	@ResponseBody @RequestMapping("/id_check")
	public boolean id_check(String id) {
		return service.member_id_check(id);
	}
	
	
	
	
	//신규공지글 저장처리 요청
	@RequestMapping("/join")
	public String join(MemberVO vo, MultipartFile file, HttpSession session) {
		//첨부된 파일이 있다면 데이터객체에 파일정보를 담는다
		if( ! file.isEmpty() ) {
			//vo.setFilename( file.getOriginalFilename() );
			vo.setDbimgpath( common.fileUpload(session, file, "notice") );
		}
		//화면에서 입력한 정보를 DB에 저장한 후 목록화면으로 연결
		service.member_join(vo);
		return "redirect:/";
	}
	
	//�������� ȭ�� ��û
	@RequestMapping("/profile.pro")
	public String select(Model model, String id, HttpSession session) {
		session.setAttribute("category", "pro");
		model.addAttribute("vo", service.member_select(id) );
		return "member/profile";
	}
	
	//�������� ����ȭ�� ��û
	@RequestMapping("/modify.pro")
	public String modify(String id, Model model) {
		model.addAttribute("vo", service.member_select(id));
		return "member/modify";
	}
	
	//������ �����û
	@RequestMapping("/update.pro")
	public String update(MemberVO vo) {
		service.member_update(vo);
		return "redirect:profile.pro?id=" + vo.getId();
	}
	
}
