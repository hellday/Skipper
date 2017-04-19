package websockets;

import java.io.IOException;
import java.sql.SQLException;
import java.util.Queue;
import java.util.concurrent.ConcurrentLinkedQueue;

import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

import com.google.gson.Gson;

import database.DBAction;



//annotation sur la classe qui définit le nom permettant d’accéder au websocket
//ws://adrIP:port/chemin/application/echo
@ServerEndpoint("/echo")
public class EchoWebSockServer {

	//données statique stockant la liste des  websocket ouverts.
	static Queue<Session> queue = new ConcurrentLinkedQueue<>();
	

	public static void send(String message) {
		
        try {
            for (Session session : queue) {
                session.getBasicRemote().sendText(message);
            }
        } catch (IOException e) {
            System.out.println(e.getMessage());
        }
    }
	
	@OnMessage
	public void recep(String message, Session s) {
		System.out.println("Reception du message client : " + message);
		//send(message);
		int idNav = Integer.parseInt(message); 
		test(idNav);
		
	}
	
	@OnOpen
	public void open(Session session) {
		     queue.add(session);
		     System.out.println("Ouverture de session");
	}
	
	@OnClose
	public void close(Session session) {
		       queue.remove(session);
		       System.out.println("Fermeture de session");
	}

	@OnError
	public void error(Session session, Throwable t) {

	}
	
	public void test(int nav) {
		DBAction.DBConnexion();
		
		String latLng = "";
		String                 req       = ("SELECT latitude, longitude FROM locations WHERE idNav='" + nav + "'");

        try {
            DBAction.setRes(DBAction.getStm().executeQuery(req));
        } catch (SQLException ex) {
        	System.out.println(ex.getErrorCode());
        }
        
        try {
        	System.out.println("On a : " +latLng);
			while (DBAction.getRes().next()) {
				
				if(DBAction.getRes().isFirst()){
				latLng = String.valueOf(DBAction.getRes().getDouble(1)) + ", " + String.valueOf(DBAction.getRes().getDouble(2));
				}else {
					latLng = latLng + String.valueOf(DBAction.getRes().getDouble(1)) + ", " + String.valueOf(DBAction.getRes().getDouble(2));
				}
				
				if(DBAction.getRes().isLast()) {
					
				}else{
					latLng = latLng + "%";
				}
			}
			send(latLng);
			System.out.println("On a : " +latLng);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        
	}


	
}
