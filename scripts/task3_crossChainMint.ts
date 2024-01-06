import { ethers } from "hardhat";

async function main() {

    const destinationChainSelector = '12532609583862916517'
    const receiver = '0x505A761aBD45Dc1DF26e93f3C88E9C13e78044D1'

    let source_minter = await ethers.getContractFactory("SourceMinter");
    const source =
        source_minter.attach('0x907e2414f122867338fbbbE5ecE8CB01c37223DE')

    const tx = await source.mintOnDestinationChain(destinationChainSelector, receiver, 1, 0);
    await tx.wait();
    console.log("Txn hash", tx.hash)
}

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});