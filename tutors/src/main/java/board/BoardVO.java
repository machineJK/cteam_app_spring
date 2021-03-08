package board;

import java.sql.Date;

public class BoardVO {
	private int board_readcount, board_notice, board_num;
	private String board_id, board_content, board_image_path, id_image_path, board_nickname, board_image_name;
	private Date board_write_date;
	
	
	public String getBoard_image_name() {
		return board_image_name;
	}
	public void setBoard_image_name(String board_image_name) {
		this.board_image_name = board_image_name;
	}
	public int getBoard_readcount() {
		return board_readcount;
	}
	public void setBoard_readcount(int board_readcount) {
		this.board_readcount = board_readcount;
	}
	public int getBoard_notice() {
		return board_notice;
	}
	public void setBoard_notice(int board_notice) {
		this.board_notice = board_notice;
	}
	public int getBoard_num() {
		return board_num;
	}
	public void setBoard_num(int board_num) {
		this.board_num = board_num;
	}
	public String getBoard_id() {
		return board_id;
	}
	public void setBoard_id(String board_id) {
		this.board_id = board_id;
	}
	public String getBoard_content() {
		return board_content;
	}
	public void setBoard_content(String board_content) {
		this.board_content = board_content;
	}
	public String getBoard_image_path() {
		return board_image_path;
	}
	public void setBoard_image_path(String board_image_path) {
		this.board_image_path = board_image_path;
	}
	public String getId_image_path() {
		return id_image_path;
	}
	public void setId_image_path(String id_image_path) {
		this.id_image_path = id_image_path;
	}
	public String getBoard_nickname() {
		return board_nickname;
	}
	public void setBoard_nickname(String board_nickname) {
		this.board_nickname = board_nickname;
	}
	public Date getBoard_write_date() {
		return board_write_date;
	}
	public void setBoard_write_date(Date board_write_date) {
		this.board_write_date = board_write_date;
	}
	
	
}
