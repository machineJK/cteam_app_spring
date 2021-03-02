package fcm;

import java.io.FileInputStream;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Component;

import com.google.auth.oauth2.GoogleCredentials;
import com.google.firebase.FirebaseApp;
import com.google.firebase.FirebaseOptions;
import com.google.firebase.messaging.FirebaseMessaging;
import com.google.firebase.messaging.Message;

@Component
public class FcmUtil  {
	public void send_FCM(String token, String title, String name, String content, HttpServletRequest request) {
	      try {
	         FileInputStream refreshToken = 
	               new FileInputStream(request.getSession().getServletContext()
	                     .getRealPath("/resources/fcm")
	                     + "/myproject-4683c-firebase-adminsdk-6e1qb-05de48800f.json");
	         
	         FirebaseOptions options = FirebaseOptions.builder()
	                .setCredentials(GoogleCredentials.fromStream(refreshToken))
	                .setDatabaseUrl("https://myproject-4683c-default-rtdb.firebaseio.com")
	                .build();
	         
	         //Firebase ó�� ȣ��ÿ��� initializing ó��
	         if(FirebaseApp.getApps().isEmpty()) {
	            FirebaseApp.initializeApp(options);
	         }
	         
	         //�޼��� �ۼ�
	         Message msg = Message.builder()
	               .putData("title", title)
	               .putData("name", name)
	               .putData("body", content)
	               .putData("color", "#f45342")
	               .setToken(token)
	               .build();
	         
	         //�޼����� FirebaseMessaging�� ������
	         String response = FirebaseMessaging.getInstance().send(msg);
	         //������
	         System.out.println("Successfully sent message: " + response);
	         
	      } catch (Exception e) {
	         e.printStackTrace();
	      }
	   }
	 
}
