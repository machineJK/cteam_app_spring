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
import member.MemberServiceImpl;
import member.MemberVO;

@Controller
public class MemberController {
	@Autowired private MemberServiceImpl service;
	

	
	//로그인 눌렀을 때 화면이동
	@RequestMapping("/login")
	public String login(HttpSession session) {
		session.setAttribute("category", "login");
		return "member/login";
	}
	
	@ResponseBody @RequestMapping("/tutorlogin")
	public boolean login(String id, String pw, HttpSession session) {
		//화면에서 입력한 아이디/비번이 일치하는 회원정보를 조회해온다
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("id", id);
		map.put("pw", pw);
		MemberVO vo = service.member_login(map);
		//로그인한 회원정보를 세션에 담아둔다
		session.setAttribute("loginInfo", vo);
		return vo==null ? false : true;
	}	
	
	private String naver_client_id = "qu_lR9gmMvoSzs_ljPzw";
	private String kakao_client_id = "77c939760d65450e90e8ae736d73979b";
	
	//카카오로그인요청
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
		
		//토큰 발급받기
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
		
		//사용자정보 가져오기
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
			//카카오 로그인 정보가 DB에 있으면 update, 없으면 insert
			
			if( service.member_social_id(vo) ) { //id가 있으면 update
				service.member_social_update(vo);
			}else { //id가 없으면 insert
				service.member_social_insert(vo);
			}
			session.setAttribute("loginInfo", vo);
		}
		return "redirect:/";
	}
	
	//네이버로그인요청
	@RequestMapping("/naverlogin")
	public String naverlogin(HttpSession session) {
		//https://nid.naver.com/oauth2.0/authorize?
		//response_type=code&client_id=CLIENT_ID
		//&state=STATE_STRING&redirect_uri=CALLBACK_URL
		
		//UUID 로 랜덤문자를 생성
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
		//상태 토큰이 일치하지 않거나 콜백실패로 에러 발생시 토큰을 발급받을 수 없다 --> 홈으로
		if( !state.equals((String)session.getAttribute("state"))
				|| error!=null ) return "redirect:/";
		//정상처리: code 값이 있음
		//접근토큰을 발급받기 위한 요청
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
		
		//사용자 프로필정보 조회
		//요청URL: https://openapi.naver.com/v1/nid/me
		//요청헤더: Authorization: {토큰 타입] {접근 토큰]
		
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
					    : "남자");
			vo.setName(json.has("name") ? json.getString("name") : json.getString("nickname"));
			vo.setNickname(json.has("nickname") ? json.getString("nickname") : json.getString("name"));
			vo.setEmail( json.getString("email") );
			
			//네이버로그인인 처음이라면 insert하고, 아니면 update
			//해당 네이버아이디가 존재하는지를 먼저 파악
			if( service.member_social_id(vo) ) { //아이디 존재시
				service.member_social_update(vo);
			}else {
				service.member_social_insert(vo);	
			}
			session.setAttribute("loginInfo", vo);
		}
		return "redirect:/";
	}
	
	//로그아웃처리 요청
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
		//카카오로그인인 경우 카카오계정도 함께 로그아웃되게 하자
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
	
	//회원가입화면 요청
	@RequestMapping("/member")
	public String member(HttpSession session) {
		session.setAttribute("category", "join");
		return "member/join";
	}
	
	//내프로필 화면 요청
	@RequestMapping("/profile.pro")
	public String select(Model model, String id, HttpSession session) {
		session.setAttribute("category", "pro");
		model.addAttribute("vo", service.member_select(id) );
		return "member/profile";
	}
	
	//내프로필 수정화면 요청
	@RequestMapping("/modify.pro")
	public String modify(String id, Model model) {
		model.addAttribute("vo", service.member_select(id));
		return "member/modify";
	}
	
	//내정보 저장요청
	@RequestMapping("/update.pro") 
	public String update(MemberVO vo) {
		service.member_update(vo); 
	    return "redirect:profile.pro?id=" + vo.getId(); }
	
	
	
	
	
	
	
}
