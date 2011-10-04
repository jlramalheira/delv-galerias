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
        <%@include file="default/favicon.jsp" %>
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
        <h1>Crie uma nova conta</h1>
        <%
        String login = "";
        String email = "";
        if ((session.getAttribute("login") != null)){
            login = session.getAttribute("login")+"";
        }
        if ((session.getAttribute("email") != null)){
            email = session.getAttribute("email")+"";
        }
        if ((session.getAttribute("mensagem") != null)){
            out.println("<h2>"+session.getAttribute("mensagem")+"</h2>");
        }
        %>
        <form method="POST" action="NovoUsuario" name="FormCadastro">
            <p>Usuario*: <br/>
            <input type="text" name="usuario" value="<%=login%>" /></p>
            <p>Senha*:<br/>
            <input type="password" name="password" value="" /></p>
            <p>E-mail*:<br/>
            <input type="text" name="email" value="<%=email%>" /></p>
            <p><input type="submit" value="Confirmar" name="btConfirmar" onclick="return validarcampos()"/></p>
        </form>
    </body>
</html>
