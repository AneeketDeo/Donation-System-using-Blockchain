//SPDX-License-Identifier: UNLICENSED
//one change for new branch
pragma solidity >=0.6.0 < 0.9.0;

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

// -------------------------------Authentication 2------------------------------//
// comapring passwords too!



contract Authentication {
    struct User {
        address uaddress;
        bytes32 email;
        bytes32 passwordHash;
    }

    mapping (address => User) public users;

    function register(address uaddress, bytes32 email, bytes32 password) public {
        bytes32 passwordHash = sha256(abi.encodePacked(password));
        users[msg.sender] = User(uaddress, email, passwordHash);
    }

    function verifyCredentials(address vaddress, bytes32 email, bytes32 password) public view returns (bool) {
        bytes32 hashedPassword = sha256(abi.encodePacked(password));
        return users[msg.sender].uaddress == vaddress && users[msg.sender].email == email && users[msg.sender].passwordHash == hashedPassword;
    }
}

