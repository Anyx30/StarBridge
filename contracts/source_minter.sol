// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import { CCIPReceiver } from "@chainlink/contracts-ccip/src/v0.8/ccip/applications/CCIPReceiver.sol";
import { IRouterClient } from "@chainlink/contracts-ccip/src/v0.8/ccip/interfaces/IRouterClient.sol";
import { LinkTokenInterface } from "@chainlink/contracts/src/v0.8/shared/interfaces/LinkTokenInterface.sol";
import { Client } from "@chainlink/contracts-ccip/src/v0.8/ccip/libraries/Client.sol";
import { Ownable } from "@openzeppelin/contracts/access/Ownable.sol";
import "./interfaces/INFT.sol";

contract SourceMinter {

    error DestinationChainNotAllowed(uint64 destinationChainSelector);
    error NotEnoughBalance(uint256 currentBalance, uint256 calculatedFees);

    event MessageSent(bytes32 messageId);

    enum PayFeesIn {
        Native,
        Link
    }

    IRouterClient public s_router;
    LinkTokenInterface public linkToken;
    INFT public space;

    modifier onlyAllowlistedDestinationChain(uint64 _destinationChainSelector) {
        if (!allowlistedDestinationChains[_destinationChainSelector])
            revert DestinationChainNotAllowed(_destinationChainSelector);
        _;
    }

    mapping(uint64 chainSelector => bool isAllowed) allowlistedDestinationChains;
    mapping(uint64 chainSelector => bool isAllowed) allowlistedSourceChains;

    constructor(address _router, address _linkToken, address _nft) {
        s_router = IRouterClient(_router);
        linkToken = LinkTokenInterface(_linkToken);
        space = INFT(_nft);
    }

    function allowlistDestinationChain(uint64 _destinationChainSelector, bool allowed) external {
        allowlistedDestinationChains[_destinationChainSelector] = allowed;
    }

    function allowlistSourceChains(uint64 _destinationChainSelector, bool allowed) external {
        allowlistedSourceChains[_destinationChainSelector] = allowed;
    }

    function mintOnDestinationChain(uint64 _destinationChainSelector, address _receiver,
        uint256 _id, PayFeesIn payFeesIn) external {

        Client.EVM2AnyMessage memory message = Client.EVM2AnyMessage({
            receiver: abi.encode(_receiver),
            data: abi.encodeWithSignature("spaceTravel(address,uint256,uint256)", msg.sender, _id, space.getLastRequestId()),
            tokenAmounts: new Client.EVMTokenAmount[](0),
            extraArgs: "",
            feeToken: payFeesIn == PayFeesIn.Link ? address(linkToken) : address(0)
        });

        uint fees = s_router.getFee(_destinationChainSelector, message);
        bytes32 messageId;

        if(payFeesIn == PayFeesIn.Link) {
            linkToken.approve(address(s_router), fees);
            messageId = s_router.ccipSend(_destinationChainSelector, message);
        }
        else {
            messageId = s_router.ccipSend{value: fees}(_destinationChainSelector, message);
        }
        emit MessageSent(messageId);
    }
    receive() external payable {}
}
