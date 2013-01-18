<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<%
//sprawdzanie czy jest adminem
   if (session.getAttribute("IsAdmin") == null)
   {
        response.sendRedirect(request.getContextPath());
   }
                //sprawdzanie czy uzytkownik zalogowany i czy jest adminem
                    if(session.getAttribute("IsLogged") == null || session.getAttribute("IsAdmin")== null)
                    {
                        response.sendRedirect("index.jsp");
                                               }
                    
                    int id=Integer.parseInt(request.getParameter("id"));
                    out.print(id);
                    
                    String naglowek="";
                    String tresc="";
     
                    
                    //inicjacja polaczenia               
Class.forName("org.postgresql.Driver");
Connection myConn = 
DriverManager.getConnection("");
    java.sql.Statement stmt = myConn.createStatement();
    
    
    String query = "SELECT naglowek,tresc FROM posts WHERE id="+id+";";
    ResultSet results = stmt.executeQuery(query);
    while(results.next()){
        naglowek = results.getString(1);
        tresc = results.getString(2);
    }        
%>
<html>
    <head>
        <title>Edytuj posty</title>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <link rel="stylesheet" type="text/css" href="style.css" />
    </head>
    <body>
            <div id="menuUp">
        <ul>
            <li><a href="index.jsp" title="Strona główna">Strona główna</a></li>
            <li><a href="about.jsp" title="O blogu">O blogu</a></li>
            <li><a href="kontakt.jsp" title="Kontakt">Kontakt</a></li>
        </ul>
    </div>
    <div id="mainContent">
    <div id="content">
        <center>            
                    <form action="<%= request.getContextPath() %>/EditPost"  method="post">
                    <input type="hidden" name="id" value="<%=id%>"/>
                    <p>Dodane przez:<% out.print(session.getAttribute("user")); %>
                    <p >Nagłówek:</p>
                    <p><textarea style="resize:none" type="text" name="naglowek" rows="1" cols="40" required/><%=naglowek%></textarea></p>
                    <p>Treść:<textarea style="resize:none" type="text" name="tresc" rows="15" cols="40" required/><%=tresc%></textarea></p>
                    <p><input type="submit" name="submit" value= "Dodaj"/></p>
                    </form>
        </center>
                    
    </div>
    </body>
                </html>
        