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
                List<Usuario> amigos = (List<Usuario>) session.getAttribute("amigos");
                if (amigos.isEmpty()) {
                    out.println("<h2>Você não possui nenhum amigo</h2>");
                } else {
                    int pagina = (Integer) session.getAttribute("paginaatual");
                    int quantidade = (Integer) session.getAttribute("quantidadepaginas");
        %>
        <form name="formpesquisaAmigos" action="ServletExibeAmigos" method="POST">
            <p><label for="nomeamigo">Nome:</label>
                <input type="text" name="nomeamigo" value="" id="nomeamigo"/></p>
            <input type="submit" value="Pesquisar" name="btPesquiar" />
        </form>
        <%
            if ((pagina + 1) * 20 > amigos.size()) {
                for (int i = (pagina * 20 - 20); i < amigos.size(); i++) {
                    Usuario user = amigos.get(i);
                    out.println("<a href=\"ServletPerfil?id=" + user.getId() + "\">" + user.getNome() + "</a><br />");
                }
            } else {
                for (int i = (pagina * 20 - 20); i <= pagina * 20; i++) {
                    Usuario user = amigos.get(i);
                    out.println("<a href=\"ServletPerfil?id=" + user.getId() + "\">" + user.getNome() + "</a><br />");
                }
            }
        %>
        <p> Paginas: 
            <%
                        for (int i = 1; i <= quantidade; i++) {
                            if (i == pagina) {
                                out.println(i);
                            } else {
                                out.println("<a href=\"ServletExibeAmigos?pagina=" + i + "\">" + i + "</a>");
                            }
                        }
                    }
                }
            %>
        </p>
    </body>
</html>
