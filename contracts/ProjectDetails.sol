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
//         require(bytes(_startDate).length > 0, "Start date is required");
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
    }

    mapping(uint256 => address) private projectOwners;
    mapping(address => uint256[]) private projectsByOwner;

    Project[] private projects;

    function createProject(string memory _title, string memory _description, string memory _startDate, string memory _endDate, uint256 _amountToRaise) public {
        uint256 projectId = projects.length;
        projects.push(Project(_title, _description, _startDate, _endDate, _amountToRaise));
        projectOwners[projectId] = msg.sender;
        projectsByOwner[msg.sender].push(projectId);
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
}

