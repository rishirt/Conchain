pragma solidity ^0.4.25;

contract Conchain {
    address public manager;

    struct User {
        address userAddress;
        uint aadhaarId;
        bytes32[] projects;
    }

    struct Project {
        string projectName;
        address projectOwner;
        
    }

    mapping (bytes32 => Project) public projectsList;

    mapping (address => User) public usersList;

    constructor() public {
        manager = msg.sender;
    }
}

