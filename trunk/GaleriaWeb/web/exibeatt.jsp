<%-- 
    Document   : exibeatt
    Created on : 08/12/2011, 00:53:05
    Author     : João
--%>

<%@page import="entidades.Atualizacao"%>
<%@page import="dao.DaoAtualizacao"%>
<%@page import="java.util.List"%>
<%@page import="entidades.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <%@include file="head.jsp" %>
        <title>Atualizações</title>
    </head>
    <body>
        <%-- HEADER --%>
        <%@include file="header.jsp" %>
        <%-- BODY --%>
        <div class="bgcontainer">
            <div class="container">
                <h2 style="margin-bottom: 25px">Lista de Ataulizações</h2>
                <ul class="att">
                    <%
                        Usuario u = (Usuario) (session.getAttribute("usuario"));
                        if (u == null) {
                            response.sendRedirect("login.jsp");
                        } else {
                            DaoAtualizacao daoAtualizacao = new DaoAtualizacao(Atualizacao.class);
                            List<Atualizacao> atts = daoAtualizacao.listAttFromUser(u.getId());
                            if (atts.isEmpty()) {
                                out.println("<p>Você não possui atualizaçoes</p>");
                            } else {
                                for (Atualizacao at : atts) { //mostras as atts
                                    if (at.getImagem() == null && at.getComentario() == null) {
                    %>
                    <li>
                        <a href="ServletPerfil?id=<%= at.getRemetente().getId()%>"><%=(at.getRemetente().getNome())%></a> <%=at.getTipo()%>
                    </li>
                    <% } else {
                        if (at.getImagem() == null) {   //att de comentario
                    %>  
                    <li>
                        <a href="ServletPerfil?id=<%= at.getRemetente().getId()%>"><%=(at.getRemetente().getNome())%></a>
                        <%=at.getTipo()%> 
                        <a href="paginaRecados.jsp?idUsuario=<%=at.getComentario().getDestinatinatario().getId()%>">ver</a> 
                    </li>
                    <%                            } else { //att de imagem 
                    %>
                    <li><a href="ServletPerfil?id=<%= at.getRemetente().getId()%>"><%=(at.getRemetente().getNome())%></a>
                        <%=at.getTipo()%> na imagem  
                        <a href="exibeImagem.jsp?idUsuario=<%=at.getImagem().getGaleria().getUsuario().getId()%>&idImagem=<%=at.getImagem().getId()%>"><%=at.getImagem().getNome()%></a>
                    </li>
                    <%                            }                             //chamar exibe imagem          
                                    }
                                } //exclui todas elas
                                daoAtualizacao.removeAll(u.getId());
                            }
                        }
                    %>
                </ul>
            </div>            
        </div>
        <%-- FOOTER --%>
        <%@include file="footer.jsp" %>
    </body>
</html>
