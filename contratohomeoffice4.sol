
pragma solidity 0.5.12;

    contract HomeOffice
{
    string public empregadora;
    address payable carteiraEmpregadora;
    string public empregado;
    address payable carteiraEmpregado;
    event pagamentoRealizado (uint valor);
    uint256 public valorSalario;
    uint public dataPagamentoSalario;
    string public localidade;
    string public dataInicioContrato;
    uint256 public valorSalarioMinimo = 998.00;

    constructor(string memory _nomeEmpregadora, 
                string memory _nomeEmpregado, 
                uint256 _valorSalario, 
                string memory _localidade,
                string memory _dataInicioContrato, uint _dataPagamentoSalario)
                public
    {
        require(_valorSalario >= valorSalarioMinimo, "valor tem que ser maior que salario minimo");
        require(bytes(_nomeEmpregado).length>0, "preencher nome empregado");
        require(bytes(_nomeEmpregadora).length>0, "preencher nome empresa");
        require(bytes(_localidade).length>0, "preencher localidade");
        require(_dataPagamentoSalario > 0 && _dataPagamentoSalario < 11);
        empregadora = _nomeEmpregadora;
        empregado = _nomeEmpregado;
        valorSalario = _valorSalario;
        localidade = _localidade;
        dataInicioContrato = _dataInicioContrato;
        dataPagamentoSalario = _dataPagamentoSalario;
    }

    function rejustaSalarioMinimo(uint256 _valorSalario) public
    {
        require(_valorSalario >= valorSalarioMinimo, "valor tem que ser maior que salario minimo");
        valorSalarioMinimo = _valorSalario;

    }
    function reajustaValorSalario(uint256 _valorSalario) public
    {
        require(_valorSalario >= valorSalario, "valor tem que ser maior que salario atual");
        require(_valorSalario >= valorSalarioMinimo, "valor tem que ser maior que salario minimo");

        valorSalario = _valorSalario;

    }
    function calculaSalario(uint256 _faltas) public  view returns(uint256)
    {
     //se o funcionario faltar mais de um dia tera o DSR descontado
     if(_faltas > 1){
         _faltas++; // adiciona mais uma _faltas
     }
     //uint256 valorDesconto = (valorSalario/30)*_faltas;

       // return valorSalario - valorDesconto; 
       return valorSalario - ((valorSalario/30)*_faltas);
    }
    
        function calculaProventos (uint256 _horasTrabalhadas) public view returns(uint256 valorProvento, uint256 valorDesconto)
        
        {
            //calcula valor hora do empregado
            uint256 valorHora = valorSalario/176;
            uint256 valorProvento;
            uint256 valorDesconto;
            
             if(_horasTrabalhadas==176){
                // trabalhou 176 horas não tem desconto e nem hora extra
                valorProvento = valorSalario;
             }
             else if(_horasTrabalhadas>176){
              // maior que 176 horas pagar extra  
              valorProvento = ((_horasTrabalhadas-176) *valorHora) +valorSalario;
             }
             else{
                //desconta as horas não trabalhadas
                valorProvento =(valorSalario - (176 - _horasTrabalhadas) *valorHora);
                valorDesconto = (176 - _horasTrabalhadas) *valorHora;
            }
            // os calculos foram feitos e colocados nas variaveis abaixo
            
            return (valorProvento, valorDesconto); 
        }      
            
    function PagamentoSalario () public payable returns (string memory) {
        require (msg.sender == carteiraEmpregadora, 'Somente empregadora pode pagar');
        require (now <= dataPagamentoSalario, 'Pagamento após vencimento recusado');
        require (msg.value == valorImovel, "Valor diverso do devido");
        pago = true;
        emit pagamentoRealizado(msg.value);
            carteiraEmpregado.transfer(msg.value);
        
	// retorno da mensagem de sucesso
	return "deposito efetivado com sucesso!";

    }
}

