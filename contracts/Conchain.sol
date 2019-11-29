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

    constructor(string title, address owner, address masterAddress) public {
        projectTitle = title;
        projectOwner = owner;
        masterContract = ConchainMaster(masterAddress);
    }

    address public projectOwner;
    string public projectTitle;

    mapping(address => bool) projectParticipant;
    mapping(string => uint) channelResolver;
    mapping(string => uint)requestResolver;
    mapping(string => uint)channelToRequestResolver;

    struct Channel {
        string title;
        address[] approvers;
        uint minApproverCount;
        mapping(address => bool) approverCheck;
    }

    struct Request {
        string description;
        address recipient;
        uint value;
        bool status;
        uint approvalCount;
        string channel;
        mapping(address => bool) approvals;
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

    function createChannel(address[] approvers, string title, uint minApproverCount) public onlyOwner {
        Channel memory newChannel = Channel({
            title: title,
            approvers: approvers,
            minApproverCount: minApproverCount,
        });
        channels.push(newChannel);
        uint length = channels.length;
        channelResolver[title] = length-1;
        for (uint i = 0; i<channels[length-1].approvers.length; i++){
            address temp = approvers[i];
            channels[length-1].approverCheck[temp] == true;
        }
    }

    function createRequest(string description, string channelTitle, uint value, address recipient, string channel) public onlyMembers {
        Request memory newRequest = Request({
           description: description,
           value: value,
           recipient: recipient,
           status: false,
           approvalCount: 0,
           channel: channelTitle
        });
        uint index = channelResolver[channel];
        channels[index].channelRequests.push(newRequest);
        uint requestLength = channels[index].channelRequests.length;
        channels[index].requestResolver[description] = requestLength-1;
    }

    function approverRequest(string channelTitle, string requestTitle) {
        uint channelIndex = channelResolver[channelTitle];
        Channel storage currentChannel = channels[channelIndex];
        require(
            currentChannel.approverCheck[msg.sender] == true,
            "approver only method"
        );
        uint requestIndex = currentChannel.requestResolver[requestTitle];
        Request storage currentRequest = currentChannel.requests[requestIndex];
        require(
            currentRequest.approvals[msg.sender] == false,
            "already approved"
        );
        currentRequest.approvalCount++;
        currentRequest.approvals[msg.sender] = true;
    }

    function cashRequest(string channelTitle, string requestTitle) public {
        uint channelIndex = channelResolver[channelTitle];
        Channel storage currentChannel = channels[channelIndex];
        uint requestIndex = currentChannel.requestResolver[requestTitle];
        Request storage currentRequest = currentChannel.requests[requestIndex];
        require(currentRequest.recipient == msg.sender,
        "only recipient method");
        require(currentRequest.approvalCount == currentChannel.minApproverCount,
        "number of approvals not reached");
        msg.sender.transfer(currentRequest.value);
        currentRequest.status = true;
    }

}

