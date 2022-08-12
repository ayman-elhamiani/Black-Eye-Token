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
    mapping(address => mapping(address => uint256) ) allowed;

    event Transfer(
        address indexed _from,
        address indexed _to,
        uint256 _value
    );
    event Approval(
        address indexed _owner,
        address indexed _spender,
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
        "\nTransferring from %s to %s %s tokens",
        msg.sender,
        _to,
        _amount
       );

        balances[msg.sender] -= _amount;
        balances[_to] += _amount;
        emit Transfer(msg.sender, _to, _amount);
    }


    function approve(address _delegate, uint256 _numTokens) public returns (bool) {
        allowed[msg.sender][_delegate] = _numTokens;
        console.log(
        "\n%s allowed %s to sell his %s tokens",
        msg.sender,
        _delegate,
        _numTokens
       );
        emit Approval(msg.sender, _delegate, _numTokens);
        return true;
    }

    function transferFrom(address _owner, address _buyer, uint256 _numTokens) public returns (bool) {
        require(_numTokens <= balances[_owner]);
        require(_numTokens <= allowed[_owner][msg.sender]);

        balances[_owner] = balances[_owner]-_numTokens;
        allowed[_owner][msg.sender] = allowed[_owner][msg.sender]-_numTokens;
        balances[_buyer] = balances[_buyer]+_numTokens;

  console.log(
        "\n user1 have %s tokens \n user2 have %s tokens \n user3 have %s tokens",
             balances[_owner],balances[_buyer],balances[msg.sender]);

        emit Transfer(_owner, _buyer, _numTokens);
        return true;
    }
}