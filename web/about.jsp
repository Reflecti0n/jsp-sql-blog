<%@page import="java.sql.*"%>
<%@page import="java.util.Properties"%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Strona główna</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link rel="stylesheet" type="text/css" href="style.css" />
</head>

<body>
    <header>
        <h1>Blog</h1>
    </header>
    
    <div id="menuUp">
        <ul>
            <li><a href="index.jsp" title="Strona główna">Strona główna</a></li>
            <li><a href="#" title="O blogu">O blogu</a></li>
            <li><a href="contact.jsp" title="Kontakt">Kontakt</a></li>
        </ul>
    </div>
    
    <div id="mainContent">
        <div id="bar">
            <div id="loginPanel">
                <% 
                    if(session.getAttribute("IsLogged") == null)
                    {
                %>
                <p>Panel logowania</p>
                <form action="<%= request.getContextPath() %>/Validate" method="post">
                    <p><input type="text" name="username" maxlength="10" placeholder="login" required/></p>
                    <p><input type="password" name="password" maxlength="10" placeholder="hasło" required/></p>
                    <p><input type="submit" name="submit" value="Zaloguj"/></p>

                    <p>
                        <% 
                            if (request.getParameter("error") != null)
                            {
                                out.println("BŁĄD!");
                            }
                        %>
                    </p>
                    <p><a href="register.jsp" title="Zarejestruj się!">Zarejestruj się!</a></p>
                    </form>
                    <%
                    } else {
                        out.println("<p>Witaj, " + session.getAttribute("user") + ". <span><a href=\"" + request.getContextPath() + "/Logout\" alt=\"Wyloguj\">Wyloguj</a><span></p>");

                        if (session.getAttribute("IsAdmin") != null) {
                            out.println("<p><a href=\"adminpanel.jsp\" alt=\"Panel administratora\">Panel administratora</a></p>");
                        }
                        if (Boolean.parseBoolean(session.getAttribute("subscriber").toString()) == false) {
                    %>
                    <form action="<%= request.getContextPath()%>/Subscribe?sub=true" method="post"><br><br>Jeśli chcesz subskrybować tego bloga wpisz swój adres e-mail:<br><input type="text" name="email" placeholder="E-Mail" value="email"/>
                        <input type="submit" name="submit2" value="Subskrybuj"/>
                    </form>


                    <%} else {
                        %>
                    <form action="<%= request.getContextPath()%>/Subscribe?sub=false" method="post"><br><br>Jeśli chcesz przestać subskrybować bloga naciśnij przycisk<br>
                        <input type="submit" name="submit3" value="Anuluj subskrypcję"/>
                    </form>
                    <%
                                           }}
                    %>
            </div>
            
<div id="reserved">
           
            
            </div></div><div id="content"> <% 
                
                {
                    out.println("<h4>Blog</h4>");
                }
                                   
%>
                        
                        
                        
                        
                        
                        
                        
                        
                        
                                                                         
               
                    
            </div>
                             
                            
</body>
</html>                
