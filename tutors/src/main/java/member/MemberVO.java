package member;

public class MemberVO {
	private String id,pw,nickname,name,gender,birth,email,addr1,addr2,
					dbimgpath,kakao_login,naver_login;

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPw() {
		return pw;
	}

	public void setPw(String pw) {
		this.pw = pw;
	}

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getBirth() {
		return birth;
	}

	public void setBirth(String birth) {
		this.birth = birth;
	}

	public String getAddr1() {
		return addr1;
	}

	public void setAddr1(String addr1) {
		this.addr1 = addr1;
	}

	public String getAddr2() {
		return addr2;
	}

	public void setAddr2(String addr2) {
		this.addr2 = addr2;
	}

	public String getDbimgpath() {
		return dbimgpath;
	}

	public void setDbimgpath(String dbimgpath) {
		this.dbimgpath = dbimgpath;
	}

	public String getKakao_login() {
		return kakao_login;
	}

	public void setKakao_login(String kakao_login) {
		this.kakao_login = kakao_login;
	}

	public String getNaver_login() {
		return naver_login;
	}

	public void setNaver_login(String naver_login) {
		this.naver_login = naver_login;
	}
}
