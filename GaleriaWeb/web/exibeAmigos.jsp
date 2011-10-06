<%-- 
    Document   : exibeAmigos
    Created on : 29/09/2011, 15:23:55
    Author     : João
--%>

<%@page import="java.util.List"%>
<%@page import="entidades.Usuario"%>
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
        Usuario u = (Usuario) (session.getAttribute("usuario"));
            if (u == null) {
                response.sendRedirect("login.jsp");
            } else {
            List<Usuario> amigos = (List<Usuario>)session.getAttribute("amigos");
            int pagina = (Integer)session.getAttribute("paginaatual");
            int quantidade = (Integer)session.getAttribute("quantidadepaginas");
            if ((pagina+1) * 20 > amigos.size()){
                for (int i = (pagina*20 - 20); i<amigos.size();i++){
                    Usuario user = amigos.get(i);
                    out.println("<a href=\"ServletPerfil?id=" + user.getId() + "\">" + user.getNome() + "</a><br />");
                }
            } else {
                for (int i = (pagina*20 - 20); i<=pagina*20;i++){
                    Usuario user = amigos.get(i);
                    out.println("<a href=\"ServletPerfil?id=" + user.getId() + "\">" + user.getNome() + "</a><br />");
                }
            }
        %>
        
        <%
            for (int i = 1; i<=quantidade;i++){
                out.println("<a href=\"ServletExibeAmigos?pagina="+i+"\">"+i+"</a>");
            }
           }
        %>
    </body>
</html>
