<%-- 
    Document   : editarImagem
    Created on : 08/12/2011, 08:10:31
    Author     : João
--%>

<%@page import="entidades.Usuario"%>
<%@page import="entidades.Imagem"%>
<%@page import="dao.DaoImagem"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <%@include file="head.jsp" %>
        <title>Editar Imagem</title>
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
                    String nome = (i.getNome() != null) ? i.getNome() : "";
                    String descricao = (i.getDescricao() != null) ? i.getDescricao() : "";
        %>
        <%-- HEADER --%>
        <%@include file="header.jsp" %>
        <%-- BODY --%>
        <div class="bgcontainer">
            <div class="container">
                <h2>Editar Imagem <%= i.getNome()%></h2>
                <%--Exibir a Imagem--%>
                <form method="POST" action="ServletEditaImagem" name="FormImagem" class="formulario" style="height: 125px; margin-top: 25px;">
                    <p><label for="nome">Nome:</label>
                        <input type="text" name="nome" value="<%=nome%>" id="nome" /></p>
                    <p><label for="descricao">Descricao:</label>
                        <textarea name="descricao" id="descricao"><%=descricao%></textarea></p>
                    <p><input type="hidden" name="idImagem" value="<%=i.getId()%>" />
                        <input type="submit" value="" name="btImagem" style="margin-top: 30px;"/></p>
                </form>
            </div>            
        </div>
        <%                }
            }
        %>
        <%-- FOOTER --%>
        <%@include file="footer.jsp" %>
    </body>
</html>
