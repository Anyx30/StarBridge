// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import { CCIPReceiver } from "@chainlink/contracts-ccip/src/v0.8/ccip/applications/CCIPReceiver.sol";
import { INFT2 } from "./interfaces/INFT2.sol";
import { Client } from "@chainlink/contracts-ccip/src/v0.8/ccip/libraries/Client.sol";

contract DestinationMinter is CCIPReceiver {

    INFT2 public nft;

    event MintSuccessful();

    constructor(address _router, address _nft) CCIPReceiver(_router) {
        nft = INFT2(_nft);
    }

    function _ccipReceive(
        Client.Any2EVMMessage memory message
    ) internal override {
        (bool success, ) = address(nft).call(message.data);
        require(success);
        emit MintSuccessful();
    }

}
