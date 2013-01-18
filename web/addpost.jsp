<%
   if (session.getAttribute("IsAdmin") == null)
   {
        response.sendRedirect(request.getContextPath());
   }
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Dodaj newsa</title>
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
        <%     if("ok".equals(request.getParameter("status"))){ %>
        <b> POST DODANY POMYSLNIE</b>
        <%}
               else if ("error".equals(request.getParameter("status"))){
        %>
        <b> WYSTĄPIŁ BŁĄD PRZY DODAWANIU</b>
        <% } %>
    <center>
                    <form action="<%= request.getContextPath() %>/AddPost"  method="post">
                    <p>Dodane przez:<% out.print(session.getAttribute("user")); %>
                    <p>Nagłówek:<input type="text" name="naglowek" size="100"  required/></p>
                    <p>Treść:<textarea type="text" name="tresc" rows="15" cols="40" required/></textarea></p>
                    <p><input type="submit" name="submit" value= "Dodaj"/></p>
    </center>
    
    
    </body>
</html>
