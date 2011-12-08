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
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
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
                    for (Atualizacao a : atts) { //mostras as atts
                        if (a.getImagem() == null && a.getComentario() == null) {
        %>
        <p>
            <a href="ServletPerfil?id=<%= a.getRemetente().getId()%>"><%=(a.getRemetente().getNome())%></a> <%=a.getTipo()%>
        </p>
        <% } else {
            if (a.getImagem() == null) {   //att de comentario
        %>  
        <p>
            <a href="ServletPerfil?id=<%= a.getRemetente().getId()%>"><%=(a.getRemetente().getNome())%></a>
            <%=a.getTipo()%> 
            <a href="paginaRecados.jsp?idUsuario=<%=a.getComentario().getDestinatinatario().getId() %>">ver</a> 
        </p>
        <%                            } else { //att de imagem 
        %>
        <a href="ServletPerfil?id=<%= a.getRemetente().getId()%>"><%=(a.getRemetente().getNome())%></a>
        <%=a.getTipo()%> na imagem  
        <a href="exibeImagem.jsp?idUsuario=<%=a.getImagem().getGaleria().getUsuario().getId()%>&idImagem=<%=a.getImagem().getId()%>"><%=a.getImagem().getNome()%></a>  
        <%                            }                             //chamar exibe imagem          
                        }
                    } //exclui todas elas
                    daoAtualizacao.removeAll(u.getId());
                }
            }
        %>
    </body>
</html>
