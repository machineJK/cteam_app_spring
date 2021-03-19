package com.hanul.app.command;

import org.springframework.ui.Model;

import com.hanul.app.dao.AnDao;

public class ReadCountCommand implements AnCommand{

	@Override
	public void execute(Model model) {
		String qna_ref_num = (String)model.asMap().get("qna_ref_num");
		
		AnDao adao = new AnDao();
		
		adao.anReadCount(qna_ref_num);
	}
	
}
