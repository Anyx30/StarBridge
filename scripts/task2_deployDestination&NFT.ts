import { ethers } from "hardhat";

async function main() {

    // Deploying NFT
    let NFT = await ethers.getContractFactory('IntergalacticTravel');
    const nft = await NFT.deploy('8318',
        '0x9D95B165eCefa55c21Df4cFfc9718781d36B4A6c')
    await nft.waitForDeployment()
    console.log("NFT Address:", nft.target)

    // Deploying Destination Minter
    const d_router = "0x1035cabc275068e0f4b745a29cedf38e13af41b1"

    const d_minter = await ethers.deployContract("DestinationMinter",
        [d_router, nft.target])
    console.log("Destination Minter Address:", d_minter.target)

}

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});