var funding = artifacts.require("./funding.sol");
var authentication = artifacts.require("./Authentication.sol");
var demo = artifacts.require("./demo.sol");

module.exports = function(deployer) {
  deployer.deploy(funding, 1000,3600);
  deployer.deploy(authentication);
  deployer.deploy(demo);
};

// module.exports = function(deployer) {
  
// };
