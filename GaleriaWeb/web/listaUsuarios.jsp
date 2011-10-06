<%-- 
    Document   : listaUsuarios
    Created on : 23/09/2011, 09:44:30
    Author     : a968501
--%>

<%@page import="entidades.Usuario"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="head.jsp" %>
        <title>Resultados da Pesquisa</title>
    </head>
    <body>
        <%
            if (session.getAttribute("usuario") == null) {
                response.sendRedirect("login.jsp");
            } else {
        %>
        <%-- HEADER --%>
        <%@include file="header.jsp" %>
        <%-- BODY --%>
        <div class="bgcontainer">
            <div class="container">
                <h2>Resultados da Busca</h2>
                <p><a href="home.jsp">Voltar</a></p>
                <div class="resultadosbusca">
                    <ul>
                        <%
                            List<Usuario> usuarios = (List<Usuario>) session.getAttribute("usuarios");
                            if (usuarios != null) {
                                for (Usuario u : usuarios) {%>
                                <li>
                                    <a href="ServletPerfil?id=<%= u.getId()%>"><img src="files/images/<%= u.getId()%>/<%= u.getImagem()%>" alt="Foto de <%= u.getNome()%>"/></a>
                                    <div class="info">
                                        <p class="nome"><a href="ServletPerfil?id=<%= u.getId()%>"><%= u.getNome()%></a></p>
                                        <p class="msg"><%= (u.getMensagem() != null) ? u.getMensagem() : ""%></p>
                                        <p><br/>
                                            <strong>Local:</strong> <%= u.getCidade()%> - <%= u.getPais().getNome() %></p>
                                    </div>
                                </li>                                
                        <% }
                            }
                        %>
                    </ul>
                </div>
            </div>           
        </div>
        <%-- FOOTER --%>
        <%@include file="footer.jsp" %>
        <%
            }
        %>

    </body>
</html>
