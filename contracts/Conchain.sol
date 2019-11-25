pragma solidity ^0.4.25;

contract ConchainMaster {
    address[] public deployedProjects;

    struct User {
        string userName ;
        string role ;
        string emailId ;
        address userAddress ;
        uint reputationScore ;
    }

    User[] public users;

    mapping (string => address) nameResolver ;
    mapping (string => address) emailResolver ;
    mapping (address => User[]) addressResolver ;

    function createProject(string title) public returns(address deployedProject){
        address newProject = new ConchainProject(title, msg.sender);
        deployedProjects.push(newProject);
        return newProject;
    }

    function registerUser(string name, string role, string emailId) public returns(bool status) {
        User memory newUser = User ({
            userName : name,
            role : role,
            emailId : emailId,
            userAddress : msg.sender
        });
        users.push(newUser);
        nameResolver[name] = msg.sender;
        emailResolver[emailId] = msg.sender;
        addressResolver[msg.sender] = newUser;
    }

    function updateReputation(address userAddress, bool direction) public {
        if ( direction = true ) {
            addressResolver[userAddress].reputationScore++;
        }
        else {
            addressResolver[userAddress].reputationScore--;
        }
    }
}



/*
contract ConchainProject {
    address public projectOwner;
    string public projectTitle;

    constructor(string title, address owner) public {
        projectTitle = title;
        projectOwner = owner;
    }

}
*/
