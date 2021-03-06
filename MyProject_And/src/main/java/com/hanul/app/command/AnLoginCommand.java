package com.hanul.app.command;

import org.springframework.ui.Model;

import com.hanul.app.dao.AnDao;
import com.hanul.app.dto.MemberDTO;

public class AnLoginCommand implements AnCommand{

	@Override
	public void execute(Model model) {
		String id = (String)model.asMap().get("id");
		String pw = (String)model.asMap().get("pw");	

		//System.out.println(id);
		//System.out.println(passwd);

		AnDao adao = new AnDao();
		MemberDTO dto = adao.anLogin(id, pw);
		
		model.addAttribute("anLogin", dto); 
	}
}
