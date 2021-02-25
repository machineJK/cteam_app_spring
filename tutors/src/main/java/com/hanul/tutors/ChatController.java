package com.hanul.tutors;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ChatController {
	
	@RequestMapping("/list.chat")
	public String chatList() {
		return "chat/list";
	}
}
