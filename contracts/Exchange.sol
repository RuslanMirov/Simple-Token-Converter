pragma solidity ^0.4.24;

import "openzeppelin-solidity/contracts/token/ERC20/ERC20.sol";
import "openzeppelin-solidity/contracts/math/SafeMath.sol";
import "openzeppelin-solidity/contracts/ownership/Ownable.sol";


contract Exchange is Ownable{
using SafeMath for uint256;

ERC20 public tokenA;
ERC20 public tokenB;

uint256 public ratio = 1;

constructor(ERC20 _tokenA, ERC20 _tokenB) public{
  tokenA = ERC20(_tokenA);
  tokenB = ERC20(_tokenB);
}

/*
* @dev owner of contract can change ratio
* param _ratio - new ratio
*
*
* note this function only for test,
* in real app ratio should be calculated from reserve
*/
function setRatio(uint256 _ratio) onlyOwner public {
  require(_ratio > 0);

  ratio = _ratio;
}

/*
* @dev ratio between A and B (by default 1 to 1)
*
* @param _amount - amount of tokens from
*/
function getRatio(uint256 _amount) public view returns(uint256){
  return _amount.div(ratio);
}


/*
* @dev convert Token A to token B
*
* @param _from - Token A address
* @param _to - Token B t_address
* @param _amount - Token A amount
*
* note user need approve From token to contract, before call this function
*/
function convert(ERC20 _from, ERC20 _to, uint256 _amount) public {
  require(_from.balanceOf(msg.sender) > 0);

  require(_from.transferFrom(msg.sender, address(this), _amount));

  uint256 _value = getRatio(_amount);

  require(_to.transfer(msg.sender, _value));
}


/*
* @dev owner can withdraw tokens from contract
*/
function withdraw(ERC20 token, uint256 amount) public onlyOwner{
  require(token.transfer(msg.sender, amount));
}
}
