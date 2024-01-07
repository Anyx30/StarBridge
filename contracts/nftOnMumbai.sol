// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract nftOnMumbai is ERC721 {

    constructor() ERC721("Spacemen", "SPC"){}

    function spaceTravel(address _to, uint256 _newId) external {
        _safeMint(_to, _newId);
    }

}
