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

}
