package com.hanul.app.command;

import org.springframework.ui.Model;

import com.hanul.app.dao.AnDao;


public class AnJoinCommand implements AnCommand{

	@Override
	public void execute(Model model) {
		String id = (String)model.asMap().get("id");
		String pw = (String)model.asMap().get("pw");	
		String nickname = (String)model.asMap().get("nickname");	
		String name = (String)model.asMap().get("name");	
		String gender = (String)model.asMap().get("gender");	
		String birth = (String)model.asMap().get("birth");	
		String email = (String)model.asMap().get("email");	
		String addr1 = (String)model.asMap().get("addr1");	
		String addr2 = (String)model.asMap().get("addr2");	
		String dbImgPath = (String)model.asMap().get("dbImgPath");
		String kakao_login = (String)model.asMap().get("kakao_login");
		String naver_login = (String)model.asMap().get("naver_login");

		
		//System.out.println(id);
		//System.out.println(passwd);
		//System.out.println(name);
		//System.out.println(phonenumber);
		//System.out.println(address);
		
		AnDao adao = new AnDao();
		int state = adao.anJoin(id, pw, nickname, name, gender, birth, email,
									addr1, addr2, dbImgPath, kakao_login, naver_login);
		
		model.addAttribute("anJoin", String.valueOf(state)); 
	}

}
