import { ethers } from "hardhat";

async function main() {

  const [ deployer ] = await ethers.getSigners()
  console.log("Deployer address:", deployer.address)

  const s_router = "0x0bf3de8c5d3e8a2b34d2beeb17abfcebaf363a59"
  const s_link = "0x779877A7B0D9E8603169DdbD7836e478b4624789"

  let Source_Minter = await ethers.getContractFactory('SOURCE_MINTER');
  const source = await Source_Minter.deploy(s_router, s_link);
  await source.waitForDeployment()

  console.log("Source Minter Address:", source.target)

}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});