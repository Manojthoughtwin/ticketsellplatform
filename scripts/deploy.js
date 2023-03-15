const { upgrades } = require("hardhat");
const hre = require("hardhat");

async function main() {
  EventFactory = await hre.ethers.getContractFactory("EventFactory");
  eventFactory = await upgrades.deployProxy(EventFactory, [], {
    initializer: "initialize",
  });
  await eventFactory.deployed();
  //implementation address
  const address = await hre.upgrades.erc1967.getImplementationAddress(
    eventFactory.address
  );

  console.log("Address:", eventFactory.address);
  console.log("Address:", address);

  await hre.run("verify:verify", {
    address: address,
    contract: "contracts/EventFactory.sol:EventFactory",
    constructorArguments: [],
  });
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
