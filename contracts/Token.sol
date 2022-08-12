//SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.9;

import "hardhat/console.sol";


contract Token {

    string public name = "Black Eye Token";
    string public symbol = "BET";

    uint256 public totalSupply = 1000000;
    address public owner;

    // Here we store each account's balance.
    mapping(address => uint256) balances;

    event Transfer(
        address indexed _from,
        address indexed _to,
        uint256 _value
    );


   
    constructor() {
        balances[msg.sender] = totalSupply;
        owner = msg.sender;
    }

    function balanceOf(address account) external view returns (uint256) {
        return balances[account];
    }

    function transfer(address _to, uint256 _amount) external {
 
        require(balances[msg.sender] >= _amount, "Not enough tokens");
        console.log(
        "Transferring from %s to %s %s tokens",
        msg.sender,
        _to,
        _amount
       );

        balances[msg.sender] -= _amount;
        balances[_to] += _amount;
        emit Transfer(msg.sender, _to, _amount);
    }



}