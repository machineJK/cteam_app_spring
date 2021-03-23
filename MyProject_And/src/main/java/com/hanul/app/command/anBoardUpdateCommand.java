package com.hanul.app.command;

import org.springframework.ui.Model;

import com.hanul.app.dao.AnDao;

public class anBoardUpdateCommand implements AnCommand{

	@Override
	public void execute(Model model) {
		String qna_ref_num = (String)model.asMap().get("qna_ref_num");
		String board_content = (String)model.asMap().get("board_content");
		String board_image_path = null;

		AnDao adao = new AnDao();
		
		if((String)model.asMap().get("board_image_path") != null) {
			board_image_path = (String)model.asMap().get("board_image_path");
			adao.anBoardUpdate(qna_ref_num,board_content,board_image_path);
		}else {
			adao.anBoardUpdate(qna_ref_num,board_content);
		}
		
	}
	
}
