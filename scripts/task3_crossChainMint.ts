import { ethers } from "hardhat";

async function main() {

    const destinationChainSelector = '12532609583862916517'
    const receiver = '0xdac3563FE2B1B8AfDb57F2070989C7dE09e3798F'

    let source_minter = await ethers.getContractFactory("SourceMinter");
    const source =
        source_minter.attach('0x4E0575f621f1351eB7f1E6D8E97cC8819000c125')

    const tx = await source.mintOnDestinationChain(destinationChainSelector, receiver, 1, 0);
    await tx.wait();
    console.log("Txn hash", tx.hash)
}

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});