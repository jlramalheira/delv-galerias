<%-- 
    Document   : home
    Created on : 02/09/2011, 09:37:00
    Author     : aluno
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
        if (session.getAttribute("usuario")==null){
            response.sendRedirect("login.jsp");
        } else {
        %>
        <h1> Bem Vindo!! <%=((Usuario)(session.getAttribute("usuario")))%> </h1>
        <a href="editarperfil.jsp">Editar</a>
        <a href="Login">Sair</a>
        <%
        }
        %>
    </body>
</html>
