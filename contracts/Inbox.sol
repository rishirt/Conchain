pragma solidity ^0.4.25;

contract Lottery {
    address public manager;
    address[] public players;

    function enter() public payable {
        players.push(msg.sender);
    }

    constructor() public {
        manager = msg.sender;
    }
}

contract Conchain {
    address public manager;

    struct User {
        address userAddress;
        string aadhaarId;
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

