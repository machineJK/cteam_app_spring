package member;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import match.MatchVO;
import match.StudentVO;
import match.TeacherVO;



@Repository
public class MemberDAO implements MemberService{
	@Autowired private SqlSession sql;
	
	@Override
	public boolean member_join(MemberVO vo) {
		return sql.insert("member.mapper.join",vo) > 0 ? true : false;
	}

	
	@Override
	public MemberVO member_select(String id) {
		return sql.selectOne("member.mapper.select", id);
	}
	
	@Override
	public void member_update(MemberVO vo) {
		sql.update("member.mapper.update", vo);
	}

	@Override
	public MemberVO member_login(HashMap<String, Object> map) {
		return sql.selectOne("member.mapper.login", map);
	}


	@Override
	public boolean member_delete(String id) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean member_id_check(String id) {
		return (Integer)sql.selectOne("member.mapper.id_check", id)==0
				? false : true;
	}

	@Override
	public boolean member_social_id(MemberVO vo) {
		return (Integer)sql.selectOne("member.mapper.social_id", vo) == 1 
								? true : false;
	}

	@Override
	public boolean member_social_insert(MemberVO vo) {
		return sql.insert("member.mapper.social_insert", vo) > 0 ? true : false;
	}

	@Override
	public boolean member_social_update(MemberVO vo) {
		return sql.update("member.mapper.social_update", vo) > 0 ? true : false;
	}


	@Override
	public void teacher_join(TeacherVO vo) {
		sql.insert("member.mapper.teacher", vo);
	}


	@Override
	public void student_join(StudentVO vo) {
		sql.insert("member.mapper.student", vo);
	}


	@Override
	public boolean teacher_check(String id) {
		return (Integer)sql.selectOne("member.mapper.teacher_check",id) == 0 ? false : true;
	}


	@Override
	public boolean student_check(String id) {
		return (Integer)sql.selectOne("member.mapper.student_check",id) == 0 ? false : true;
	}


	@Override
	public void updateKakaoNaverExtra(MemberVO vo) {
		sql.update("member.mapper.updateKakaoNaverExtra", vo);
	}


	@Override
	public boolean isKakaoNaverPw(MemberVO vo) {
		return sql.selectOne("member.mapper.isKakaoNaverPw", vo) == null ? false : true;
	}


	@Override
	public List<MatchVO> teacher_match(String id) {
		return sql.selectList("member.mapper.wantmatchstudent", id);
	}


	@Override
	public List<MatchVO> admin_match() {
		return sql.selectList("member.mapper.wantmatchadmin");
	}


	@Override
	public List<MatchVO> allmatch(String id) {
		return sql.selectList("member.mapper.allmatch", id);
	}





	

}
