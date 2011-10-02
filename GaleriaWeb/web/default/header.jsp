<%-- 
    Document   : header
    Created on : 11/09/2011, 23:08:46
    Author     : Max
--%>
<%@page import="entidades.Usuario"%>
<% Usuario a = (Usuario) (session.getAttribute("usuario"));
    if (a == null) {%>
<div class="bgheader">
    <div class="header">
        <h1><img src="images/logo.png" alt="Delv Galerias" width="170" height="80"/></h1>
        <ul>
            <li><a href="quemSomos.jsp" id="what">O que é Delv?</a></li>
            <li><a href="cadastro.jsp" id="about">Quer participar?</a></li>
        </ul>
    </div>
</div>    
<%    } else {%>
<div class="bgheader">
    <div class="header">
        <h1><img src="images/logo.png" alt="Delv Galerias" width="170" height="80"/></h1>
        <ul>
            <li><a href="editarperfil.jsp" id="what">Editar</a></li>
            <li><a href="Login" id="about">Sair</a></li>
        </ul>
    </div>
</div>
<%    }%>
