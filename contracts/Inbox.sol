pragma solidity ^0.4.25;

contract Campaign {
    address public manager;
    uint public minContribution;
    address[] public approvers;

    struct Request {
        string description;
        uint value;
        address recipient;
        bool status;
    }

    Request[] public requests;

    modifier onlyManager {
        require(msg.sender == manager,
        "only manager can access the function");
        _;
    }

    constructor(uint min) public {
        manager = msg.sender;
        minContribution = min;
    }

    function contribute() public payable {
        require(msg.value > minContribution,
        "Minimum Contribution not satisifed");
        approvers.push(msg.sender);
    }

    function createRequest(string description, address recipient, uint value) public onlyManager {
        Request memory newRequest = Request({
            description: description,
            value: value,
            recipient: recipient,
            status: false
        });
        requests.push(newRequest);
    }

    function approveRequest() {
        
    }
}

