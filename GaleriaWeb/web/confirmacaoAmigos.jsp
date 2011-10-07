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
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <%@include file="head.jsp" %>
        <title>JSP Page</title>
    </head>
    <body>
        <%
            Usuario u = (Usuario) (session.getAttribute("usuario"));
            if (u == null) {
                response.sendRedirect("login.jsp");
            } else {
                boolean agoraeh = (Boolean) session.getAttribute("agoraeh");
                Usuario perfil = (Usuario) session.getAttribute("perfil");
                if (agoraeh) {
        %>
        <h2><a href="home.jsp" >Você</a> e <a href="ServletPerfil?id=<%= perfil.getId()%>"><%=perfil.getNome()%></a> agora são amigos</a></h2>
            <%                        } else {
            %>
    <h2><a href="home.jsp" >Você</a> e <a href="ServletPerfil?id=<%= perfil.getId()%>"><%=perfil.getNome()%></a> agora não são mais amigos</a></h2>
        <%            }
        %>

<%            }
%>
</body>
</html>
