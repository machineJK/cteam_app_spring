package com.hanul.tutors;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ChatController {
	

	
	@RequestMapping("/list.chat")
	public String chatList(Model model, String id, String receiveId, HttpSession session) {
		model.addAttribute("id", id);
		model.addAttribute("receiveId", receiveId);
		
		return "chat/list";
	}
}
