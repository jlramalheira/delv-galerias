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
            if (u == null) {
                response.sendRedirect("login.jsp");
            } else {
                DaoImagem daoImagem = new DaoImagem(Imagem.class);
                int id = u.getId();
                if (request.getParameter("idUsuario") != null) {
                    id = Integer.parseInt(request.getParameter("idUsuario"));
                }
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
        
        <%-- Favoritar Imagem--%>
        <% 
            }
        %>
    </body>
</html>
