package com.hanul.app.command;

import java.util.ArrayList;

import org.springframework.ui.Model;

import com.hanul.app.dao.AnDao;
import com.hanul.app.dto.BoardDTO;

public class SelectCommentCommand implements AnCommand{
	@Override
	public void execute(Model model) {
		String postOriginal = (String)model.asMap().get("postOriginal");
		
		AnDao adao = new AnDao();
		ArrayList<BoardDTO> adtos = adao.anSelectComment(postOriginal);
		
		model.addAttribute("anSelectComment", adtos); 		
	}

}
