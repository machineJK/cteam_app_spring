package match;

import java.util.List;

public interface MatchService {
	List<TeacherVO> teacherList(ConditionVO vo);
	List<StudentVO> studentList(ConditionVO vo);
	TeacherVO teacherDetail(String teacher_id);
	StudentVO studentDetail(String student_id);
	boolean isTeacher(String id);
	boolean isStudent(String id);
	void teacherUpdate(TeacherVO vo);
	void studentUpdate(StudentVO vo);
	void student_match(MatchVO vo);
	void teacherCheck(MatchVO vo);
	void teacherClose(MatchVO vo);
	void adminCheck(MatchVO vo);
	void adminClose(MatchVO vo);
}
