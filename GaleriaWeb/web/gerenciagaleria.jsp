<%-- 
    Document   : gerenciagaleria
    Created on : 18/11/2011, 10:31:21
    Author     : a968501
--%>

<%@page import="entidades.Galeria"%>
<%@page import="entidades.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <%@include file="head.jsp" %>
        <title>Gerenciar Galerias</title>
    </head>
    <body>
        <%
            Usuario u = (Usuario) (session.getAttribute("usuario"));
            if (u == null) {
                response.sendRedirect("login.jsp");
            } else {
                Galeria g = (Galeria) session.getAttribute("galeria");
                int id = 0;
                String nome = "";
                String descricao = "";
                String aux = "Criar nova galeria";
                if (g != null) {
                    id = g.getId();
                    if (g.getNome() != null) {
                        nome = g.getNome();
                    }
                    if (g.getDescricao() != null) {
                        descricao = g.getDescricao();
                    }
                    aux = "Editar galeria";
                }
        %>
        <%-- HEADER --%>
        <%@include file="header.jsp" %>
        <%-- BODY --%>
        <div class="bgcontainer">
            <div class="container">
                <h2><%=aux%></h2>
                <p class="voltar"><a href="galerias.jsp">Voltar</a></p>
                <form name="formGaleria" action="ServletGaleria" method="post" class="formulario">
                    <p><label for="nome">Nome:</label>
                        <input type="text" name="nome" value="<%=nome%>" id="nome"/>
                    </p>
                    <p><label for="descricao">Descrição:</label>                        
                        <textarea id="descricao" name="descricao"><%=descricao%></textarea>
                    </p>
                    <input type="hidden" name="idGaleria" value="<%=(g != null) ? g.getId() : 0%>" />
                    <p><p><input type="submit" value="" name="btGaleria" /></p>
                </form>
            </div>            
        </div>
        <%
                session.removeAttribute("galeria");
            }
        %>
    </body>
</html>
