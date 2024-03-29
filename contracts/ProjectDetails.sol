//SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.6.0 < 0.9.0;

// ----------------------1ST CONTRACT----------------------//
// contract ProjectDetails {
//     struct Project {
//         string title;
//         string description;
//         string startDate;
//         string endDate;
//         uint256 amountToBeRaised;
//     }

//     mapping(address => Project) private projects;

//     // Function to store project details
//     function createProject(
//         string memory _title,
//         string memory _description,
//         string memory _startDate,
//         string memory _endDate,
//         uint256 _amountToBeRaised
//     ) public {
//         require(bytes(_title).length > 0, "Title is required");
//         require(bytes(_description).length > 0, "Description is required");
//         require(bytes(_startDate).length > 0, "Start date iitems required");
//         require(bytes(_endDate).length > 0, "End date must be greater than start date");
//         require(_amountToBeRaised > 0, "Amount to be raised must be greater than zero");

//         Project memory newProject = Project(
//             _title,
//             _description,
//             _startDate,
//             _endDate,
//             _amountToBeRaised
//         );

//         projects[msg.sender] = newProject;
//     }

//     // Function to retrieve project details
//     function getProjectDetails() public view returns (Project memory) {
//         Project memory project = projects[msg.sender];

//         return project;
//     }
// }

// ----------------------2ND CONTRACT----------------------//

contract ProjectDetails {
    struct Project {
        string title;
        string description;
        string startDate;
        string endDate;
        uint256 amountToRaise;
        uint256 amountRaised;
        string[] milestones;
        string approved;
    }

    address public admin;

    mapping(uint256 => address) private projectOwners;
    mapping(address => uint256[]) private projectsByOwner;

    Project[] private projects;

    constructor(address _admin) {
        admin = _admin;
    }

    function createProject(string memory _title, string memory _description, string memory _startDate, string memory _endDate, uint256 _amountToRaise) public {
        uint256 projectId = projects.length;
        projects.push(Project(_title, _description, _startDate, _endDate, _amountToRaise, 0, new string[](0), "not set"));
        projectOwners[projectId] = msg.sender;
        projectsByOwner[msg.sender].push(projectId);
    }

    function setMilestones(uint256 _projectId, string[] memory _milestones) public {
        require(projectOwners[_projectId] == msg.sender, "Only project owner can set milestones.");
        projects[_projectId].milestones = _milestones;
    }

    // function addAmountRaised(uint256 _projectId, uint256 _amountRaised) public {
    //     // require(projects[_projectId].amountRaised + _amountRaised < projects[_projectId].amountToRaise, "Amount should be less than funding goal");
    //     projects[_projectId].amountRaised += _amountRaised;
    // }

    // function getProjectOwner(uint256 _projectId) public view returns (address) {
    //     return projectOwners[_projectId];
    // }

    function getCurrentProjectId() public view returns (uint256[] memory) {
        return projectsByOwner[msg.sender];
    }

    function approveProject(uint256 _projectId) public {
        require(msg.sender == admin, "You do not have privileges");
        projects[_projectId].approved = "true";
    }

    function rejectProject(uint256 _projectId) public {
        require(msg.sender == admin, "You do not have privileges");
        projects[_projectId].approved = "false";
    }

    function abortProject(uint _index) public {
        require(projectOwners[_index] == msg.sender, "Only project owner can abort project.");


        Project storage projectToDelete = projects[_index];

        // Delete the project from the array
        delete projects[_index];

        // Delete the project data from storage
        delete projectToDelete.title;
        delete projectToDelete.description;
        delete projectToDelete.startDate;
        delete projectToDelete.endDate;
        delete projectToDelete.amountToRaise;
        delete projectToDelete.milestones;
    }

    function isProjectApproved(uint256 _projectId) public view returns (string memory) {
        return projects[_projectId].approved;
    }

    function getProject(uint256 projectId) public view returns (Project memory) {
        require(projectId < projects.length, "Invalid project ID");
        return projects[projectId];
    }


    function getProjectDetails() public view returns (Project[] memory) {
        uint256[] memory projectIds = projectsByOwner[msg.sender];
        Project[] memory result = new Project[](projectIds.length);

        for (uint256 i = 0; i < projectIds.length; i++) {
            uint256 projectId = projectIds[i];
            result[i] = projects[projectId];
        }

        return result;
    }

    function getAllProjects() public view returns (Project[] memory) {
        
        return projects;
    }
}
