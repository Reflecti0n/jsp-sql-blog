/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package blogjsp;

import java.io.*;
import java.net.*;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.mail.AuthenticationFailedException;
import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.*;
import javax.servlet.http.*;

public class Notify extends HttpServlet {
@Override
    protected void doPost(HttpServletRequest request, 
                                  HttpServletResponse response)
                   throws IOException, ServletException {

        final String err = "/error.jsp";
        final String succ = "/AddPost.jsp";
        //
        String from = "DO UZUPELNIENIA";
        String to;
        String subject = "Dodano nowy wpis na blogu";
        String login = "DO UZUPELNIENIA";
        String password = "DO UZUPELNIENIA";        
        
        
        String naglowek = request.getParameter("naglowek");
        String tresc = request.getParameter("tresc");
        String message = "Wlasnie został dodany nowy post na blogu, który subskrybujesz. Jego treść to: "+"\n<b>"+naglowek+"</b>\n"+tresc;


        try {
            
            //ustawianie parametrow polaczenia z serwerem SMTP
            Properties props = new Properties();
            props.setProperty("mail.host", "smtp.gmail.com");
            props.setProperty("mail.smtp.port", "587");
            props.setProperty("mail.smtp.auth", "true");
            props.setProperty("mail.smtp.starttls.enable", "true");

            //autentykacja loginu i hasla
            Authenticator auth = new SMTPAuthenticator(login, password);

            Session session = Session.getInstance(props, auth);
            
            //wywolanie polaczenia z baza danych
            Connection conn = null;
            Class.forName("org.postgresql.Driver");
            conn=DriverManager.getConnection("");
            Statement stat=conn.createStatement();
            
            //zapytanie o emaile ktore subskrybuja
            String query = "SELECT email from users WHERE subscribe=TRUE";
            
            //tworzenie zbioru wynikow
            ResultSet emails = stat.executeQuery(query);
            
            //petla wysylania emaili
            while(emails.next()){
            to = emails.getString(1);
            MimeMessage msg = new MimeMessage(session);
            msg.setText(message);
            msg.setSubject(subject);
            msg.setFrom(new InternetAddress(from));
            msg.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
            Transport.send(msg);
            }
            //przekierowanie na strone dodawania postow
            response.sendRedirect("addpost.jsp?status=ok");
        } 
        catch (AuthenticationFailedException ex) {
            request.setAttribute("ErrorMessage", "Authentication failed");

            RequestDispatcher dispatcher = request.getRequestDispatcher(err);
            dispatcher.forward(request, response);

        } catch (AddressException ex) {
            request.setAttribute("ErrorMessage", "Wrong email address");

            RequestDispatcher dispatcher = request.getRequestDispatcher(err);
            dispatcher.forward(request, response);
        }
          catch (SQLException ex) {
            Logger.getLogger(Validate.class.getName()).log(Level.SEVERE, null, ex);
            response.sendRedirect("index.jsp?status=error");
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(Validate.class.getName()).log(Level.SEVERE, null, ex);
            response.sendRedirect("index.jsp?status=error");
        } catch(Exception e)
        {e.printStackTrace();
        }
    }

    private class SMTPAuthenticator extends Authenticator {

        private PasswordAuthentication authentication;

        public SMTPAuthenticator(String login, String password) {
            authentication = new PasswordAuthentication(login, password);
        }

        protected PasswordAuthentication getPasswordAuthentication() {
            return authentication;
        }
    }
}
