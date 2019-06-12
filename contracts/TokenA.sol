pragma solidity ^0.4.24;

import "openzeppelin-solidity/contracts/token/ERC20/DetailedERC20.sol";
import "openzeppelin-solidity/contracts/token/ERC20/StandardToken.sol";


contract TokenA is StandardToken, DetailedERC20 {

    constructor(string _name, string _symbol, uint8 _decimals, uint256 _totalSupply)
        DetailedERC20(_name, _symbol, _decimals)
        public
    {
        // Initialize totalSupply
        totalSupply_ = _totalSupply;
        // Initialize Holder
        balances[msg.sender] = _totalSupply;
    }
}
