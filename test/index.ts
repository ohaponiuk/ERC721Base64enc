import { expect } from "chai";
import { ethers } from "hardhat";

describe("Base64 metadata token", function () {
  it("Minting", async function () {
    const TestToken = await ethers.getContractFactory("TestToken");
    const testToken = await TestToken.deploy("TestToken", "TKX");
    await testToken.deployed();

    const mintToken = await testToken.mint("BMW", "X5", "https://lh3.googleusercontent.com/--QUh6FACwJL522BmApgZ-5YAqOHM29N05OGq6M34ppv-hErNOH3Hhlr_3ZUS_NMr1f2dLrzJcBybx77BkUnfD9ueje8QhHh9AcZ8OA=s0");
    await mintToken.wait();

    console.log(await testToken.tokenURI(0));
  });
});
