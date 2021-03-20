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

	@Override
	public boolean isTeacher(String id) {
		return dao.isTeacher(id);
	}

	@Override
	public boolean isStudent(String id) {
		return dao.isStudent(id);
	}

	@Override
	public void teacherUpdate(TeacherVO vo) {
		dao.teacherUpdate(vo);
	}

	@Override
	public void studentUpdate(StudentVO vo) {
		dao.studentUpdate(vo);
	}

	@Override
	public void student_match(MatchVO vo) {
		dao.student_match(vo);
	}

	@Override
	public void teacherCheck(MatchVO vo) {
		dao.teacherCheck(vo);
	}

	@Override
	public void teacherClose(MatchVO vo) {
		dao.teacherClose(vo);
	}

	@Override
	public void adminCheck(MatchVO vo) {
		dao.adminCheck(vo);
	}

	@Override
	public void adminClose(MatchVO vo) {
		dao.adminClose(vo);
	}




}
