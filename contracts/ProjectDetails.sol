//SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.6.0 < 0.9.0;

contract ProjectDetails {
    struct Project {
        string title;
        string description;
        string startDate;
        string endDate;
        uint256 amountToBeRaised;
    }

    mapping(address => Project) private projects;

    // Function to store project details
    function createProject(
        string memory _title,
        string memory _description,
        string memory _startDate,
        string memory _endDate,
        uint256 _amountToBeRaised
    ) public {
        require(bytes(_title).length > 0, "Title is required");
        require(bytes(_description).length > 0, "Description is required");
        require(bytes(_startDate).length > 0, "Start date is required");
        require(bytes(_endDate).length > 0, "End date must be greater than start date");
        require(_amountToBeRaised > 0, "Amount to be raised must be greater than zero");

        Project memory newProject = Project(
            _title,
            _description,
            _startDate,
            _endDate,
            _amountToBeRaised
        );

        projects[msg.sender] = newProject;
    }

    // Function to retrieve project details
    function getProjectDetails() public view returns (string memory, string memory, string memory, string memory, uint256) {
        Project memory project = projects[msg.sender];

        return (
            project.title,
            project.description,
            project.startDate,
            project.endDate,
            project.amountToBeRaised
        );
    }
}
