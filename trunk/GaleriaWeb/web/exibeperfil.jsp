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
        <%@include file="head.jsp" %>
        <title>Perfil</title>
    </head>
    <body>
        <%-- HEADER --%>
        <%@include file="header.jsp" %>
        <%-- BODY --%>
        <div class="bgcontainer">
            <div class="container">
                <p class="voltar"><a href="home.jsp">Voltar</a></p> <br />
                <%
                    Usuario u = (Usuario) session.getAttribute("usuario");
                    if (u == null) {
                        response.sendRedirect("login.jsp");
                    } else {
                        Usuario perfil = (Usuario) session.getAttribute("perfil");
                        if (perfil != null) {
                %>
                <div class="content">
                    <div class="perfil"> <img src="<%=perfil.getImagem()%>" alt="Foto"/>
                        <div class="welcome">
                            <p>Bem vindo ao perfil de,<br />
                                <span class="name"><%=(perfil.getNome())%></span></p>
                            <p class="mensagem"><%= (perfil.getMensagem() != null) ? perfil.getMensagem() : ""%></p>
                            <p><strong>Local:</strong> <%= ((perfil.getCidade() != null) ? perfil.getCidade() : "")
                                    + " - " + ((perfil.getPais() != null) ? perfil.getPais().getNome() : "")%></p>
                            <p><strong>Descrição:</strong> <%= ((perfil.getDescricao() != null) ? perfil.getDescricao() : "")%></p>
                            <p class="opc">
                                <a href="galerias.jsp?idUsuario=<%=perfil.getId()%>">Imagens</a> |
                                <a href="paginaRecados.jsp?idUsuario=<%=perfil.getId()%>">Recados</a> |
                                <a href="exibefavoritos.jsp?idUsuario=<%=perfil.getId()%>">Favoritos</a>
                            </p>                            

                            <%
                                if (session.getAttribute("amigos") != null) {
                                    boolean amigos = (Boolean) session.getAttribute("amigos");
                                    if (!amigos && (u.getId() != perfil.getId())) {
                            %>
                            <form name="formadicionaamigo" action="ServletPerfil" method="POST" style="margin-top: 25px;">
                                <button type="submit" name="btAdd" value="<%=perfil.getId()%>">Adicionar aos amigos</button>
                            </form>
                            <%              }
                                if (amigos) {
                            %>
                            <form name="formRemoveamigo" action="ServletPerfil" method="POST" style="margin-top: 25px;">
                                <button type="submit" name="btRemove" value="<%=perfil.getId()%>">Remover dos Amigos</button>
                            </form>
                            <%
                                    }
                                }%>

                        </div>
                    </div>
                </div>
                <%
                        } else {
                            out.println("<h1>Usuario nao encontrado</h1>");
                        }
                    }
                %>
            </div>            
        </div>
        <%-- FOOTER --%>
        <%@include file="footer.jsp" %>
    </body>
</html>
