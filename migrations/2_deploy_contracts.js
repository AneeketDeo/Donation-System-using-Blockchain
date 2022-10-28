var funding = artifacts.require("./funding.sol");

module.exports = function(deployer) {
  deployer.deploy(funding, 1000,3600);
};
