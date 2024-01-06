// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

interface INFT {
    function mintTokens(address _to) external;
    function spaceTravel(address _to, uint256 _id, uint256 _requestId) external;
    function getLastRequestId() external returns(uint256 lastRequestId);
}
