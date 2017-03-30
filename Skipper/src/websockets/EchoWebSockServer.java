package websockets;

import java.io.IOException;
import java.util.Queue;
import java.util.concurrent.ConcurrentLinkedQueue;

import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

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
		send(message);
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


	
}
