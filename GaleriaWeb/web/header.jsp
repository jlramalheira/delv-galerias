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
        <h1><a href="login.jsp"><img src="images/logo.png" alt="Delv Galerias" width="170" height="80"/></a></h1>
        <ul class="menuoff">
            <li><a href="quemSomos.jsp" id="what">O que � Delv?</a></li>
            <li><a href="cadastro.jsp" id="about">Quer participar?</a></li>
        </ul>
    </div>
</div>    
<%    } else {%>
<script type="text/javascript">          
    $(document).ready(function(){
        $('#search').val('Pesquisar').toggleVal();
    });       
</script>
<div class="bgheader">
    <div class="header">
        <h1><a href="login.jsp"><img src="images/logo.png" alt="Delv Galerias" width="170" height="80"/></a></h1>
                <%-- BARRA PESSOAL --%>
        <div class="barmecontainer">
            <div class="barme">
                <p><img src="<%=(a.getImagem() != null) ? a.getImagem() : "images/pic.png"%>" alt="Avatar"/>
                    <%= (a.getNome() != null) ? a.getNome() : "N�o definido" %>
                </p>
                <ul>               
                    <li><a href="Login" id="what">Sair</a></li>
                    <li><a href="editarperfil.jsp" id="about">Editar</a></li>
                </ul>
            </div>
        </div>
        <%-- PESQUISAR --%>
        <form name="formBuscaUsuario" action="ServletBuscaUsuario" method="post" >
            <img src="images/bkg/search.png" alt="Search icon" />
            <input type="text" name="nomeUsuario" value="" id="search"/>      
        </form>
    </div>
</div>
<%    }%>
