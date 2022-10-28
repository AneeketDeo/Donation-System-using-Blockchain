//SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.5.0 < 0.9.0;

contract funding{
    mapping(address=>uint) public contributors; //contributors[msg.sender]=100
    address public manager; 
    uint public minimumContribution;
    uint public deadline;
    uint public target;
    uint public raisedAmount;
    uint public noOfContributors;
    
    struct Request{
        string description;
        address payable recipient;
        uint value;
        bool completed;
        uint noOfVoters;
        mapping(address=>bool) voters;
    }

    mapping(uint=>Request) public requests;
    uint public numRequests;

    constructor (uint _target,uint _deadline) public{
        target=_target;
        deadline=block.timestamp+_deadline; //10sec + 3600sec (60*60)
        minimumContribution=100 wei;
        manager=msg.sender;
    }
    
// Donor functions
// 1. Donate Money
    function sendEth() public payable{
        require(block.timestamp < deadline,"Deadline has passed");
        require(msg.value >=minimumContribution,"Minimum Contribution is not met");
        
        if(contributors[msg.sender]==0){
            noOfContributors++;
        }
        contributors[msg.sender]+=msg.value;
        raisedAmount+=msg.value;
    }
    function getContractBalance() public view returns(uint){
        return address(this).balance;
    }

// 2. Request refund
    // function refund() public payable{
    //     // require(block.timestamp>deadline && raisedAmount<target,"You are not eligible for refund");
    //     require(contributors[msg.sender]>0);
    //     address payable user= payable(msg.sender);
    //     user.transfer(contributors[msg.sender]);
    //     raisedAmount -= contributors[msg.sender];
    //     noOfContributors--;
    //     contributors[msg.sender]=0;
        
    // }

// 3. To get votes from existing contributors to allocate the new project
    function voteRequest(uint _requestNo) public{
        require(contributors[msg.sender]>0,"You must be contributor");
        Request storage thisRequest=requests[_requestNo];
        require(thisRequest.voters[msg.sender]==false,"You have already voted");
        thisRequest.voters[msg.sender]=true;
        thisRequest.noOfVoters++;
    }

// modifier to check if the function is accessed by the manager(as some functions cannot be accessed by anybody else)
    modifier onlyManager(){
        require(msg.sender == manager,"Only manager can call this function");
        _;
    }

// Manager(Admin) Functions
// 1. To create new Project allocations
    function createRequests(string memory _description,address payable _recipient,uint _value)public onlyManager{
        Request storage newRequest = requests[numRequests];
        numRequests++;
        newRequest.description=_description;
        newRequest.recipient=_recipient;
        newRequest.value=_value;
        newRequest.completed=false;
        newRequest.noOfVoters=0;
    }


}