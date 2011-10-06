<%-- 
    Document   : listaUsuarios
    Created on : 23/09/2011, 09:44:30
    Author     : a968501
--%>

<%@page import="entidades.Usuario"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="head.jsp" %>
        <title>JSP Page</title>
    </head>
    <body>
        <%
            if (session.getAttribute("usuario") == null) {
                response.sendRedirect("login.jsp");
            } else {
                List<Usuario> usuarios = (List<Usuario>) session.getAttribute("usuarios");
                if (usuarios != null) {
                    for (Usuario u : usuarios) {
                        out.println("<a href=\"ServletPerfil?id=" + u.getId() + "\">" + u.getNome() + "</a><br />");
                    }
                }

        %>
        <a href="Login">Sair</a>
        <a href="home.jsp">Voltar</a>

        <%
            }
        %>

    </body>
</html>
