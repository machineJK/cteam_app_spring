package com.hanul.app.command;

import org.springframework.ui.Model;

import com.hanul.app.dao.AnDao;

public class AnBoardCommand implements AnCommand{

	@Override
	public void execute(Model model) {
		String board_id = (String)model.asMap().get("board_id");
		String board_nickname = (String)model.asMap().get("board_nickname");
		String board_content = (String)model.asMap().get("board_content");	
		String board_notice = (String)model.asMap().get("board_notice");	
		String board_image_path = (String)model.asMap().get("board_image_path");	
		String id_image_path = (String)model.asMap().get("id_image_path");
		String isComment ="";
		String postOriginal ="";
		
		AnDao adao = new AnDao();
		int state = adao.anBoard(board_id, board_nickname, board_content
						, board_notice, board_image_path, id_image_path,isComment, postOriginal);
		
		model.addAttribute("anBoard", String.valueOf(state)); 
		
	}

}
