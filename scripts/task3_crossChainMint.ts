import { ethers } from "hardhat";

async function main() {

    const destinationChainSelector = '12532609583862916517'
    const receiver = '0x36776CA9277462493cea7E03c82f38D1C98546a3'

    let source_minter = await ethers.getContractFactory("SOURCE_MINTER");
    const source =
        source_minter.attach('0x0EFf854b67A693d437882E0EAa923218D46eA74F')

    const tx = await source.mintOnDestinationChain(destinationChainSelector, receiver, 0);
    await tx.wait();
    console.log("Txn hash", tx.hash)
}

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});