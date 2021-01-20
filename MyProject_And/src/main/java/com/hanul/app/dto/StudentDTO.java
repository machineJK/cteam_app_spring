package com.hanul.app.dto;

import java.sql.Date;

public class StudentDTO {
    String student_id,student_subject,student_grade,student_intro,
    			student_image_path;
    int student_matching;
    Date student_date;
	public StudentDTO(String student_id, String student_subject, String student_grade, String student_intro,
			String student_image_path, int student_matching, Date student_date) {
		super();
		this.student_id = student_id;
		this.student_subject = student_subject;
		this.student_grade = student_grade;
		this.student_intro = student_intro;
		this.student_image_path = student_image_path;
		this.student_matching = student_matching;
		this.student_date = student_date;
	}
	public String getStudent_id() {
		return student_id;
	}
	public void setStudent_id(String student_id) {
		this.student_id = student_id;
	}
	public String getStudent_subject() {
		return student_subject;
	}
	public void setStudent_subject(String student_subject) {
		this.student_subject = student_subject;
	}
	public String getStudent_grade() {
		return student_grade;
	}
	public void setStudent_grade(String student_grade) {
		this.student_grade = student_grade;
	}
	public String getStudent_intro() {
		return student_intro;
	}
	public void setStudent_intro(String student_intro) {
		this.student_intro = student_intro;
	}
	public String getStudent_image_path() {
		return student_image_path;
	}
	public void setStudent_image_path(String student_image_path) {
		this.student_image_path = student_image_path;
	}
	public int getStudent_matching() {
		return student_matching;
	}
	public void setStudent_matching(int student_matching) {
		this.student_matching = student_matching;
	}
	public Date getStudent_date() {
		return student_date;
	}
	public void setStudent_date(Date student_date) {
		this.student_date = student_date;
	}
}
