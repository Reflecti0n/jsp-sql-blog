<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
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
<div id="content"> 
                <form action="<%= request.getContextPath() %>/Register" method="post">
                    <p>Nazwa użytkownika: <input type="text" name="username"  placeholder="login" required/></p>
                    <p>Hasło(min. 6 znaków): <input type="password" name="password"  placeholder="hasło" required/></p>
                    <p>Powtórz hasło: <input type="password" name="password2" placeholder="hasło" required/></p>
                    <p><input type="submit" name="submit" value="Zarejestruj"/></p>

</div>
<% 
if(request.getParameter("error")!=null)
    {
    int error_code=Integer.parseInt(request.getParameter("error"));
    if(error_code==1){
    %>
    Nazwa użytkownika jest zajęta.
    <%
       }
else if(error_code==2){
    %>
     Wprowadzone hasła się różnią.
      <%      }
else if(error_code==3){
    %>
    
     Hasło musi mieć conajmniej 6 znaków.
     <%
}
}               
%>
    </body>
    
</html>
