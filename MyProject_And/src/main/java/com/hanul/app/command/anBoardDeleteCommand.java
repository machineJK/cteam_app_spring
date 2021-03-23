package com.hanul.app.command;

import org.springframework.ui.Model;

import com.hanul.app.dao.AnDao;

public class anBoardDeleteCommand implements AnCommand{

	@Override
	public void execute(Model model) {
		String qna_ref_num = (String)model.asMap().get("qna_ref_num");
		String isComment,board_id;

		AnDao adao = new AnDao();
		
		if((String)model.asMap().get("isComment") != null) {
			isComment = (String)model.asMap().get("isComment");
			board_id = (String)model.asMap().get("board_id");
			adao.anBoardDelete(qna_ref_num,isComment,board_id);
		}else {
			adao.anBoardDelete(qna_ref_num);
		}
		
		
	}
	
}
