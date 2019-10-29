pragma solidity 0.5.12;

contract compraVendaImovel
{
    //dados do Vendedor
        string public nomeVendedor;
        string public rgVendedor;
        string public cpfVendedor;
        address payable carteiraVendedor;
        event pagamentoRealizado (uint valor);

    //dados do cpfComprador
        string public nomeComprador;
        string public rgComprador;
        string public cpfComprador;
        address payable carteiraComprador;
        
    // dados do imovel
        string public enderecoImovel;
        string public nomeProprietarioImovel;
        uint public valorImovel;
        uint public dataVencimento;
        bool pago = false;
       
        constructor(uint _valorImovel, uint _dataDePagamento) public {
            valorImovel = _valorImovel;
            dataVencimento = now+_dataDePagamento;
        }
    
    function  Etapa1_qualificaVendedor(string memory _nomeVendedor, string memory _rgVendedor, string memory _cpfVendedor, address payable _carteiraVendedor) public {
            nomeVendedor = _nomeVendedor;
            rgVendedor = _rgVendedor;
            cpfVendedor = _cpfVendedor;
            carteiraVendedor = _carteiraVendedor;
            nomeProprietarioImovel = _nomeVendedor;
    }
    function Etapa2_qualificaComprador(string memory  _nomeComprador, string memory _rgComprador, string memory _cpfComprador, address payable _carteiraComprador) public {
            nomeComprador = _nomeComprador;
            rgComprador = _rgComprador;
            cpfComprador = _cpfComprador;
            carteiraComprador = _carteiraComprador;
    }
         // informa a data de vencimento 1575057960000
    function Etapa3_dadosImovel (string memory _enderecoImovel, uint _valorImovel, uint _dataVencimento) public {
            enderecoImovel = _enderecoImovel;
            valorImovel = _valorImovel;
            dataVencimento = _dataVencimento;
    }
     
    function pagamentoDataDePagamento () public payable returns (string memory Resultado) {
        require (msg.sender == carteiraComprador, 'Somente comprador pode pagar');
        require (now <= dataVencimento, 'Pagamento após vencimento recusado');
        require (msg.value == valorImovel, "Valor diverso do devido");
        pago = true;
        emit pagamentoRealizado(msg.value);
            carteiraVendedor.transfer(msg.value);
        // Muda o proprietario do imovel para a comprador
            nomeProprietarioImovel = nomeComprador;

	// retorno da mensagem de sucesso
	return "Venda efetivada com sucesso!";
} 

    
} 
