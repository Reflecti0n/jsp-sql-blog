<%@page import="java.sql.*"%>
<%@page import="java.util.Properties"%>

<%
   if (session.getAttribute("IsAdmin") == null)
   {
        response.sendRedirect(request.getContextPath());
   }
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
//utworzenie parametrow polaczenia
Class.forName("org.postgresql.Driver");
Connection myConn = 
DriverManager.getConnection("");
    java.sql.Statement stmt = myConn.createStatement();
    
    //inicjacja zmiennych
    int posts_page=5;
    int total_posts;
    int pages;

    //sprawdzanie ktore posty wyswietlic
int start=0;
int offset=0;
    if(request.getParameter("page")!=null){
    offset = Integer.parseInt(request.getParameter("page"));
        if(offset>1){
        start = offset*posts_page-posts_page;
                    }
                                            }

    //zapytanie do bazy o ilosc wszystkich postow
    String query1 = "select count(*) from posts";
    ResultSet counter = stmt.executeQuery(query1);
    counter.next();
    total_posts = counter.getInt(1);
    
    //obliczanie ilosci stron    
    if(total_posts%posts_page==0) pages = total_posts/posts_page;
        else pages = total_posts/posts_page+1;
    
//String query="select * from posts";
//ResultSet myResultSet = stmt.executeQuery(query);
//if (myResultSet != null) {
//    while (myResultSet.next()) {
//      // specify the field name
//      String body = myResultSet.getString("tresc");
//      String headline = myResultSet.getString("naglowek");
//      String author = myResultSet.getString("autor");
//      String date = myResultSet.getString("czas");
//           }};
           
           
%>



<html>
    <head>
                <link rel="stylesheet" type="text/css" href="style.css" />
                <title>Edytuj posty</title>
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
        <div id="bar">
            <div id="loginPanel">
                <% 
                    if(session.getAttribute("IsLogged") == null || session.getAttribute("IsAdmin")== null)
                    {
                        response.sendRedirect("index.jsp");
                %>
                <%
                    }
                    else
                    {
                        out.println("<p>Witaj, "+session.getAttribute("user")+". <span><a href=\""+request.getContextPath()+"/Logout\" alt=\"Wyloguj\">Wyloguj</a><span></p>");

                        if (session.getAttribute("IsAdmin")!=null)
                        {
                            out.println("<p><a href=\"adminpanel.jsp\" alt=\"Panel administratora\">Panel administratora</a></p>");
                        }
                    }
                %>
            </div>
            
<div id="reserved">
           
            
            </div></div><div id="content"> 
                <% 
                        int count=0;
                        if(offset>1)
	   count=offset*posts_page-posts_page;
                            
                                out.println("<p>Ostatnie wpisy:</p>");
                   
                                
	  Statement st = myConn.createStatement();
	  String strQuery = "select * from posts order by id DESC offset "+start+" limit "+posts_page+";"; 
	 // out.println(strQuery);
	 
	  ResultSet rsPagination = st.executeQuery(strQuery);
                                
                                
  while(rsPagination.next())
  {
      int id = rsPagination.getInt("id");
      String tresc = rsPagination.getString("tresc");
      String naglowek = rsPagination.getString("naglowek");
      String autor = rsPagination.getString("autor");
      String czas =rsPagination.getString("czas");
      
  %>
    <TABLE BORDER="0" WIDTH=100%>
  <tr> 
    <td WIDTH=20><h1><b><%= naglowek %></b></h1></td>
  </tr>
  
  <tr><td width=20><i><%= czas %></i></td>

  <tr> 
    <td WIDTH=20><i><%= autor %></i></td>
  </tr>
  <tr> 
      <td WIDTH=20><%= tresc %></td>
  </tr>
</table>
  <a href="editpost2.jsp?id=<%=id%>">EDYTUJ</a>
  <a href="DeletePost?id=<%=id%>" onclick="return confirm('are you sure?')">           Usuń</a>
    <%
    
 } count++;%>
 <table width="100px" align="center" border=0><tr>

		 <%
      myConn.close();
	       if(offset>1)
		{
		   int previous = offset-1;
		%>
		<td>
		 <a href="editpost.jsp?page=<%=previous%>">Poprzednia</a></td>
		<%
		}

 if(pages>0)
		{
 for(int i=1;i<=pages;i++)
 {
	 if(request.getParameter("page")==null)
	 {
          offset=1;
	 }
	  if(i==offset)
	 {
		  %>
	     <td>
		<%=i%></td>
	  <%
	 }
     else{
	  %>
	     <td>
		 <a href="editpost.jsp?&page=<%=i%>"><%=i%></a></td>
	  <%
	 }
      
	}
		}

	
	   if(offset<pages)
		{
		   int next = offset+1;
		%>
		<td>
		 <a href="editpost.jsp?page=<%=next%>">Nastepna</a></td>
		<%
		}
%>
</tr>
</table>                 
    </body>
    
</html>