//SPDX-License-Identifier: UNLICENSED
//one change for new branch
pragma solidity >=0.6.0 < 0.9.0;

// ----------------------------------CONTRACT #5-----------------------------//

contract ProjectOwnerLogin {

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


