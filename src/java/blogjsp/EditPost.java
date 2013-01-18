package blogjsp;

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

import java.util.Date;
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

public class EditPost extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
            HttpSession session=request.getSession();
            
            //pobieranie danych z formularza metoda POST
            String naglowek = request.getParameter("naglowek");
            String tresc = request.getParameter("tresc");
            int id = Integer.parseInt(request.getParameter("id"));
            
            
            try{
                
                //wywolywanie polaczenia
            Connection conn = null;
            Class.forName("org.postgresql.Driver");
            conn=DriverManager.getConnection("");
            Statement stat=conn.createStatement();
            
            //aktualizowanie posta
            String query = "UPDATE posts SET naglowek ='"+naglowek+"', tresc='"+tresc+"' WHERE id="+id+";";
            stat.executeUpdate(query);
            stat.close();
            conn.close();
            response.sendRedirect("editpost.jsp?status=ok");
            
            
            } 
            catch (SQLException ex) {
            Logger.getLogger(Validate.class.getName()).log(Level.SEVERE, null, ex);
            response.sendRedirect("editpost.jsp?status=error");
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(Validate.class.getName()).log(Level.SEVERE, null, ex);
            response.sendRedirect("editpost.jsp?status=error");
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