import { ethers } from "hardhat";

async function main() {

    const destinationChainSelector = '12532609583862916517'
    const receiver = '0x7E51eD5C6A9c0C4B0b1ff2C72Fb91f0C55d764ca'

    let source_minter = await ethers.getContractFactory("SourceMinter");
    const source =
        source_minter.attach('0xB044178B3Ffbf435b61e937dA2DD1c32B3dc1Fdf')

    const tx = await source.mintOnDestinationChain(destinationChainSelector, receiver, 0);
    await tx.wait();
    console.log("Txn hash", tx.hash)
}

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});