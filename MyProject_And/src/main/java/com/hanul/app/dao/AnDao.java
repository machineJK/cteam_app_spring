package com.hanul.app.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import com.hanul.app.dto.MemberDTO;

public class AnDao {
	DataSource dataSource;

	//DB���� �޼ҵ�
	public AnDao() {
		try {
			Context context = new InitialContext();
			dataSource = (DataSource) context.lookup("java:/comp/env/cteam");
			/*dataSource = (DataSource) context.lookup("java:/comp/env/CSS");*/
		} catch (NamingException e) {
			e.getMessage();
		}

	}
	
	//ȸ������ �޼ҵ�(Insert)
	public int anJoin(String id, String pw, String nickname, String name,
			String gender, String birth, String email, String addr1,
			String addr2, String dbImgPath) {
		
		Connection connection = null;
		PreparedStatement prepareStatement = null;
		int state = -100;
		
		try {
			connection = dataSource.getConnection();
			String query = "insert into member(id,pw,nickname,name,gender,birth,email,addr1,addr2,dbImgPath) " + 
			               "values('" + id + "', '" + pw + "', '" + nickname + 
			               "', '" + name + "', '" + gender + 
			               "', '" + birth + "', '" + email + "', '" + addr1 + 
			               "', '" + addr2 + "', '" + dbImgPath + "')";
			prepareStatement = connection.prepareStatement(query);
			state = prepareStatement.executeUpdate();
			
			if (state > 0) {
				System.out.println(state + ":���Լ���");				
			} else {
				System.out.println(state + ":���Խ���");
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
				

				adto = new MemberDTO(id, pw, nickname, name, gender, 
						birth, email, addr1, addr2, dbImgPath);						
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
	
	/*
	 * //�α��� �޼ҵ� public String anLogin(String id, String passwd) {
	 * 
	 * Connection connection = null; PreparedStatement prepareStatement = null;
	 * ResultSet rs = null; String msg = "���̵� �Ǵ� ��й�ȣ�� ��ġ���� ��;;���ϴ�!";
	 * 
	 * try { connection = dataSource.getConnection(); String query =
	 * "select id,passwd from member"; prepareStatement =
	 * connection.prepareStatement(query); rs = prepareStatement.executeQuery();
	 * 
	 * while(rs.next()) { if(rs.getString("id").equals(id) &&
	 * rs.getString("passwd").equals(passwd)) { System.out.println("�α��� ����!"); msg =
	 * "�α��� ����!"; break; } }
	 * 
	 * } catch (Exception e) { System.out.println(e.getMessage()); } finally { try {
	 * if (prepareStatement != null) { prepareStatement.close(); } if (connection !=
	 * null) { connection.close(); }
	 * 
	 * } catch (Exception e) { e.printStackTrace(); } } return msg; }
	 */
	
}
