// SPDX-License-Identifier: BUSL-1.1
pragma solidity 0.8.7;

import "../github/debridge-finance/debridge-contracts-v1/contracts/transfers/DeBridgeGate.sol";

contract permit_code{
    // _addr_bridge 
    // 0x43dE2d77BF8027e25dBD179B491e8d64f38398aA   mainnet
    // 0x68d936cb4723bdd38c488fd50514803f96789d2d   testnet
    DeBridgeGate public _myBridge;
    bytes32 public _permit;

    constructor(address payable addr){ // addr = 0x68d936cb4723bdd38c488fd50514803f96789d2d 
        _myBridge = DeBridgeGate(addr);
    }

    function get_permit() public {

        bytes32 eip712DomainHash = keccak256(
            abi.encode(
                keccak256("EIP712Domain(string name,string version,uint256 chainId,address verifyingContract)"),
                keccak256(bytes("MATIC")), // ERC-20 Name
                keccak256(bytes("1")),    // Version
                42,
                address(this)
            )
        );

        bytes32 hashStruct = keccak256(
            abi.encode(
                keccak256("Permit(address owner,address spender,uint256 value,uint256 nonce,uint256 deadline)"),
                msg.sender,
                0x56636842C1c1E3A2a9AD206762005aFe21988a0B, //reciever
                1,
                _myBridge.nonce(),
                block.timestamp+60000
            )
        ); 

        bytes32 hash = keccak256(
            abi.encodePacked(uint16(0x1901), eip712DomainHash, hashStruct)
        );
        _permit = hash;
    }
}