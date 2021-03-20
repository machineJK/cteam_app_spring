package member;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import match.MatchVO;
import match.StudentVO;
import match.TeacherVO;

@Service
public class MemberServiceImpl implements MemberService{
	@Autowired private MemberDAO dao;
	
	@Override
	public boolean member_join(MemberVO vo) {
		return dao.member_join(vo);
	}


	@Override
	public MemberVO member_select(String id) {
		return dao.member_select(id);
	}

	@Override
	public void member_update(MemberVO vo) {
		dao.member_update(vo);
	}
	
	@Override
	public MemberVO member_login(HashMap<String, Object> map) {
		return dao.member_login(map);
	}


	@Override
	public boolean member_delete(String id) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean member_id_check(String id) {
		return dao.member_id_check(id);
	}

	@Override
	public boolean member_social_id(MemberVO vo) {
		return dao.member_social_id(vo);
	}

	@Override
	public boolean member_social_insert(MemberVO vo) {
		return dao.member_social_insert(vo);
	}

	@Override
	public boolean member_social_update(MemberVO vo) {
		return dao.member_social_update(vo);
	}


	@Override
	public void teacher_join(TeacherVO vo) {
		dao.teacher_join(vo);
	}


	@Override
	public void student_join(StudentVO vo) {
		dao.student_join(vo);
	}


	@Override
	public boolean teacher_check(String id) {
		return dao.teacher_check(id);
	}


	@Override
	public boolean student_check(String id) {
		return dao.student_check(id);
	}


	@Override
	public void updateKakaoNaverExtra(MemberVO vo) {
		dao.updateKakaoNaverExtra(vo);
	}


	@Override
	public boolean isKakaoNaverPw(MemberVO vo) {
		return dao.isKakaoNaverPw(vo);
	}


	@Override
	public List<MatchVO> teacher_match(String id) {
		return dao.teacher_match(id);
	}


	@Override
	public List<MatchVO> admin_match() {
		return dao.admin_match();
	}


	@Override
	public List<MatchVO> allmatch(String id) {
		return dao.allmatch(id);
	}






	

}
