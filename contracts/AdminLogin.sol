//SPDX-License-Identifier: UNLICENSED
//one change for new branch
pragma solidity >=0.6.0 < 0.9.0;

// ----------------------------------CONTRACT #5-----------------------------//

contract AdminLogin {

    address public admin;

    constructor() {
        admin = msg.sender; // Set the contract deployer as the admin
    }

    modifier onlyAdmin() {
        require(msg.sender == admin, "Only admin can perform this action");
        _;
    }

    function loginAsAdmin() public view returns (bool) {
        return msg.sender == admin;
    }

    function performAdminOnlyAction() public onlyAdmin {
        // Perform action that only admin can do
    }

}


