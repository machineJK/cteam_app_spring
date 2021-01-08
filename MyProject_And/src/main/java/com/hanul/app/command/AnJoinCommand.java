package com.hanul.app.command;

import org.springframework.ui.Model;

import com.hanul.app.dao.AnDao;


public class AnJoinCommand implements AnCommand{

	@Override
	public void execute(Model model) {
		String id = (String)model.asMap().get("id");
		String passwd = (String)model.asMap().get("passwd");	
		String name = (String)model.asMap().get("name");
		String phonenumber = (String)model.asMap().get("phonenumber");
		String address = (String)model.asMap().get("address");
		
		//System.out.println(id);
		//System.out.println(passwd);
		//System.out.println(name);
		//System.out.println(phonenumber);
		//System.out.println(address);
		
		AnDao adao = new AnDao();
		int state = adao.anJoin(id, passwd, name, phonenumber, address);
		
		model.addAttribute("anJoin", String.valueOf(state)); 
	}

}
