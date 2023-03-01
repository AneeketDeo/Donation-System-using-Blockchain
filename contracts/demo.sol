// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0 < 0.9.0;
contract demo {
    uint256 myInt;
    uint256 myInt2 = 12;

    function setTheInt(uint256 newValue) public {
        myInt = newValue;
    }

    function getTheInt() public view returns (uint256) {
        return myInt;
    }

    function getTheInt2() public view returns (uint256) {
        return myInt2;
    }

    
}
