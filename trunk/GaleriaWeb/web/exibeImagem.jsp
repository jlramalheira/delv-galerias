<%-- 
    Document   : exibeImagem
    Created on : 07/12/2011, 14:56:18
    Author     : João
--%>

<%@page import="dao.Dao"%>
<%@page import="entidades.Imagem"%>
<%@page import="entidades.Usuario"%>
<%@page import="dao.DaoImagem"%>
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
        %>
        <p>
            <%
                if (id == u.getId()) { //vai pra home
%>
            <a href="home.jsp"><%=u.getNome()%></a>
            <%
            } else { //vai pro perfil do dono das galerias
%> 
            <a href="ServletPerfil?id=<%=id%>"><%=new Dao<Usuario>(Usuario.class).get(id).getNome()%></a>
            <%
                }
            %>
            - 
            <a href="galerias.jsp?idUsuario=<%=id%>">Voltar as galerias</a>
        </p>
        <%-- Mostrar Imagem--%>
        <p>
            <img src="<%=i.getImagem()%>" alt="<%=i.getNome()%>" />
        </p>
        <%-- Favoritar Imagem--%>
        <p>
            <%
                if (id != u.getId()) {
                    if (u.getFavoritos().contains(i)) {
                        //ja eh favorito%>
        <form name="formFavorita" action="ServletFavorito" method="POST">
            <input type="hidden" name="idUsuario" value="<%=id%>" />
            <button type="submit" name="btRemove" value="<%=i.getId()%>">Remover Favorito</button>
        </form>
        <%

        } else {
            //nao 'e favorita
%>
        <form name="formFavorita" action="ServletFavorito" method="POST">
            <input type="hidden" name="idUsuario" value="<%=id%>" />
            <button type="submit" name="btAdd" value="<%=i.getId()%>">Adicionar Favorito</button>
        </form>
        <%
                }
            }
        %>
    </p>
    <%
            } else {
                response.sendRedirect("home.jsp");
            }
        }
    %>
</body>
</html>
