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
        <ul class="menuoff">
            <li><a href="quemSomos.jsp" id="what">O que � Delv?</a></li>
            <li><a href="cadastro.jsp" id="about">Quer participar?</a></li>
        </ul>
    </div>
</div>    
<%    } else {%>
<div class="bgheader">
    <div class="header">
        <h1><img src="images/logo.png" alt="Delv Galerias" width="170" height="80"/></h1>
        <ul class="barme">
            <img src="files/images/<%=a.getId() + "/" + a.getImagem()%>" alt="Avatar"/>
            <p><%=a.getNome()%></p>
            <li><a href="Login" id="what">Sair</a></li>
            <li><a href="editarperfil.jsp" id="about">Editar</a></li>
        </ul>
    </div>
</div>
<%    }%>