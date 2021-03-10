package match;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class MatchServiceImpl implements MatchService{
	@Autowired private MatchDAO dao;

	@Override
	public TeacherVO teacherDetail(String teacher_id) {
		return dao.teacherDetail(teacher_id);
	}

	@Override
	public StudentVO studentDetail(String student_id) {
		return dao.studentDetail(student_id);
	}
	
	@Override
	public List<TeacherVO> teacherList(ConditionVO vo) {
		return dao.teacherList(vo);
	}

	@Override
	public List<StudentVO> studentList(ConditionVO vo) {
		return dao.studentList(vo);
	}

}
