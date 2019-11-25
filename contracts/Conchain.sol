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
    mapping (address => uint) public addressResolver ;

    
    function createProject(string title, address contractAddress) public returns(address deployedProject){
        address newProject = new ConchainProject(title, msg.sender, contractAddress);
        deployedProjects.push(newProject);
        return newProject;
    }
    

    function registerUser(string name, string role, string emailId) public {
        User memory newUser = User ({
            userName : name,
            role : role,
            emailId : emailId,
            userAddress : msg.sender,
            reputationScore : 0
        });
        users.push(newUser);
        uint length = users.length;
        nameResolver[name] = msg.sender;
        emailResolver[emailId] = msg.sender;
        addressResolver[msg.sender] = length-1;
    }


    function updateReputation(address userAddress, bool direction) public {
        if ( direction = true ) {
            users[addressResolver[userAddress]].reputationScore++;
        }
        else {
            users[addressResolver[userAddress]].reputationScore--;
        }
    }
}



contract ConchainProject {
    ConchainMaster masterContract;

    address public projectOwner;
    string public projectTitle;

    mapping(address => bool) projectParticipant;
    mapping(string => uint) channelResolver;

    struct Request {
        string description;
        address recipient;
        uint value;
        bool status;
        uint approvalCount;
        mapping(address => bool) approvals;
    }

    struct Channel {
        string title;
        address[] approvers;
        Request[] channelRequests;
        mapping(address => bool) approverCheck;
    }

    Channel[] public channels;
    Request[] public requests;

    modifier onlyMembers {
        require(projectParticipant[msg.sender] == true,
        'only members method');
        _;
    }

    modifier onlyOwner {
        require(msg.sender == projectOwner,
        "only owner method");
        _;
    }

    function createChannel(address[] approvers, string title) public onlyOwner {
        Channel memory newChannel = Channel({
            title: title,
            approvers: approvers
        });
        channels.push(newChannel);
        uint length = channels.length;
        channelResolver[title] = length-1;
        for (uint i=0; i<channels[length-1].approvers.length; i++){
            channels[length-1].approverCheck[i] == true;
        }
    }

    function createRequest(string description, uint value, address recipient, string channel) public onlyMembers {
        Request memory newRequest = Request({
           description: description,
           value: value,
           recipient: recipient,
           status: false,
           approvalCount: 0
        });
        uint index = channelResolver[channel];
        channels[index].channelRequests.push(newRequest);
        requests.push(newRequest);
    }

    function approveRequest(string title) {
        uint index = channelResolver[title];
        require(
            channels[index].approverCheck[msg.sender] == true,
            "approver only method"
        );
        

    }




    function createRequest(string description, address recipient, uint value, ) public {

    }

    constructor(string title, address owner, address masterAddress) public {
        projectTitle = title;
        projectOwner = owner;
        masterContract = ConchainMaster(masterAddress);
    }


    function createChannel(string title) onlyOwner public {

    }
}

