// mailicious


pragma solidity ^0.6.10;

contract Foo  {
    function getBalance() public view returns (uint) {
        return address(this).balance;
    }
}

contract Bar {
    function kill(address payable addr) public payable {
        selfdestruct(addr);        
    }
}

contract EtherGame {
    uint public targetAmount = 7 ether;
    address public winner;
    uint private balance;
    
    
    function deposit() public payable {
        require(msg.value == 1 ether,"you can only send 1 Ether");
        
        uint balance = address(this).balance;
        
        require(balance <= targetAmount, 'Game is over');
        
        if(balance == targetAmount) {
            winner = msg.sender;
        }
    }
    
    function claimReward() public {
        require(msg.sender == winner, 'you are not the winner');
        
        (bool sent, ) = msg.sender.call{ value :  address(this).balance}("");
        require(sent, "Failed to send Ether");
    }
    
    function getBalance() public view returns(uint) {
        return address(this).balance;
    }
}

contract Attack {
    function attack(address payable target) public payable {
        selfdestruct(target);
    }
    
    function getBalance() public view returns(uint) {
        return address(this).balance;
    }
}

====================================================================================================

//solution

pragma solidity ^0.6.10;


contract EtherGame {
    uint public targetAmount = 7 ether;
    address public winner;
    uint public contractBalance;
               
    function deposit() public payable {
        require(msg.value == 1 ether,"you can only send 1 Ether");
        
        contractBalance = contractBalance + msg.value; /* solution */
        
        require(contractBalance <= targetAmount, 'Game is over');
        
        if(contractBalance == targetAmount) {
            winner = msg.sender;
        }
    }
    
    function claimReward() public {
        require(msg.sender == winner, 'you are not the winner');
        
        (bool sent, ) = msg.sender.call{ value :  address(this).balance}("");
        require(sent, "Failed to send Ether");
    }
    
    function getBalance() public view returns(uint) {
        return address(this).balance;
    }
}

contract Attack {
    function attack(address payable target) public payable {
        selfdestruct(target);
    }
      function getBalance() public view returns(uint) {
        return address(this).balance;
    }
}
