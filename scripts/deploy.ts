import { ethers } from "hardhat";

async function main() {
  const TestToken = await ethers.getContractFactory("ERC721Base64enc");
  const testToken = await TestToken.deploy("TestToken", "TTK");

  await testToken.deployed();

  console.log("ERC721Base64enc deployed to:", testToken.address);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
