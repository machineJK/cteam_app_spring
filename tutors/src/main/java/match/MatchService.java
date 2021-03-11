package match;

import java.util.List;

public interface MatchService {
	List<TeacherVO> teacherList(ConditionVO vo);
	List<StudentVO> studentList(ConditionVO vo);
	TeacherVO teacherDetail(String teacher_id);
	StudentVO studentDetail(String student_id);
	
}
