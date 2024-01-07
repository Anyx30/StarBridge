// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

interface INFT {
    function spaceTravel(address _to, uint256 _id, uint256 _newId) external;
    function getLastRequestId() external returns(uint256 lastRequestId);
    function getResultOnRequest(uint256 _requestId) external view returns(uint256);
}
