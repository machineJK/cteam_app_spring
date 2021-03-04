package match;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class MatchServiceImpl implements MatchService{
	@Autowired private MatchDAO dao;
	
	@Override
	public List<TeacherVO> teacherList() {
		return dao.teacherList();
	}

	@Override
	public List<StudentVO> studentList() {
		return dao.studentList();
	}

	@Override
	public TeacherVO teacherDetail(String teacher_id) {
		return dao.teacherDetail(teacher_id);
	}

	@Override
	public StudentVO studentDetail(String student_id) {
		// TODO Auto-generated method stub
		return null;
	}

}
