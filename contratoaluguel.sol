pragma solidity 0.5.12;
//usando  estas duas barras podemos fazer comentários que utilizem apenas uma linha, fazer uma explicação
// sempre colocar TAB para dar os comandos
    contract Aluguel
    {
 /* quando usa barra asterisco serve abrir e fazer comentários maiores com mais linhas e tem que terminar e termina o comentário com asterisco barra 
 */
 //string = é igual a texto, uma variável, pode colocar o que quiser, mas temque colocar entre aspas
 // uint256 = e igual a número inteiro de 0 até 256 caracteres quase infinito, pode usar só o termo UINT, ou uint8 cabe até 8 caracteres, não tem numeros negativos
 // address = e igual a endereço ethereum
 // bool = e igual a verdadeiro ou falso
 // uint256 constant = e uma variavel constante e tem que definir valores
 // quando coloca ponto e virgula é para terminar o comando
 
     string public locatario;
 
     string public locador;
 
     uint256 private valor;
 
     uint256 constant numeroMaximoLegalDeAlugieisParaMulta = 3;
     
     constructor(string memory nomeLocador, string memory nomeLocatario, uint256 valorDoAluguel) public
     {
         
         locador = nomeLocador;
         locatario = nomeLocatario;
         valor = valorDoAluguel;
     }
     // para realizar a função de parametros usa o termo constructor( sempre as variaveis ficam entre parenteses) e os parametros são seprados por virgulas, o constructor SEMPRE É PUBLICO
     // podemos colocar blocos dentro de blocos {}
     
    function valorAtualDoAluguel() public view returns (uint256) 
    {
        return valor;
    }
        
        // a função function tem que colcoar parenteses, mesmo que fique vazio, ou seja, pode ser preenchido ou não, esta função pode ser executada a qualquer momento
        
    function simulaMulta(uint256 mesesRestantes, uint256 totalMesesContrato)
        public
        view
        returns(uint256 valorMulta) 
    {
            
        valorMulta = valor*numeroMaximoLegalDeAlugieisParaMulta;
        valorMulta = valorMulta/totalMesesContrato;
        valorMulta = valorMulta*mesesRestantes;
            
        return valorMulta;
    }
        
    function reajusteAluguel (uint256 percentualReajuste) public 
    {
        if (percentualReajuste > 20)
        {
            percentualReajuste = 20;
            //o if e uma condição, ex se o reajuste for maior que 20% aplica-se o teto de 20%
        }
        uint256 valorDoAcrescimo = 0;
        valorDoAcrescimo = ((valor*percentualReajuste)/100);
        valor = valor + valorDoAcrescimo;
    }
            
    function aditamentoValorAluguel(uint256 valorcerto) public
    {
        valor = valorcerto;
    }       
    
    function aplicaMulta (uint256 mesesRestantes, uint256 percentual) public
    {
        require(mesesRestantes<30, "Periodo de contrato invalido");
        for (uint i=1; i<mesesRestantes; i++) 
        {
            valor = valor+((valor*percentual)/100);
        }
    }  
 //tudo que pertence ao contrato tem que ficar entre as chaves {} se abrir um bloco com chaves, nunca esqueça que a chave que abre tem que ter uma chave que fecha PRESTAR ATENÇAO
}
