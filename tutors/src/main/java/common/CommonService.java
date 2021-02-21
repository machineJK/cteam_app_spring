package common;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.mail.EmailAttachment;
import org.apache.commons.mail.HtmlEmail;
import org.apache.commons.mail.MultiPartEmail;
import org.apache.commons.mail.SimpleEmail;
import org.json.JSONObject;
import org.springframework.stereotype.Service;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;

@Service
public class CommonService {
	
	//파일다운로드
	public File fileDownload(String filename, String filepath, 
					HttpSession session, HttpServletResponse response) {
		//다운로드할 파일객체를 생성
		File file = new File(session.getServletContext().getRealPath("resources") + "/" + filepath);
		//content type 지정을 위한 파일의 MIMEtype
		String mime = session.getServletContext().getMimeType(filename);
		
		response.setContentType(mime);
		try {
			//한글 안깨짐, 빈공간이 +로 출력되는걸 공백으로 처리(아스키코드 참고)
			filename = URLEncoder.encode(filename, "utf-8").replaceAll(
					"\\+", "%20");
			response.setHeader("content-disposition", "attachment; filename=" + filename);
			
			
			ServletOutputStream out = response.getOutputStream();
			FileCopyUtils.copy(new FileInputStream(file), out);
			out.flush();
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		
		return file;
		
	}
	
	
	public String fileUpload(HttpSession session, MultipartFile file, String category) {
		//서버의 물리적위치(getServletContext까지는 iot까지 나옴)
		String resources = session.getServletContext().getRealPath("resources");
		// D://Study_Spring/.../iot/resources/upload/notice/2021/02/03/abc.txt
		String upload =  resources + "/upload";		//upload
		String folder = upload + "/" + category		//notice
					+ "/" + new SimpleDateFormat("yyyy/MM/dd").format(new Date());
		
		File f = new File(folder);
		if(!f.exists()) {
			f.mkdirs();
		}
		String uuid = UUID.randomUUID().toString() + "_" + file.getOriginalFilename();
		
		try {
			file.transferTo(new File(folder, uuid));
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		
		
		return folder.substring(resources.length() + 1) + "/" + uuid;
	}
	
	
	
	//이메일 전송 메소드
	public void sendEmail(HttpSession session, String email, String name) {
		
		//기본 이메일전송
		//sendSimple(email,name);
		
		//파일첨부이메일전송
		//sendAttach(session,email,name);
		
		//HTML 형태 이메일 전송
		sendHtml(session,email,name);
	}
	
	private void sendHtml(HttpSession session, String email, String name) {
		HtmlEmail mail = new HtmlEmail();
		mail.setHostName("smtp.naver.com");
		mail.setDebug(true);
		mail.setCharset("utf-8");
		
		mail.setAuthentication("wai95", "5c2d1596c3");
		mail.setSSLOnConnect(true);
		
		try {
			mail.setFrom("wai95@naver.com","한울관리자");
			mail.addTo(email,name);
			
			mail.setSubject("회원가입축하 -HTML");
			StringBuffer msg = new StringBuffer();
			msg.append("<html>");
			msg.append("<body>");
			msg.append("<a href='https://humoruniv.com'><img src='https://upload2.inven.co.kr/upload/2019/06/06/bbs/i15412326664.jpg'/></a>");
			msg.append("<hr>");
			msg.append("<h2>한울 IoT과정 가입 축하</h2>");
			msg.append("<p>회원가입을 축하합니다</p>");
			msg.append("<p>첨부된 파일을 꼭 확인해 주시고</p>");
			msg.append("<p>프로젝트까지 마무리해서</p>");
			msg.append("<p>취업에 성공하시기 바랍니다</p>");
			msg.append("</body>");
			msg.append("</html>");
			mail.setHtmlMsg(msg.toString());
			
			EmailAttachment file = new EmailAttachment();
			file.setURL(new URL("https://upload2.inven.co.kr/upload/2019/06/06/bbs/i15412326664.jpg"));
			mail.attach(file);
			
			mail.send();
			
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		
	}
	
	
	private void sendAttach(HttpSession session,String email, String name) {
		MultiPartEmail mail = new MultiPartEmail();
		mail.setHostName("smtp.naver.com");
		mail.setCharset("utf-8");
		mail.setDebug(true);
		
		mail.setAuthentication("wai95", "5c2d1596c3");
		mail.setSSLOnConnect(true);
		
		try {
			mail.setFrom("wai95@naver.com","한울관리자");
			mail.addTo(email,name);
			mail.setSubject("회원가입축하 메세지 - 첨부파일확인요망");
			mail.setMsg("회원가입을 축하합니다. 첨부된 파일을 확인하세요!");
			//파일첨부하기
			EmailAttachment file = new EmailAttachment();
			//절대경로
			file.setPath("C:\\Users\\hanul\\Desktop\\images\\isely.jpg");
			mail.attach(file);
			
			file = new EmailAttachment();
			//상대경로
			file.setPath(session.getServletContext().getRealPath("resources") 
					 + "/images/kakao_login");
			mail.attach(file);
			
			file = new EmailAttachment();
			//url
			file.setURL(new URL("https://upload2.inven.co.kr/upload/2019/06/06/bbs/i15412326664.jpg"));
			mail.attach(file);
			
			mail.send();
		}catch(Exception e){
			System.out.println(e.getMessage());
		}
		
	}
	
	
	private void sendSimple(String email, String name) {
		SimpleEmail mail = new SimpleEmail();
		
		mail.setHostName("smtp.naver.com");	//메일서버지정
		mail.setCharset("utf-8");
		mail.setDebug(true);
		
		//로그인하기 위한 아이디/비번 지정
		mail.setAuthentication("wai95", "5c2d1596c3");
		mail.setSSLOnConnect(true);
		
		try {
			//메일 송신인 지정
			mail.setFrom("wai95@naver.com","한울관리자");
			//메일 수신인 지정
			mail.addTo(email,name);	//여러 명에게 보낼때는 addTo 만 추가
			
			//메일제목
			mail.setSubject("회원가입축하 메세지");
			mail.setMsg("회원가입을 축하합니다! 이제부터 당신은 한울회사의 주주가 되었으며 열심히 일해주시기 바랍니다"
					+ "\n\n 권극모");
			
			//메일 전송버튼 클릭
			mail.send();
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		
	}
	

	public String requestAPI(StringBuffer url, String property) {
		String result = url.toString();
		try {
			HttpURLConnection conn 
			= (HttpURLConnection)new URL( result ).openConnection();
			conn.setRequestMethod("GET");
			conn.setRequestProperty("Content-type", "application/json");
			conn.setRequestProperty("Authorization", property);
			
			BufferedReader reader;
			if( conn.getResponseCode()>=200 && conn.getResponseCode()<=300 ) {
				reader = new BufferedReader( new InputStreamReader(
										conn.getInputStream(), "utf-8" ) );
			}else {
				reader = new BufferedReader( new InputStreamReader(
										conn.getErrorStream(), "utf-8" ) );
			}
			url = new StringBuffer();
			while( (result = reader.readLine())!=null ) {
				url.append(result);
			}
			reader.close();
			conn.disconnect();
			result = url.toString();
			
		}catch(Exception e) {
			System.out.println(e.getMessage());
		}
		return result;
	}
	
	public String requestAPI(StringBuffer url) {
		String result = url.toString();
		try {
			HttpURLConnection conn 
			= (HttpURLConnection)new URL( result ).openConnection();
			conn.setRequestMethod("GET");
			conn.setRequestProperty("Content-type", "application/json");
			
			BufferedReader reader;
			if( conn.getResponseCode()>=200 && conn.getResponseCode()<=300 ) {
				reader = new BufferedReader( new InputStreamReader(
										conn.getInputStream(), "utf-8" ) );
			}else {
				reader = new BufferedReader( new InputStreamReader(
										conn.getErrorStream(), "utf-8" ) );
			}
			url = new StringBuffer();
			while( (result = reader.readLine())!=null ) {
				url.append(result);
			}
			reader.close();
			conn.disconnect();
			result = url.toString();
			
		}catch(Exception e) {
			System.out.println(e.getMessage());
		}
		return result;
	}
	
	public String json_list(String list) {
		JSONObject json = null;
		
		json = new JSONObject(list);
		json = (JSONObject) json.get("response");
		json = (JSONObject) json.get("body");
		int count = json.getInt("totalCount");
		json = (JSONObject) json.get("items");
		
		json.put("count", count);
		return json.toString();
	}
	
	
	
	
}