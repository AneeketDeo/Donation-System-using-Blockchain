//SPDX-License-Identifier: UNLICENSED
//one change for new branch
pragma solidity >=0.6.0 < 0.9.0;

// --------------------------------CONTRACT #1 (SUCCESSFUL)--------------------------------//
// contract Authentication {
//     mapping(address => bool) public authorized;

//     function authorize(address _address) public {
//         authorized[_address] = true;
//     }

//     function revoke(address _address) public {
//         authorized[_address] = false;
//     }

//     function isAuthorized(address _address) public view returns (bool) {
//         return authorized[_address];
//     }
// }


// -------------------------------CONTRACT #2(UNSUCCESSFUL)------------------------------//
// comparing passwords too!

// contract Authentication {
//     struct User {
//         address uaddress;
//         bytes32 email;
//         bytes32 passwordHash;
//     }

//     mapping (address => User) public users;

//     function register(address uaddress, bytes32 email, bytes32 password) public {
//         // bytes32 passwordHash = sha256(abi.encodePacked(password));
//         users[msg.sender] = User(uaddress, email, password);
//     }

//     function verifyCredentials(address vaddress, bytes32 email, bytes32 password) public view returns (bool) {
//         // bytes32 hashedPassword = sha256(abi.encodePacked(password));
//         return users[msg.sender].uaddress == vaddress && users[msg.sender].email == email && users[msg.sender].passwordHash == password;
//     }
// }


// ----------------------------------CONTRACT #3-----------------------------//
// contract Authentication {
    
//     struct User {
//         address userAddress;
//         string email;
//         string password;
//         bool verified;
//     }

//     // count
//     uint public usersCount;
//     address[] public users_c;

    
//     mapping(address => User) public users;
//     mapping(string => bool) public usedEmails;
    
//     event UserRegistered(address indexed userAddress, string email);
//     event UserVerified(address indexed userAddress);
    
//     function registerUser(string memory _email, string memory _password) public {
//         require(!usedEmails[_email], "Email already registered");
        
//         address userAddress = msg.sender;
//         users[userAddress] = User(userAddress, _email, _password, false);
//         usedEmails[_email] = true;

//         // count
//         users_c.push(userAddress);
//         usersCount = users_c.length;

//         emit UserRegistered(userAddress, _email);
//     }
    
//     function verifyUser() public {
//         require(users[msg.sender].userAddress == msg.sender, "User not registered");
//         require(!users[msg.sender].verified, "User already verified");
        
//         users[msg.sender].verified = true;
        
//         emit UserVerified(msg.sender);
//     }
    
//     function login(string memory _email, string memory _password) public view returns (bool) {
//         address userAddress = getUserAddress(_email);
        
//         if (userAddress == address(0)) {
//             return false;
//         }
        
//         return keccak256(bytes(users[userAddress].password)) == keccak256(bytes(_password));
//     }
    
//     function getUserAddress(string memory _email) public view returns (address) {
//         for (uint i = 0; i < usersCount; i++) {
//             if (keccak256(bytes(users[i].email)) == keccak256(bytes(_email))) {
//                 return users[i].userAddress;
//             }
//         }
        
//         return address(0);
//     }
// }


// ----------------------------------CONTRACT #4-----------------------------//
// contract Authentication {
//     struct User {
//         string email;
//         string password;
//         address userAddress;
//         bool verified;
//     }
    
//     mapping (address => User) public users;
    
//     function registerUser(string memory _email, string memory _password) public {
//         require(bytes(_email).length > 0, "Email address cannot be empty.");
//         require(bytes(_password).length > 0, "Password cannot be empty.");
//         require(users[msg.sender].userAddress == address(0), "User already registered.");
//         users[msg.sender] = User(_email, _password, msg.sender, false);
//     }
    
//     function verifyUser() public {
//         require(users[msg.sender].userAddress != address(0), "User not registered.");
//         require(!users[msg.sender].verified, "User already verified.");
//         users[msg.sender].verified = true;
//     }
    
//     function getUserEmail() public view returns (string memory) {
//         require(users[msg.sender].verified, "User not verified.");
//         return users[msg.sender].email;
//     }
    
//     function getUserAddress() public view returns (address) {
//         require(users[msg.sender].verified, "User not verified.");
//         return users[msg.sender].userAddress;
//     }
// }



// ----------------------------------CONTRACT #5-----------------------------//

contract Authentication {

    struct User {
        address uaddress;
        string email;
        string passwordHash;
    }

    mapping (address => bytes32) public users;


    function register(string memory _email, string memory _password) public {

        address user = msg.sender;
        bytes32 hash = keccak256(abi.encodePacked(_email, _password));
        users[user] = hash;

    }

    function login(string memory _email, string memory _password) public view returns (bool) {

        address user = msg.sender;
        bytes32 storedHash = users[user];
        bytes32 hash = keccak256(abi.encodePacked(_email, _password));
        return (storedHash == hash);

    }

}


