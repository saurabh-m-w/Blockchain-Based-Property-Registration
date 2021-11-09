const landContract = artifacts.require("Land");

module.exports = function(deployer) {
  deployer.deploy(landContract);
};
