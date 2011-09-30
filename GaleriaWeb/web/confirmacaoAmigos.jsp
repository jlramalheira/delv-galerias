<%-- 
    Document   : confirmacaoAmigos
    Created on : 30/09/2011, 11:12:27
    Author     : a968501
--%>

<%@page import="entidades.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            Usuario u = (Usuario) (session.getAttribute("usuario"));
            if (u == null) {
                response.sendRedirect("login.jsp");
            } else {
                boolean agoraeh = (Boolean) session.getAttribute("agoraeh");
                if (agoraeh){
                    //mostra se eh
                } else{
                    //mostra se nao eh
                }
        %>
            
        <%            }
        %>
    </body>
</html>
