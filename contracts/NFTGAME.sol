// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

// @title This is the nft contract that would mint the nft(s) and include the game logics
contract NFTGAME is ERC721 {

    uint256 public tokenId;

    constructor() ERC721("XToken", "XT") {}

    function mintTokens(address _to) public {
        _safeMint(_to, tokenId + 1);
        unchecked {
            tokenId++;
        }
    }

}
