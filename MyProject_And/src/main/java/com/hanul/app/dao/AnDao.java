package com.hanul.app.dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import com.hanul.app.dto.BoardDTO;
import com.hanul.app.dto.CheckDTO;
import com.hanul.app.dto.MemberDTO;
import com.hanul.app.dto.StudentDTO;
import com.hanul.app.dto.TeacherDTO;

public class AnDao {
	DataSource dataSource;


	//DB�뿰寃� 硫붿냼�뱶
	public AnDao() {
		try {
			Context context = new InitialContext();
			dataSource = (DataSource) context.lookup("java:/comp/env/cteam");
			/*dataSource = (DataSource) context.lookup("java:/comp/env/CSS");*/
		} catch (NamingException e) {
			e.getMessage();
		}

	}
	
    public CheckDTO anIdCheck(String idin) {

    	CheckDTO adto = null;
		Connection connection = null;
		PreparedStatement prepareStatement = null;
		ResultSet resultSet = null;		
		
		try {
			connection = dataSource.getConnection();
			String query = "select count(*) "					
							+ " from member" 
							+ " where id = '" + idin + "' ";
			prepareStatement = connection.prepareStatement(query);
			resultSet = prepareStatement.executeQuery();
			
			while (resultSet.next()) {
				int idchk = resultSet.getInt(1);
				adto = new CheckDTO(idchk);					
			}	
			
			System.out.println("CheckDTO idchk : " + adto.getIdchk());
			
		} catch (Exception e) {
			e.getMessage();
			System.out.println("anIdCheck() Exception!!!");
		} finally {
			try {			
				
				if (resultSet != null) {
					resultSet.close();
				}
				if (prepareStatement != null) {
					prepareStatement.close();
				}
				if (connection != null) {
					connection.close();
				}	

			} catch (Exception e) {
				e.printStackTrace();
			} finally {

			}
		}

		return adto;

	}
	
	
	//�쉶�썝媛��엯 硫붿냼�뱶(Insert)
	public int anJoin(String id, String pw, String nickname, String name,
			String gender, String birth, String email, String addr1,
			String addr2, String dbImgPath, String kakao_login, String naver_login) {
		
		Connection connection = null;
		PreparedStatement prepareStatement = null;
		int state = -100;
		
		try {
			connection = dataSource.getConnection();
			String query = "insert into member(id,pw,nickname,name,gender,birth,email,addr1,addr2,dbImgPath,kakao_login,naver_login) " + 
			               "values('" + id + "', '" + pw + "', '" + nickname + 
			               "', '" + name + "', '" + gender + 
			               "', '" + birth + "', '" + email + "', '" + addr1 + 
			               "', '" + addr2 + "', '" + dbImgPath + "', '" + kakao_login + "', '" + naver_login + "')";
			prepareStatement = connection.prepareStatement(query);
			state = prepareStatement.executeUpdate();
			
			if (state > 0) {
				System.out.println(state + ":�궫�엯�꽦怨�");				
			} else {
				System.out.println(state + ":�궫�엯�떎�뙣");
			}
			
		} catch (Exception e) {			
			System.out.println(e.getMessage());
		} finally {
			try {				
				if (prepareStatement != null) {
					prepareStatement.close();
				}
				if (connection != null) {
					connection.close();
				}	

			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return state;
	}
	
	
    public MemberDTO anLogin(String idin, String pwin) {

    	MemberDTO adto = null;
		Connection connection = null;
		PreparedStatement prepareStatement = null;
		ResultSet resultSet = null;		
		
		try {
			connection = dataSource.getConnection();
			String query = "select * "					
							+ " from member" 
							+ " where id = '" + idin + "' and pw = '" + pwin + "' ";
			prepareStatement = connection.prepareStatement(query);
			resultSet = prepareStatement.executeQuery();
			
			while (resultSet.next()) {
				String id = resultSet.getString("id");
				String pw = resultSet.getString("pw");
				String nickname = resultSet.getString("nickname");
				String name = resultSet.getString("name");
				String gender = resultSet.getString("gender");
				String birth = resultSet.getString("birth");
				String email = resultSet.getString("email");
				String addr1 = resultSet.getString("addr1");
				String addr2 = resultSet.getString("addr2");
				String dbImgPath = resultSet.getString("dbImgPath");
				String kakao_login = resultSet.getString("kakao_login");
				String naver_login = resultSet.getString("naver_login");

				adto = new MemberDTO(id, pw, nickname, name, gender, 
						birth, email, addr1, addr2, dbImgPath, kakao_login, naver_login);						
			}	
			
			System.out.println("MemberDTO id : " + adto.getId());
			
		} catch (Exception e) {
			e.getMessage();
			System.out.println("anLogin() Exception!!!");
		} finally {
			try {			
				
				if (resultSet != null) {
					resultSet.close();
				}
				if (prepareStatement != null) {
					prepareStatement.close();
				}
				if (connection != null) {
					connection.close();
				}	

			} catch (Exception e) {
				e.printStackTrace();
			} finally {

			}
		}

		return adto;

	}
    
    //�꽑�깮 �벑濡�
    public int anTeacher(String teacher_id,String teacher_univ,
    		String teacher_major,String teacher_univnum,String teacher_subject,
    		String teacher_worktime,String teacher_pay,String teacher_intro,
    		String teacher_image_path,String teacher_nickname,String teacher_addr) {

		Connection connection = null;
		PreparedStatement prepareStatement = null;
		int state = -100;
		
		try {
			connection = dataSource.getConnection();
			String query = "insert into teacher(teacher_id,teacher_univ,teacher_major,"
					+ "teacher_univnum,teacher_subject,teacher_worktime,teacher_pay,"
					+ "teacher_intro,teacher_image_path,teacher_nickname,teacher_addr) " + 
			               "values('" + teacher_id + "', '" + teacher_univ + "', '" + 
			               teacher_major + "', '" + teacher_univnum + "', '" +
			               teacher_subject + "', '" + teacher_worktime + "', '" + 
			               teacher_pay + "', '" + teacher_intro + "','" + teacher_image_path + 
			               teacher_nickname  + "','" + teacher_addr + "')";
			prepareStatement = connection.prepareStatement(query);
			state = prepareStatement.executeUpdate();
			System.out.println(teacher_intro);
			if (state > 0) {
				System.out.println(state + ":�궫�엯�꽦怨�");				
			} else {
				System.out.println(state + ":�궫�엯�떎�뙣");
			}
			
		} catch (Exception e) {			
			System.out.println(e.getMessage());
		} finally {
			try {				
				if (prepareStatement != null) {
					prepareStatement.close();
				}
				if (connection != null) {
					connection.close();
				}	

			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return state;
	}
    
    public int anStudent(String student_id,String student_subject,
    		String student_grade,String student_intro,String student_image_path,
    		String student_addr,String student_nickname) {

		Connection connection = null;
		PreparedStatement prepareStatement = null;
		int state = -100;
		
		try {
			connection = dataSource.getConnection();
			String query = "insert into student(student_id,student_subject,student_grade,"
						+ "student_intro,student_image_path,student_addr,student_nickname) "
			            + "values('" + student_id + "', '" + student_subject + "', '" + 
			            student_grade + "', '" + student_intro + "', '"
			            + student_image_path + "', '" + student_addr + "', '" + student_nickname + "')";
			prepareStatement = connection.prepareStatement(query);
			state = prepareStatement.executeUpdate();
			
			if (state > 0) {
				System.out.println(state + ":�궫�엯�꽦怨�");				
			} else {
				System.out.println(state + ":�궫�엯�떎�뙣");
			}
			
		} catch (Exception e) {			
			System.out.println(e.getMessage());
		} finally {
			try {				
				if (prepareStatement != null) {
					prepareStatement.close();
				}
				if (connection != null) {
					connection.close();
				}	

			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return state;
	}
    
    //�꽑�깮 由ъ뒪�듃
	public ArrayList<TeacherDTO> anSelectMulti() {		
		
		ArrayList<TeacherDTO> adtos = new ArrayList<TeacherDTO>();
		Connection connection = null;
		PreparedStatement prepareStatement = null;
		ResultSet resultSet = null;		
		
		try {
			connection = dataSource.getConnection();
			String query = "select *"					
							+ " from teacher" 
							+ " order by teacher_date desc";
			prepareStatement = connection.prepareStatement(query);
			resultSet = prepareStatement.executeQuery();
			
			while (resultSet.next()) {
				String teacher_id = resultSet.getString("teacher_id");
				String teacher_univ = resultSet.getString("teacher_univ");
				String teacher_major = resultSet.getString("teacher_major");
				String teacher_univnum = resultSet.getString("teacher_univnum");
				String teacher_subject = resultSet.getString("teacher_subject");
				String teacher_worktime = resultSet.getString("teacher_worktime");
				String teacher_pay = resultSet.getString("teacher_pay");
				String teacher_intro = resultSet.getString("teacher_intro");
				String teacher_image_path = resultSet.getString("teacher_image_path");
				int teacher_matching = resultSet.getInt("teacher_matching");
				Date teacher_date = resultSet.getDate("teacher_date");
				String teacher_nickname = resultSet.getString("teacher_nickname");
				String teacher_addr = resultSet.getString("teacher_addr");

				TeacherDTO adto = new TeacherDTO(teacher_id,teacher_univ,teacher_major,teacher_univnum,
						teacher_subject,teacher_worktime,teacher_pay,teacher_intro,
						teacher_image_path,teacher_matching,teacher_date,teacher_nickname,teacher_addr);
				adtos.add(adto);			
			}	
			
			System.out.println("adtos�겕湲�" + adtos.size());
			
		} catch (Exception e) {
			
			System.out.println(e.getMessage());
		} finally {
			try {			
				
				if (resultSet != null) {
					resultSet.close();
				}
				if (prepareStatement != null) {
					prepareStatement.close();
				}
				if (connection != null) {
					connection.close();
				}	

			} catch (Exception e) {
				e.printStackTrace();
			} finally {

			}
		}

		return adtos;

	}
    
	//�븰�깮 由ъ뒪�듃
	public ArrayList<StudentDTO> anSelectMulti2() {		
		
		ArrayList<StudentDTO> adtos = new ArrayList<StudentDTO>();
		Connection connection = null;
		PreparedStatement prepareStatement = null;
		ResultSet resultSet = null;		
		
		try {
			connection = dataSource.getConnection();
			String query = "select *"					
							+ " from student" 
							+ " order by student_date desc";
			prepareStatement = connection.prepareStatement(query);
			resultSet = prepareStatement.executeQuery();
			
			while (resultSet.next()) {
				String student_id = resultSet.getString("student_id");
				String student_subject = resultSet.getString("student_subject");
				String student_grade = resultSet.getString("student_grade");
				String student_intro = resultSet.getString("student_intro");
				String student_image_path = resultSet.getString("student_image_path");
				int student_matching = resultSet.getInt("student_matching");
				Date student_date = resultSet.getDate("student_date");
				String student_addr = resultSet.getString("student_addr");
				String student_nickname = resultSet.getString("student_nickname");
				
				//System.out.println(student_addr);

				StudentDTO adto = new StudentDTO(student_id, student_subject, student_grade, 
						student_intro, student_image_path, student_matching, student_date,student_addr,student_nickname);
				adtos.add(adto);			
			}	
			
			System.out.println("adtos�겕湲�" + adtos.size());
			
		} catch (Exception e) {
			
			System.out.println(e.getMessage());
		} finally {
			try {			
				
				if (resultSet != null) {
					resultSet.close();
				}
				if (prepareStatement != null) {
					prepareStatement.close();
				}
				if (connection != null) {
					connection.close();
				}	

			} catch (Exception e) {
				e.printStackTrace();
			} finally {

			}
		}

		return adtos;

	}
	//Modify�쉺�젙蹂� �닔�젙�솕硫�(Modify)
	public int anModify(String id, String pw, String nickname, String email, String dbImgPath) {
		
		Connection connection = null;
		PreparedStatement prepareStatement = null;
		ResultSet resultSet = null;
		
		int state = -1;
	
		try {			
			//�븘�씠�뵒�뒗 �닔�젙�븷�닔 �뾾�쓬		
			connection = dataSource.getConnection();
			String query = "update member set " 			             
		             + " pw = '" + pw + "' "
		             + ", nickname = '" + nickname + "' "
		             + ", email = '" + email + "' "
		             + ", dbimgpath = '" + dbImgPath + "' "
					 + " where id = '" + id + "'";
			
			prepareStatement = connection.prepareStatement(query);
			state = prepareStatement.executeUpdate();
	
			if (state > 0) {
				System.out.println("�닔�젙1�꽦怨�");
				
			} else {
				System.out.println("�닔�젙1�떎�뙣");
			}
	
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (resultSet != null) {
					resultSet.close();
				}
				if (prepareStatement != null) {
					prepareStatement.close();
				}
				if (connection != null) {
					connection.close();
				}
	
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
	
			}
		}
	
		return state;
	
	}
	//�닔�젙�떎�뙣
	public int anUpdateMultiNo(String id, String pw, String nickname, String email) {
		
		Connection connection = null;
		PreparedStatement prepareStatement = null;
		ResultSet resultSet = null;
		
		int state = -1;

	
		try {			
			// �븘�씠�뵒�뒗 �닔�젙�븷�닔 �뾾�쓬			
			connection = dataSource.getConnection();
			String query = "update member set " 			             
		             + " pw = '" + pw + "' "
		             + ", nickname = '" + nickname + "' "
		             + ", email = '" + email + "' "
					 + " where id = '" + id + "'";
			
			prepareStatement = connection.prepareStatement(query);
			state = prepareStatement.executeUpdate();
	
			if (state > 0) {
				System.out.println("�닔�젙2�꽦怨�");
				
			} else {
				System.out.println("�닔�젙2�떎�뙣");
			}
	
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (resultSet != null) {
					resultSet.close();
				}
				if (prepareStatement != null) {
					prepareStatement.close();
				}
				if (connection != null) {
					connection.close();
				}
	
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
	
			}
		}
	
		return state;
	}
	
	//Board DB에 등록
	public int anBoard(String board_id, String board_nickname,String board_content, String board_notice,
			String qna_ref_num, String board_image_path, String id_image_path) {
		Connection connection = null;
		PreparedStatement prepareStatement = null;
		int state = -100;
		try {
			connection = dataSource.getConnection();
			String query = "insert into board(board_id,board_nickname, board_content, "
					+ "board_notice, qna_ref_num,board_image_path,id_image_path ) " + 
			               "values('" + board_id + "', '" + board_nickname + "', '" +board_content + 
			               "', '" + board_notice + "', '" + qna_ref_num + 
			               "', '" + board_image_path + "', '" + id_image_path + "')";
			prepareStatement = connection.prepareStatement(query);
			state = prepareStatement.executeUpdate();
			
			if (state > 0) {
				System.out.println(state + ":삽입성공");				
			} else {
				System.out.println(state + ":삽입실패");
			}
			
		} catch (Exception e) {			
			System.out.println(e.getMessage());
		} finally {
			try {				
				if (prepareStatement != null) {
					prepareStatement.close();
				}
				if (connection != null) {
					connection.close();
				}	

			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return state;
	}
	
	//BoardList 작성
	public ArrayList<BoardDTO> anSelectBoard() {		
		
		ArrayList<BoardDTO> adtos = new ArrayList<BoardDTO>();
		Connection connection = null;
		PreparedStatement prepareStatement = null;
		ResultSet resultSet = null;		
		
		try {
			connection = dataSource.getConnection();
			String query = "select * from board" 
							+ " order by board_notice, board_write_date desc";
			prepareStatement = connection.prepareStatement(query);
			resultSet = prepareStatement.executeQuery();
			
			while (resultSet.next()) {
				String board_id = resultSet.getString("board_id");
				String board_nickname = resultSet.getString("board_nickname");
				String board_content = resultSet.getString("board_content");
				Date board_write_date = resultSet.getDate("board_write_date");
				int board_readcount = resultSet.getInt("board_readcount");
				String board_image_path = resultSet.getString("board_image_path");				
				int board_notice = resultSet.getInt("board_notice");
				int qna_ref_num = resultSet.getInt("qna_ref_num");
				String id_image_path = resultSet.getString("id_image_path");		

				BoardDTO adto = new BoardDTO(board_id,board_nickname,board_content,board_write_date,
						board_readcount,board_image_path,board_notice,qna_ref_num, id_image_path);
				adtos.add(adto);			
			}	
			
			System.out.println("adtos개수" + adtos.size());
			
		} catch (Exception e) {
			
			System.out.println(e.getMessage());
		} finally {
			try {			
				
				if (resultSet != null) {
					resultSet.close();
				}
				if (prepareStatement != null) {
					prepareStatement.close();
				}
				if (connection != null) {
					connection.close();
				}	

			} catch (Exception e) {
				e.printStackTrace();
			} finally {

			}
		}

		return adtos;

	}
	
	/*
	 * //濡쒓렇�씤 硫붿냼�뱶 public String anLogin(String id, String passwd) {
	 * 
	 * Connection connection = null; PreparedStatement prepareStatement = null;
	 * ResultSet rs = null; String msg = "�븘�씠�뵒 �삉�뒗 鍮꾨�踰덊샇媛� �씪移섑븯吏� �븡;;�뒿�땲�떎!";
	 * 
	 * try { connection = dataSource.getConnection(); String query =
	 * "select id,passwd from member"; prepareStatement =
	 * connection.prepareStatement(query); rs = prepareStatement.executeQuery();
	 * 
	 * while(rs.next()) { if(rs.getString("id").equals(id) &&
	 * rs.getString("passwd").equals(passwd)) { System.out.println("濡쒓렇�씤 �꽦怨�!"); msg =
	 * "濡쒓렇�씤 �꽦怨�!"; break; } }
	 * 
	 * } catch (Exception e) { System.out.println(e.getMessage()); } finally { try {
	 * if (prepareStatement != null) { prepareStatement.close(); } if (connection !=
	 * null) { connection.close(); }
	 * 
	 * } catch (Exception e) { e.printStackTrace(); } } return msg; }
	 */
	
}