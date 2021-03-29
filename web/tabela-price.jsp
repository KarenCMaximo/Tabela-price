<%-- 
    Document   : index
    Created on : 28 de mar. de 2021, 22:02:47
    Author     : Usuario
--%>
<%@page import="java.text.NumberFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Tabela-price - JSPF</title>
    </head>
    <body>
        <%@include file="WEB-INF/jspf/cabecalho.jspf" %>
        <%@include file="WEB-INF/jspf/menu.jspf" %>
                       
        <h1 align="center"><u>Tabela-price</u></h1>
        <div id="formulario">
        <form align="center">
            <br>
            <h2 align="center">Preencha os campos abaixo:</h2>
            <br>
               
            Valor Empréstimo <input type="text" name="vlEmprestimo"/>
            <br><br>
            Taxa juros (mensal) <input type="text" name="vlJuros"/>
            <br><br>
            Quantidade (meses) <input type="text" name="qtMeses"/>
            <br><br>
            <br>
            <input type="submit" value="Calcular"/>
            <br><br>
        </form>
            </div>
        
        
        <%
            String vlEmprestimo = request.getParameter("vlEmprestimo");
            String vlJuros = request.getParameter("vlJuros");
            String qtMeses = request.getParameter("qtMeses");
            
            if((vlEmprestimo!="" && vlEmprestimo!=null)||(vlJuros!="" && vlJuros!=null)||(qtMeses!="" && qtMeses!=null)){
                try{
                    double valor = Double.parseDouble(vlEmprestimo);
                    double juros = Double.parseDouble(vlJuros);
                    int meses = Integer.parseInt(qtMeses);
                    juros = juros/100;
                    double pmt=0;
                    double calculo = 0;
                    calculo = 1+juros;
                    double calcjuros=0;
                    double amort = 0;
                    double saldoDevedor = 0;
                    double jurosAtual = 0;                    
                    %>
                    <hr/>
                    <h1 align="center"><u>Resultado da Tabela-price</u></h1>
                    <br>
                    <div align="center">
                    <table id="res" border="1">
                        <tr>
                            <th>Período</th>
                            <th>Prestação</th>
                            <th>Valor Juros</th>
                            <th>Amortização</th>
                            <th>Saldo Devedor</th>
                        </tr>
                        <tr>
                            <th>0</th>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td>
                                <%= NumberFormat.getCurrencyInstance().format(valor) %>
                            </td>
                        </tr>
                        <tr>
                            <% 
                                 pmt = valor * (juros/(1-(1/(Math.pow(calculo, meses)))));
                            
                                for(int i=1; i<=meses; i++) {
                                   
                                    calcjuros = valor * juros;
                                    amort = pmt - calcjuros;
                                    jurosAtual= valor * juros;
                                    saldoDevedor = valor - amort;
                                    
                            %>
                            <th><%= i %></th>
                            <td><%= NumberFormat.getCurrencyInstance().format(pmt) %></td>
                            <td><%= NumberFormat.getCurrencyInstance().format(jurosAtual) %></td>
                            <td><%= NumberFormat.getCurrencyInstance().format(amort) %></td>
                            <td><%= NumberFormat.getCurrencyInstance().format(saldoDevedor) %></td>
                        </tr>
                        <%valor = valor - amort;%>
                            <%}%>
                    </table>
                <%}catch(Exception e){}}%>               
    </div>
        <%@include file="WEB-INF/jspf/footer.jspf" %>
    </body>
</html>
