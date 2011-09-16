<%-- 
    Document   : editarperfil
    Created on : 09/09/2011, 11:09:52
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
        if (session.getAttribute("usuario")==null){            
            response.sendRedirect("login.jsp");            
        } else {
        %>
        <h1> Editar </h1>
        <p>Jota Bundão</p>
        <a href="home.jsp">Voltar</a>
        <%
        }
        %>
    </body>
</html>
