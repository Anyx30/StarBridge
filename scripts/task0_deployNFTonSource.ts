import { ethers } from "hardhat";

async function main() {

    const [ deployer ] = await ethers.getSigners()
    console.log("Deployer address:", deployer.address)

    let spaceTravel = await ethers.getContractFactory('IntergalacticTravel')
    const nft = await spaceTravel.deploy(8318,
        '0x9D95B165eCefa55c21Df4cFfc9718781d36B4A6c');
    await nft.waitForDeployment();
    console.log("NFT contract address on Sepolia:", nft.target);

    //Minting a NFT
    const tx = await nft.mintTokens('0x9D95B165eCefa55c21Df4cFfc9718781d36B4A6c', 1);
    await tx.wait();
    console.log("Token Minted");
}

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});