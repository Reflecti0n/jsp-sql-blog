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

public class Validate extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        
        //pobieranie danych z formularza metoda GET
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            //inicjowanie zmiennych do przechowywania danych z bazy
            String dbusername = null;
            String dbpassword = null;
            Boolean dbpermission = null;
            Boolean subscribe=false;
            HttpSession session=request.getSession();

            try{
            Connection conn = null;
            
            Class.forName("org.postgresql.Driver");

            conn=DriverManager.getConnection("");
            Statement stat=conn.createStatement();
            
            //sprawdzanie w bazie czy uzytkownik istnieje
            ResultSet rs = stat.executeQuery("SELECT * FROM users WHERE username='"+username+"';");
            if(rs.next()){
                //podstawianie danych z bazy do zmiennych 
                dbpassword = rs.getString(3);
                dbpermission = rs.getBoolean(5);
                out.print(dbpassword);
                out.print(dbpermission);
            //sprawdzanie  czy haslo jest poprawne
            if (dbpassword.compareTo(password) == 0)
            {
                if (dbpermission == true)
                {
                    
                    //sprawdzanie czy uzytkownik subskrybuje
                    String query2="SELECT subscribe FROM users WHERE username='"+username+"'";
                    ResultSet sub = stat.executeQuery(query2);
                    while(sub.next()){
                    subscribe = sub.getBoolean(1);
                    }
                    sub.close();
                    //ustawianie atrybutów sesji
                    session.setAttribute("subscriber", subscribe);
                    session.setAttribute("IsLogged", "true");
                    session.setAttribute("IsAdmin", "true");
                    session.setAttribute("user",username);
                    response.sendRedirect("index.jsp");
                    
                }
                else
                {
                    //sprawdzanie czy uzytkownik subskrybuje
                    String query2="SELECT subscribe FROM users WHERE username='"+username+"'";
                    ResultSet sub = stat.executeQuery(query2);
                    while(sub.next()){
                    subscribe = sub.getBoolean(1);
                    }
                    sub.close();
                    
                    //ustawianie atrybutów sesji
                    session.setAttribute("subscriber", subscribe);
                    session.setAttribute("IsLogged", "true");
                    session.setAttribute("user",username);
                    response.sendRedirect("index.jsp");
                }
            }
            else 
            {
               //przekierowanie w przypadku bledu
                response.sendRedirect("index.jsp?error");
            }  
            
            }
            
            rs.close();
            conn.close();
            
            } 
            catch (SQLException ex) {
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