<%-- 
    Document   : whiteboard
    Created on : 25/10/2012, 13:19:58
    Author     : Max Naegeler Roecker
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <link rel="stylesheet" type="text/css" href="css/global.css"/>
        <link href='http://fonts.googleapis.com/css?family=Open+Sans' rel='stylesheet' type='text/css'>
        <title>Whiteboard</title>
    </head>
    <body>        
        <div class="container">
            <%-- Cabeçalho --%>
            <header>
                <div class="logo">LOGO</div>
                <h1>Hospital Universitário Regional de Maringá</h1>         
            </header>
            <%-- Principal --%>
            <div class="main whiteboard">
                <table border="1">
                    <thead>
                        <tr>
                            <th>Leito</th>
                            <th>Enfermeiro</th>
                            <th>Responsável</th>
                            <th>Clínica</th>
                            <th>Prontuário</th>
                            <th>Nome</th>
                            <th>Entrada</th>
                            <th>Tempo</th>
                            <th>TOT</th>
                            <th>CVC</th>
                            <th>Pendências</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td class="leito" >8-A</td>
                            <td class="enfermeiro" >MMarques</td>
                            <td class="responsavel" >RCampos</td>
                            <td class="clinica" ><div class="medica"></div></td>
                            <td class="prontuario" >0718</td>
                            <td class="nome" >C.M.S.</td>
                            <td class="entrada" >17/10/2012 13:23</td>
                            <td class="tempo" >7:23</td>
                            <td class="tot">17/10/2012 16:00</td>
                            <td class="cvc">17/10/2012 16:30</td>
                            <td class="pendencias"></td>
                        </tr>
                        <tr>
                            <td class="leito" >8-A</td>
                            <td class="enfermeiro" >MMarques</td>
                            <td class="responsavel" >RCampos</td>
                            <td class="clinica" ><div class="cirurgica"></div></td>
                            <td class="prontuario" >0718</td>
                            <td class="nome" >C.M.S.</td>
                            <td class="entrada" >17/10/2012 13:23</td>
                            <td class="tempo" >7:23</td>
                            <td class="tot">17/10/2012 16:00</td>
                            <td class="cvc">17/10/2012 16:30</td>
                            <td class="pendencias"></td>
                        </tr>
                        <tr>
                            <td class="leito" >8-A</td>
                            <td class="enfermeiro" >MMarques</td>
                            <td class="responsavel" >RCampos</td>
                            <td class="clinica" ><div class="pediatrica"></div></td>
                            <td class="prontuario" >0718</td>
                            <td class="nome" >C.M.S.</td>
                            <td class="entrada" >17/10/2012 13:23</td>
                            <td class="tempo" >7:23</td>
                            <td class="tot">17/10/2012 16:00</td>
                            <td class="cvc">17/10/2012 16:30</td>
                            <td class="pendencias"></td>
                        </tr>
                        <tr>
                            <td class="leito" >8-A</td>
                            <td class="enfermeiro" >MMarques</td>
                            <td class="responsavel" >RCampos</td>
                            <td class="clinica" ><div class="ortopedica"></div></td>
                            <td class="prontuario" >0718</td>
                            <td class="nome" >C.M.S.</td>
                            <td class="entrada" >17/10/2012 13:23</td>
                            <td class="tempo" >7:23</td>
                            <td class="tot">17/10/2012 16:00</td>
                            <td class="cvc">17/10/2012 16:30</td>
                            <td class="pendencias"></td>
                        </tr>
                        <tr>
                            <td class="leito" >8-A</td>
                            <td class="enfermeiro" >MMarques</td>
                            <td class="responsavel" >RCampos</td>
                            <td class="clinica" ><div class="bucomaxilo"></div></td>
                            <td class="prontuario" >0718</td>
                            <td class="nome" >C.M.S.</td>
                            <td class="entrada" >17/10/2012 13:23</td>
                            <td class="tempo" >7:23</td>
                            <td class="tot">17/10/2012 16:00</td>
                            <td class="cvc">17/10/2012 16:30</td>
                            <td class="pendencias"></td>
                        </tr>
                        <tr>
                            <td class="leito" >8-A</td>
                            <td class="enfermeiro" >MMarques</td>
                            <td class="responsavel" >RCampos</td>
                            <td class="clinica" ><div class="gineobstreta"></div></td>
                            <td class="prontuario" >0718</td>
                            <td class="nome" >C.M.S.</td>
                            <td class="entrada" >17/10/2012 13:23</td>
                            <td class="tempo" >7:23</td>
                            <td class="tot">17/10/2012 16:00</td>
                            <td class="cvc">17/10/2012 16:30</td>
                            <td class="pendencias"></td>
                        
                        </tr>
                        <tr>
                            <td class="leito" >8-A</td>
                            <td class="enfermeiro" >MMarques</td>
                            <td class="responsavel" >RCampos</td>
                            <td class="clinica" ><div class="adolescentes"></div></td>
                            <td class="prontuario" >0718</td>
                            <td class="nome" >C.M.S.</td>
                            <td class="entrada" >17/10/2012 13:23</td>
                            <td class="tempo" >7:23</td>
                            <td class="tot">17/10/2012 16:00</td>
                            <td class="cvc">17/10/2012 16:30</td>
                            <td class="pendencias"></td>
                        </tr>
                        
                        
                                               
                    </tbody>
                    <tfoot>
                        
                    </tfoot>
                </table>
                

            </div>
            <%-- Base --%>
            <footer>

            </footer>
        </div>
    </body>
</html>
