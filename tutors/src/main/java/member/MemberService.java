package member;

import java.util.HashMap;

import match.StudentVO;
import match.TeacherVO;



public interface MemberService {
	boolean member_join(MemberVO vo); //ȸ�����Խ� ȸ������ ����
	MemberVO member_login(HashMap<String, Object> map); //ȸ�� �α���ó��
	boolean member_delete(String id); //ȸ��Ż��
	boolean member_id_check(String id); //ȸ�����Խ� ���̵��ߺ�Ȯ��
	boolean member_social_id(MemberVO vo);//�Ҽȷα��ν� ȸ���� ���翩��
	boolean member_social_insert(MemberVO vo);//�Ҽȷα��ν� ȸ�� �ű�����
	boolean member_social_update(MemberVO vo);//�Ҽȷα��ν� ȸ�� ��������
	MemberVO member_select(String id); //�� ������ ����������
	void member_update(MemberVO vo); //ȸ������ ���� ����
	void teacher_join(TeacherVO vo);
	void student_join(StudentVO vo);
	boolean teacher_check(String id);
	boolean student_check(String id);
	boolean isKakaoNaverPw(MemberVO vo);
	void updateKakaoNaverExtra(MemberVO vo);
//	void updateUimage(String id, String dbimgpath);
//	void modifyUimage(String uid, String uimage);

	
	
}
