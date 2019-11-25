pragma solidity ^0.4.25;

contract ConchainMaster {
    address[] public deployedProjects;

    function createProject(string title) public returns(address deployedProject){
        address newProject = new ConchainProject(title, msg.sender);
        deployedProjects.push(newProject);
        return newProject;
    }
}

contract ConchainProject {
    address public projectOwner;
    string public projectTitle;

    constructor(string title, address owner) public {
        projectTitle = title;
        projectOwner = owner;
    }

}