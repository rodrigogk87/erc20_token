pragma solidity ^0.8.2;


import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/IERC20.sol";

contract Token{
    
    mapping(address=> uint) public balances;
    mapping(address => mapping (address => uint)) public allowance;
    uint public totalSUpply = 10000000000 * 10 **18;
    string public name = "Xilom";
    string public symbol ="XILO";
    uint public decimals = 18; 
    
    event Transfer(address indexed from, address indexed to, uint value);
    event Approval(address indexed owner, address indexed spender, uint value);
    
    constructor(){
        balances[msg.sender] = totalSUpply;
    }
    
     function getTotalSupply(address addr) public view returns(uint256) {
        return IERC20(addr).totalSupply();
    }
    
    function balanceOf(address owner) public view returns (uint){
        return balances[owner];
    }
    
    function transfer(address to, uint value) public returns (bool){
        require(balanceOf(msg.sender) >= value,'balance too low');
        balances[to]+=value;
        balances[msg.sender]-=value;
        emit Transfer(msg.sender,to,value);

        return true;
    }
    
    function transferFrom(address from, address to, uint value) public returns(bool){
        require(balanceOf(from)>=value,'balance too low');
        require(allowance[from][msg.sender] >= value,'allowance too low');
        
        balances[to]+=value;
        balances[from]-=value;
        
        emit Transfer(from, to, value);
        
        return true;
        
    }
    
    function approve(address spender, uint value) public returns(bool){
        allowance[msg.sender][spender] = value;
        emit Approval(msg.sender,spender,value);

        return true;
    }
    
}