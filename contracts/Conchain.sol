pragma solidity ^0.4.25;

contract Conchain {
    string[] public projectList;

    struct User {
        string userName;
        uint aadhaarId;
        string[] userProjects;
        uint reputationScore;
    }

    mapping (address => User) public userList;


}