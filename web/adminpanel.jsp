<%
   if (session.getAttribute("IsAdmin") == null)
   {
        response.sendRedirect(request.getContextPath());
   }
%>
<%@page import="java.sql.*"%>
<%@page import="java.util.Properties"%>

<%@taglib prefix="tag" uri="/WEB-INF/tlds/Ullist.tld" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>ADMIN</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link rel="stylesheet" type="text/css" href="css/style.css" />
</head>
<body>
    <header>
        <h1>Dodaj wiadomosc</h1>
    </header>
           <div id="menuUp">
            <ul>
                <li><a href="index.jsp" title="Strona główna">Strona główna</a></li>
                <li><a href="about.jsp" title="O blogu">O blogu</a></li>
                <li><a href="kontakt.jsp" title="Kontakt">Kontakt</a></li>
            </ul>
        </div>
       <div id="mainContent">
        <div id="bar">
            <div id="panel">
               <%
                    out.println("<p>Witaj, "+session.getAttribute("logged")+". <span><a href=\""+request.getContextPath()+"/Logout\" alt=\"Wyloguj\">Wyloguj</a><span></p>");
               %>
               <p><a href="index.jsp" tite="Strona główna">Strona główna</a></p>
            </div>
               
           <div id="menu">
               <ul>
                   <% 
                      out.println("<a href=\"addpost.jsp\" title=\"Dodawanie\">Dodaj newsa</a>");
                      out.println("<a href=\"editpost.jsp\" title=\"Edytuj\">Edytuj lub usuń newsa</a>");
                   %>
               </ul>
            </div>
        </div>

        
        <div id="content">
           
         
           
        </div>
    </div>
    
   
</body>
</html>
