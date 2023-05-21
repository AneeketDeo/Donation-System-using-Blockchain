var funding = artifacts.require("./funding.sol");
var ProjectOwnerLogin = artifacts.require("./ProjectOwnerLogin.sol");
var BackerLogin = artifacts.require("./BackerLogin.sol");
var AdminLogin = artifacts.require("./AdminLogin.sol");


module.exports = function(deployer) {
  deployer.deploy(ProjectOwnerLogin);
  deployer.deploy(BackerLogin);
  deployer.deploy(AdminLogin);
};

// module.exports = function(deployer) {
  
// };
