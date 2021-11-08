import { ethers } from "hardhat";

async function main() {
    const TestToken = await ethers.getContractFactory("ERC721Base64enc");
    const testToken = await TestToken.attach(
        "0x36605CE3C70Ae1d05B280CE715C70BA7860EdEa7"
    );

    const mintToken = await testToken.mint("bmw", "x5", "https://lh3.googleusercontent.com/--QUh6FACwJL522BmApgZ-5YAqOHM29N05OGq6M34ppv-hErNOH3Hhlr_3ZUS_NMr1f2dLrzJcBybx77BkUnfD9ueje8QhHh9AcZ8OA=s0");
    await mintToken.wait();

    // const changeDescription = await testToken.changeDescription(0, "Mercedes", "SL500");
    // await changeDescription.wait();

    console.log(await testToken.tokenURI(0));
}

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
  });