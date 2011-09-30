<%-- 
    Document   : exibeperfil
    Created on : 26/09/2011, 18:29:21
    Author     : João
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
            Usuario u = (Usuario) session.getAttribute("usuario");
            if (u == null) {
                response.sendRedirect("login.jsp");
            } else {
                Usuario perfil = (Usuario) session.getAttribute("perfil");
                if (perfil != null) {
                    out.println("<h1>" + perfil.getNome() + "</h1>");
                    out.println("<img src=\"/files/"+perfil.getId()+"/"+perfil.getImagem()+"\" />");
                    if (session.getAttribute("amigos") != null) {
                        boolean amigos = (Boolean) session.getAttribute("amigos");
                        if (!amigos && (u.getId() != perfil.getId())) {
        %>
        <form name="formadicionaamigo" action="ServletPerfil" method="POST">
            <button type="submit" name="btAdd" value="<%=perfil.getId()%>">Adicionar+</button>
        </form>
        <%              }
            if (amigos) {
        %>
        <form name="formRemoveamigo" action="ServletPerfil" method="POST">
            <button type="submit" name="btRemove" value="<%=perfil.getId()%>">Remove</button>
        </form>
        <%

                    }
                }
            } else {
                out.println("<h1>Usuario nao encontrado</h1>");
            }
        %>

        <%
            }
        %>
    </body>
</html>
