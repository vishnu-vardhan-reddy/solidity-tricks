// never store sensitive info in blockchain

// 1 slot = 2 ** 256

// bytes32  -- 1 slot in ethereum virtual machine

// uint - 1 slot storage

// address - 20 bytes  bool = 1 byte  - 1 slot storage




// using web3 js

// web3.eth.getStorageAt('deployed contract address', slot, console.log)


// parseInt("0x7b" , 16) used to convert data into hexadecimal  

//  bytes32 to alphabets  web3.utils.toAscii("bytes32")


// web3.utils.soliditySha3(type: 'uint',value: 6) value means slot

contract Vault {
    
    uint public count = 123; // slot 0 : 32 bytes == 1 slot
    
    // slot 1
    address public owner = msg.sender // 20 bytes
    bool public isTrue; // 1 bytes
    uint 16 uint counter = 31;
    
    //slot 2
    bytes 32 private password;
    
    uint public constant someConst = 123;
    
    // slot 3,4 5
    bytes32[3] public data
    
    struct User {
        uint id;
        bytes32 password;
    }
    
    // slot 6 - length of array
    //starting from slot keccak256(6) - array elements are stored from slot 7
    // slot where array elemnt is stored = keccak256(slot + (index * elementSize)
    // where slot = 6 and elemntsSize = 2 (1 (uint) + 1 (bytes32))
    
    User[] private users;
    
    // slot 7 empty
    //entries are stored at keccak256(key, slot)
    // where slot = 7 , key = map key
    
    mapping(uint => User) private idToUser;
    
    constructor(bytes32  _password) public {
        password = _password;
    }
    
    function addUser(bytes32 _password) public {
        User memory user = User({
            id: users.length,
            password: _password
        });
        
        users.push(user);
        idTouser[user.id] = user;
    }
    
    function getArrayLocation(uint slot, uint index, uint elementSize) public pure returns (uint) {
        return uint(keccak256(abi.encodePacked(slot))) + (index * elementSize);
    }
    
    function getMapLocation(uint slot, uint index, uint key) public pure returns (uint) {
        return uint(keccak256(abi.encodePacked(key,slot)));
    }
    
}
