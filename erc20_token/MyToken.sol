pragma solidity ^0.5.7;

import "./ERC20Standard.sol";

contract NewToken is ERC20Standard {
	constructor() public {
		totalSupply = 123;
		name = "Bread coin";
		decimals = 4;
		symbol = "BRC";
		version = "1.0";
		balances[msg.sender] = totalSupply;
	}
}
