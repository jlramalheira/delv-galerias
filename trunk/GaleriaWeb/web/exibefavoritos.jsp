<%-- 
    Document   : exibefavoritos
    Created on : 09/12/2011, 00:49:25
    Author     : João
--%>

<%@page import="dao.DaoUsuario"%>
<%@page import="entidades.Imagem"%>
<%@page import="dao.DaoImagem"%>
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
            Usuario u = (Usuario) (session.getAttribute("usuario"));
            if (u == null) {
                response.sendRedirect("login.jsp");
            } else {
                int id = u.getId();
                if (request.getParameter("idUsuario") != null) {
                    id = Integer.parseInt(request.getParameter("idUsuario"));
                }

        %>
        <%-- HEADER --%>
        <%@include file="header.jsp" %>
        <%-- BODY --%>
        <div class="bgcontainer">
            <div class="container">
                <%-- GALERIA --%>
                <ul class="galeria">
                    <%
                        List<Imagem> imagens = ((Usuario)new DaoUsuario(Usuario.class).get(id)).getFavoritos();
                        if (!imagens.isEmpty()) {
                            for (Imagem i : imagens) {
                                String nomeImagem = i.getNome();
                                String caminho = i.getImagem().substring(0, i.getImagem().lastIndexOf("/"));
                                caminho += "/mini_";
                                caminho += i.getImagem().substring(i.getImagem().lastIndexOf("/") + 1);
                    %>
                    <li>
                        <a href="exibeImagem.jsp?idImagem=<%=i.getId()%>&idUsuario=<%=i.getGaleria().getUsuario().getId()%>">
                            <img src="<%= caminho%>" alt="Imagem Usuario" /><br/>
                            <%= nomeImagem%>
                        </a>
                    </li>
                    <%            }
                        } else {
                            out.println("<p>nao possui nenhuma imagem favoritada</p>");
                        }
                    %>
                </ul>
            </div>            
        </div>
        <%
            }
        %>
        <%-- FOOTER --%>
        <%@include file="footer.jsp" %>
    </body>
</html>
