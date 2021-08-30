pragma solidity ^0.8.0;

import '@openzeppelin/contracts/token/ERC20/ERC20.sol';
import '@openzeppelin/contracts/token/ERC20/IERC20.sol';

contract CBT is ERC20 {

    IERC20 public collateral;
    uint256 public price =1;

    constructor(address _colateral) ERC20("Colateral Backed Token","CBT") {
        collateral = IERC20(_colateral);
    }


    function deposite(uint256 _amount) public {
        collateral.transferFrom(msg.sender,address(this),_amount);
        _mint(msg.sender,_amount);
    }


    function withdraw(uint256 tokenAmount) external {
        require(balanceOf(msg.sender)>=tokenAmount,'not enough balance');
        _burn(msg.sender,tokenAmount);
        collateral.transfer(tokenAmount/price);
    }


}