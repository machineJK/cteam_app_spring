package match;

import java.util.List;

public interface MatchService {
	List<TeacherVO> teacherList(int count);
	List<StudentVO> studentList();
	TeacherVO teacherDetail(String teacher_id);
	StudentVO studentDetail(String student_id);
	
}
