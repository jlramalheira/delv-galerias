<%-- 
    Document   : cadastro
    Created on : 26/08/2011, 09:41:21
    Author     : aluno
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="head.jsp" %>
        <title>Novo Cadastro</title>
        <script>
            function validarcampos(){
                login = document.FormCadastro.usuario.value
                senha = document.FormCadastro.password.value
                email = document.FormCadastro.email.value
                mensagem = "";
                if (login == ""){
                    mensagem = "login invalido\n"
                }
                if (senha == ""){
                    mensagem += "senha invalida\n"
                }
                if (email == ""){
                    mensagem += "email invalido"
                }
                if (mensagem != ""){
                    alert(mensagem);
                    return false;
                } else {
                    return true;
                }
            }
        </script>
    </head>    
    <body>
        <%@include file="header.jsp" %>
        <div class="bgcontainer">
            <div class="container">
                <h2>Crie uma nova conta</h2>
                <%
                    String login = "";
                    String email = "";
                    if ((session.getAttribute("login") != null)) {
                        login = session.getAttribute("login") + "";
                    }
                    if ((session.getAttribute("email") != null)) {
                        email = session.getAttribute("email") + "";
                    }
                    if ((session.getAttribute("mensagem") != null)) {
                        out.println("<p class=\"erro\">" + session.getAttribute("mensagem") + "</p>");
                    }
                %>
                <form method="POST" action="NovoUsuario" name="FormCadastro" class="formulario">
                    <p><small>Os Campos com * são de preenchimento obrigatório</small></p>
                    <p><label for="usuario">Usuario*:</label>
                        <input type="text" name="usuario" value="<%=login%>" id="usuario" /></p>
                    <p><label for="password">Senha*:</label>
                        <input type="password" name="password" value="" id="password"/></p>
                    <p><label for="email">E-mail*:</label>
                        <input type="text" name="email" value="<%=email%>" id="email"/></p>
                    <p><input type="submit" value="" name="btConfirmar" onclick="return validarcampos()"/></p>
                </form>
            </div>
        </div>
        <%@include file="footer.jsp" %>
        <%session.removeAttribute("mensagem"); %>
    </body>
</html>
