package com.hanul.app.command;

import java.util.ArrayList;

import org.springframework.ui.Model;

import com.hanul.app.dao.AnDao;
import com.hanul.app.dto.BoardDTO;

public class ASelectBoardCommand implements AnCommand{
	@Override
	public void execute(Model model) {
		AnDao adao = new AnDao();
		ArrayList<BoardDTO> adtos = adao.anSelectBoard();
		
		model.addAttribute("anSelectBoard", adtos); 		
	}

}
