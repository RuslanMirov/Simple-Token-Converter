const TokenA = artifacts.require("./TokenA");
const TokenB = artifacts.require("./TokenB");
const Exchange = artifacts.require("./Exchange");

module.exports = function(deployer) {
  const nameA = "Token A";
  const symbolA = "TKNA";

  const nameB = "Token B";
  const symbolB = "TKNB";

  const decimals = 18;
  const total = 100000000000;


  deployer.deploy(TokenA, nameA, symbolA, decimals, total).then(async () => {

  await deployer.deploy(TokenB, nameB, symbolB, decimals, total);

  await deployer.deploy(Exchange);
  })
};
