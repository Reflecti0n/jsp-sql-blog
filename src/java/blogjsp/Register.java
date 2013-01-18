package blogjsp;

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */


import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class Register extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        
        //pobieranie danych z formularza rejestracji metoda GET
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            String password2 = request.getParameter("password2");

            HttpSession session=request.getSession();
            
            //inicjacja polaczenia
            try{
            Connection conn = null;
            Class.forName("org.postgresql.Driver");
            conn=DriverManager.getConnection("");
            Statement stat=conn.createStatement();
            
            //sprawdzanie w bazie czy uzytkownik juz nie istnieje
            ResultSet rs = stat.executeQuery("SELECT * FROM users WHERE username='"+username+"'");
            if(rs.next()){
                response.sendRedirect("register.jsp?error=1");
            }
            //sprawdzanie czy podane hasla sa takie same
         
            else if(!(password.equals(password2))){
                response.sendRedirect("register.jsp?error=2");
            }
            
            //sprawdzanie czy haslo ma 6 znakow
            else if(password.length()<6){
                response.sendRedirect("register.jsp?error=3");  
            }
            
            //rejestrowanie uzytkownika w bazie danych
            else{
            stat.execute("INSERT INTO users(username,password,subscribe,admin) VALUES('"+username+"','"+password+"',false,false)");
            out.print("Rejestracja udana");
            
            //ustawianie atrybutow i przekierowanie na strone glowna
            session.setAttribute("IsLogged", "true");
            session.setAttribute("user", username);
            response.sendRedirect("index.jsp");

            }
            rs.close();
            conn.close();
            
            } catch (SQLException ex) {
            Logger.getLogger(Validate.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(Validate.class.getName()).log(Level.SEVERE, null, ex);
        } catch(Exception e){e.printStackTrace();}
        
        
          
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /** 
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
}