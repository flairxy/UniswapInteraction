const UniswapInteraction = artifacts.require("UniswapInteraction");

module.exports = function (deployer, _network, accounts) {
  deployer.deploy(UniswapInteraction, accounts[1]);
};