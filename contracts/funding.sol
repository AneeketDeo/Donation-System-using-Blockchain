//SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.6.0 < 0.9.0;

//---------------------------------CONTRACT #1-------------------------------------//
// contract funding{
//     mapping(address=>uint) public contributors; //contributors[msg.sender]=100
//     address public manager; 
//     uint public minimumContribution;
//     uint public deadline;
//     uint public target;
//     uint public raisedAmount;
//     uint public noOfContributors;
    
//     struct Request{
//         string description;
//         address payable recipient;
//         uint value;
//         bool completed;
//         uint noOfVoters;
//         mapping(address=>bool) voters;
//     }

//     mapping(uint=>Request) public requests;
//     uint public numRequests;

//     constructor (uint _target,uint _deadline){
//         target=_target;
//         deadline=block.timestamp+_deadline; //10sec + 3600sec (60*60)
//         minimumContribution=100 wei;
//         manager=msg.sender;
//     }
    
// // Donor functions
// // 1. Donate Money
//     function sendEth() public payable{
//         require(block.timestamp < deadline,"Deadline has passed");
//         require(msg.value >=minimumContribution,"Minimum Contribution is not met");
        
//         if(contributors[msg.sender]==0){
//             noOfContributors++;
//         }
//         contributors[msg.sender]+=msg.value;
//         raisedAmount+=msg.value;
//     }
//     function getContractBalance() public view returns(uint){
//         return address(this).balance;
//     }

// // 2. Request refund
//     function refund() public payable{
//         // require(block.timestamp>deadline && raisedAmount<target,"You are not eligible for refund");
//         require(contributors[msg.sender]>0);
//         address payable user= payable(msg.sender);
//         user.transfer(contributors[msg.sender]);
//         raisedAmount -= contributors[msg.sender];
//         noOfContributors--;
//         contributors[msg.sender]=0;
        
//     }

// // 3. To get votes from existing contributors to allocate the new project
//     function voteRequest(uint _requestNo) public{
//         require(contributors[msg.sender]>0,"You must be contributor");
//         Request storage thisRequest=requests[_requestNo];
//         require(thisRequest.voters[msg.sender]==false,"You have already voted");
//         thisRequest.voters[msg.sender]=true;
//         thisRequest.noOfVoters++;
//     }

// // modifier to check if the function is accessed by the manager(as some functions cannot be accessed by anybody else)
//     modifier onlyManager(){
//         require(msg.sender == manager,"Only manager can call this function");
//         _;
//     }

// // Manager(Admin) Functions
// // 1. To create new Project allocations
//     function createRequests(string memory _description,address payable _recipient,uint _value)public onlyManager{
//         Request storage newRequest = requests[numRequests];
//         numRequests++;
//         newRequest.description=_description;
//         newRequest.recipient=_recipient;
//         newRequest.value=_value;
//         newRequest.completed=false;
//         newRequest.noOfVoters=0;
//     }


// }


//---------------------------------CONTRACT #2-------------------------------------//
// contract funding {
    
//     // Project struct to store project details
//     struct Project {
//         address owner;
//         string title;
//         string description;
//         uint goal;
//         uint raised;
//         bool completed;
//         mapping(address => uint) contributions;
//     }
    
//     // Array of projects
//     Project[] public projects;
    
//     // Event emitted when a new project is created
//     // event ProjectCreated(uint projectId, address owner, string title, string description, uint goal);
    
//     // Event emitted when a project is funded
//     event ProjectFunded(uint projectId, address funder, uint amount);
    
    
//     // Function to fund a project
//     function fundProject(uint _projectId) public payable {
//         Project storage project = projects[_projectId];
//         require(msg.value > 0, "Amount should be greater than 0");
//         require(!project.completed, "Project is already completed");
//         require(project.raised < project.goal, "Project goal is already reached");
//         project.contributions[msg.sender] += msg.value;
//         project.raised += msg.value;
//         emit ProjectFunded(_projectId, msg.sender, msg.value);
//     }
    
//     // Function to check the contribution of a funder for a project
//     function checkContribution(uint _projectId) public view returns(uint) {
//         return projects[_projectId].contributions[msg.sender];
//     }
    
//     // Function to check the status of a project
//     function checkProjectStatus(uint _projectId) public view returns(bool) {
//         return projects[_projectId].completed;
//     }
    
//     // Function to complete a project and transfer funds to owner
//     function completeProject(uint _projectId) public {
//         Project storage project = projects[_projectId];
//         require(!project.completed, "Project is already completed");
//         require(project.raised >= project.goal, "Project goal is not reached");
//         project.completed = true;
//         payable(project.owner).transfer(project.raised);
//     }
// }



//---------------------------------CONTRACT #3-------------------------------------//
// import "./ProjectDetails.sol";

// contract funding {

//     // Project Contract
//     ProjectDetails projectDetails;

//     address payable public projectOwner;
//     uint public fundingGoal;
//     uint public totalAmountRaised;
//     mapping(address => uint) public contributors;
//     bool public goalReached;

//     address public admin;

//     // constructor(address payable _projectOwner, uint _fundingGoal, address _admin) {
//     //     projectOwner = _projectOwner;
//     //     fundingGoal = _fundingGoal;
//     //     admin = _admin;
//     // }

//     constructor(address _admin) {
//         projectDetails = ProjectDetails(0xDCC75D043d19b083Cca4CA9d35FA45C2ae4D9051);
//         admin = _admin;
//     }


//     function contribute(uint256 _projectId) public payable {
//         require(msg.value > 0, "Contribution amount must be greater than 0");
//         require(msg.value < projectDetails.getProject(_projectId).amountToRaise, "Funding goal already reached");
//         projectDetails.getProject(_projectId).amountRaised += msg.value;
//         contributors[msg.sender] += msg.value;
//         totalAmountRaised += msg.value;
//         payable(projectDetails.getProjectOwner(_projectId)).transfer(msg.value);
//     }

//     function withdraw() public {
//         require(goalReached, "Funding goal not reached");
//         require(msg.sender == projectOwner, "Only project owner can withdraw funds");
//         payable(msg.sender).transfer(address(this).balance);
//     }

//     function checkGoalReached() public {
//         if (totalAmountRaised >= fundingGoal) {
//             goalReached = true;
//         }
//     }

//     function refund() public {
//         require(contributors[msg.sender] > 0, "No contribution found for this address");
//         uint amount = contributors[msg.sender];
//         contributors[msg.sender] = 0;
//         totalAmountRaised -= amount;
//         payable(msg.sender).transfer(amount);
//     }
// }


//---------------------------------CONTRACT #4-------------------------------------//
import "./ProjectDetails.sol";

contract funding {

    // Project Contract
    ProjectDetails projectDetails;

    address payable public projectOwner;
    uint public fundingGoal;
    uint public totalAmountRaised;
    mapping(address => uint) public contributors;
    bool public goalReached;

    address public admin;

    constructor() {
        projectDetails = ProjectDetails(0x7B510757Dc3153b985e5fd3f639b467eB007B9E1);
        // admin = _admin;
    }

    function weiToEther(uint256 weiAmount) public pure returns (uint256) {
        return weiAmount / 1 ether;
    }



    function contribute(uint256 _projectId) public payable {
        require(msg.value > 0, "Contribution amount must be greater than 0");

        uint256 remainingAmount = getToRaised(_projectId) - getProjectAmountRaised(_projectId);
        uint256 etherAmount = weiToEther(msg.value);

        // CHANGES                                
        if (etherAmount >= remainingAmount) {
            // Adjust the contribution amount to the remaining amount required to reach the funding goal
            // payable(projectDetails.getProjectOwner(_projectId)).transfer(etherAmount - remainingAmount);
            // projectDetails.addAmountRaised(_projectId, remainingAmount);
        } else {
            // projectDetails.addAmountRaised(_projectId, etherAmount);
            // payable(projectDetails.getProjectOwner(_projectId)).transfer(etherAmount);
        }
        
        
    }

    // remix
    function getProjectName(uint256 _projectId) public view returns (string memory) {
        return projectDetails.getProject(_projectId).title;
    }

    // remix
    function getProjectAmountRaised(uint256 _projectId) public view returns (uint256) {
        return projectDetails.getProject(_projectId).amountRaised;
    }

    function getToRaised(uint256 _projectId) public view returns (uint256) {
        return projectDetails.getProject(_projectId).amountToRaise;
    }

    function withdraw() public {
        require(goalReached, "Funding goal not reached");
        require(msg.sender == projectOwner, "Only project owner can withdraw funds");
        payable(msg.sender).transfer(address(this).balance);
    }

    function checkGoalReached() public {
        if (totalAmountRaised >= fundingGoal) {
            goalReached = true;
        }
    }

    function refund() public {
        require(contributors[msg.sender] > 0, "No contribution found for this address");
        uint amount = contributors[msg.sender];
        contributors[msg.sender] = 0;
        totalAmountRaised -= amount;
        payable(msg.sender).transfer(amount);
    }
}

