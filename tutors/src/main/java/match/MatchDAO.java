package match;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class MatchDAO implements MatchService{
	@Autowired private SqlSession sql;

	@Override
	public TeacherVO teacherDetail(String teacher_id) {
		return sql.selectOne("match.mapper.teacherDetail", teacher_id);
	}

	@Override
	public StudentVO studentDetail(String student_id) {
		return sql.selectOne("match.mapper.studentDetail", student_id);
	}

	@Override
	public List<TeacherVO> teacherList(ConditionVO vo) {
		return sql.selectList("match.mapper.teacherList", vo);
	}

	@Override
	public List<StudentVO> studentList(ConditionVO vo) {
		return sql.selectList("match.mapper.studentList", vo);
	}

	@Override
	public boolean isTeacher(String id) {
		return (Integer)sql.selectOne("match.mapper.teacher_check", id) > 0 ? true : false;
	}

	@Override
	public boolean isStudent(String id) {
		return (Integer)sql.selectOne("match.mapper.student_check", id) > 0 ? true : false;
	}

	@Override
	public void teacherUpdate(TeacherVO vo) {
		sql.update("match.mapper.teacherUpdate", vo);
	}

	@Override
	public void studentUpdate(StudentVO vo) {
		sql.update("match.mapper.studentUpdate",vo);
	}

	@Override
	public void student_match(MatchVO vo) {
		boolean isAlreadyMatch = (Integer)sql.selectOne("match.mapper.isAlreadyMatch", vo) > 0 ? true : false;
		if(!isAlreadyMatch) {
			sql.insert("match.mapper.student_match", vo);
		}
	}

	@Override
	public void teacherCheck(MatchVO vo) {
		sql.update("match.mapper.teacherCheck", vo);
	}

	@Override
	public void teacherClose(MatchVO vo) {
		sql.delete("match.mapper.teacherClose", vo);
	}

	@Override
	public void adminCheck(MatchVO vo) {
		sql.update("match.mapper.adminCheck", vo);
	}

	@Override
	public void adminClose(MatchVO vo) {
		sql.delete("match.mapper.adminClose", vo);
	}






}
