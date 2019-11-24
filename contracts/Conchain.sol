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
    address[] public participants;
    mapping (address => bool) allowedParticipants;
    /*

    function getProjectBalance() public pure returns(uint256) {
        // return address(dd).balance;
    }

    */

    modifier onlyOwner {
        require(
            allowedParticipants[msg.sender],
            "Only participants of a project can add new participants"
        );
        _;
    }

    constructor(string) public payable{
        projectOwner = msg.sender;
        description = string(msg.data);
    }

    function addParticipant(address) public onlyOwner {

    }

}