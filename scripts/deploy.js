const hre = require("hardhat");

async function main() {
  const horoscopeNFT = await hre.ethers.getContractFactory("horoscopeNFT");
  const hscp = await horoscopeNFT.deploy();
  await hscp.deployed();

  console.log("horoscopeNFT deployed to:", hscp.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });