package com.hanul.app.command;

import org.springframework.ui.Model;

import com.hanul.app.dao.AnDao;

public class AModifyNoCommand implements AnCommand{
	

	@Override
	public void execute(Model model) {
		String id = (String)model.asMap().get("id");
		String pw = (String) model.asMap().get("pw");
		String nickname = (String) model.asMap().get("nickname");
		String email = (String) model.asMap().get("email");
		
		
		AnDao adao = new AnDao();
		
		adao.anUpdateMultiNo(id, pw, nickname, email);
		
	}
}
