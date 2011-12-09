<%-- 
    Document   : exibeImagem
    Created on : 07/12/2011, 14:56:18
    Author     : João
--%>

<%@page import="dao.DaoComentario"%>
<%@page import="entidades.Comentario"%>
<%@page import="java.util.List"%>
<%@page import="dao.Dao"%>
<%@page import="entidades.Imagem"%>
<%@page import="entidades.Usuario"%>
<%@page import="dao.DaoImagem"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <%@include file="head.jsp" %>
        <title>Imagem</title>
    </head>
    <body>
        <%
            Usuario u = (Usuario) (session.getAttribute("usuario"));
            if (u == null || request.getParameter("idImagem") == null) {
                response.sendRedirect("login.jsp");
            } else {
                DaoImagem daoImagem = new DaoImagem(Imagem.class);
                int id = u.getId();
                if (request.getParameter("idUsuario") != null) {
                    id = Integer.parseInt(request.getParameter("idUsuario"));
                }
                int idImagem = Integer.parseInt(request.getParameter("idImagem"));
                Imagem i = (Imagem) daoImagem.get(idImagem);
                if (i != null) {
                    //Exibe o nome e caminho para o perfil certo
                    String nome = u.getNome();
                    String aux = "home.jsp";
                    if (id != u.getId()) {
                        nome = new Dao<Usuario>(Usuario.class).get(id).getNome();
                        aux = "ServletPerfil?id=" + id;
                    }
        %>
        <%-- HEADER --%>
        <%@include file="header.jsp" %>
        <%-- BODY --%>
        <div class="bgcontainer">
            <div class="container">
                <p class="voltar"><a href="<%= aux%>">Voltar as galerias de <%= nome%></a></p>                
                <%-- IMAGEM --%>
                <h2><%=i.getNome()%></h2>
                <p><%=i.getDescricao()%></p>
                <div class="imagem">
                    <img src="<%=i.getImagem()%>" alt="<%=i.getNome()%>"/>
                </div>                
                <%-- FAVORITAR IMAGEM --%>
                <%
                    //Um usuário não pode favoritar uma imagem a qual é dono
                    if (id != u.getId()) {
                        String name;
                        String msg;
                        //Se já favorito
                        if (u.getFavoritos().contains(i)) {
                            name = "btRemove";
                            msg = "Remover dos Favoritos";
                        } else {
                            name = "btAdd";
                            msg = "Adicionar aos Favoritos";
                        }
                %>
                <form name="formFavorita" action="ServletFavorito" method="POST">
                    <input type="hidden" name="idUsuario" value="<%=id%>" />
                    <button type="submit" name="<%=name%>" value="<%=i.getId()%>"><%=msg%></button>
                </form>
                <%
                    }
                %>
                <%-- COMENTÁRIOS --%>
                <%
                    DaoComentario daoComentario = new DaoComentario(Comentario.class);
                    int idDest = u.getId();
                    if (request.getParameter("idUsuario") != null) {
                        idDest = Integer.parseInt(request.getParameter("idUsuario"));
                    }
                %>
                <form style="margin: 0 auto; height: 80px;" name="formRecado" action="ServletComentario" method="POST" class="formulario">
                    <p><label for="recado">Recado:</label>
                        <textarea name="comentario" id="recado">Recado...</textarea><br />
                        <input type="submit" name="btComentario" value=""/>
                        <input type="hidden" name="idDest" value="<%=idDest%>" />
                        <input type="hidden" name="idImage" value="<%=i.getId()%>" />                        
                    </p>
                </form>
                <ul class="comentarios">
                    <%
                        List<Comentario> comentarios = daoComentario.listComentariosImages(idDest);
                        if (comentarios.isEmpty()) {
                            out.println("<h2>nao existem comentarios</h2>");
                        } else {
                            //Mostra os comentários existentes
                            for (Comentario c : comentarios) {
                                //Mostra o link para excluir se o usuário for o remetente da mensagem
                                if (c.getRemetente().getId() == u.getId() || c.getDestinatinatario().getId() == u.getId()) {
                                    String excluir = "<a class=\"excluir\" href=\"ServletComentario?idComentario=" + c.getId() + "&local=imagem\">Excluir</a>";
                    %>
                    <li>
                        <%-- Informação do remetente da mensagem --%>
                        <div class="inforemetente">
                            <a href="ServletPerfil?id=<%=c.getRemetente().getId()%>">
                                <img src="<%=c.getRemetente().getImagem()%>" alt="Foto de <%= c.getRemetente().getNome()%>" /><br/>
                                <%=c.getRemetente().getNome()%>
                            </a><br/>
                            <span class="excluir"><%=excluir%></span>
                        </div>
                        <%=c.getComentario()%>
                    </li> 
                    <%}
                                    }
                                }
                            } else {
                                response.sendRedirect("home.jsp");
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
