pragma solidity 0.5.12;

contract teste
{
    string public nomeCorp = "raisen";
    
    function  qualnomeCorp() public view returns (string memory) {
        return nomeCorp;
    }
}
