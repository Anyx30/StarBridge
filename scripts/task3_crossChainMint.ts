import { ethers } from "hardhat";

async function main() {

    const destinationChainSelector = '12532609583862916517'
    const receiver = '0x1c41c2960ed598FA57c79E1Eac7726bc39f35d05'

    let source_minter = await ethers.getContractFactory("SourceMinter");
    const source =
        source_minter.attach('0x4d67Fe7Ae4467FC04010bA173dBF31c8e3D00751')

    const tx = await source.mintOnDestinationChain(destinationChainSelector, receiver, 1, 0);
    await tx.wait();
    console.log("Txn hash", tx.hash)
}

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});