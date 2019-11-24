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

contract Project {
    address public projectOwner ;
    string public description ;


    /*

    function getProjectBalance() public pure returns(uint256) {
        // return address(dd).balance;
    }

    */

    constructor(string) public payable{
        projectOwner = msg.sender;
        description = string(msg.data);
    }

}