// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@chainlink/contracts/src/v0.8/vrf/VRFConsumerBaseV2.sol";
import "@chainlink/contracts/src/v0.8/interfaces/VRFCoordinatorV2Interface.sol";

// @title This is the nft contract that would mint the nft(s) and include the game logics
contract IntergalacticTravel is ERC721, VRFConsumerBaseV2 {

    mapping(uint256 nftId => bool burned) public isInsidePod;
    mapping(uint256 requestId => uint256 resutls) public s_results;

    uint256 public s_tokensMinted;

    // Network: Sepolia
    bytes32 private s_keyHash = 0x474e34a077df58807dbe9c96d3c009b23b3c6d0cce433e59bbf5b34f823bc56c;
    VRFCoordinatorV2Interface private COORDINATOR;

    //VRF
    uint64 private s_subscriptionId;
    uint32 private callbackGasLimit = 40000;
    uint16 private requestConfirmations = 3;
    uint32 private numWords = 1;

    // past requests Id.
    uint256[] public requestIds;
    uint256 public lastRequestId;

    constructor(uint64 _subscriptionId) ERC721("Spacemen", "SPC")
    VRFConsumerBaseV2(0x8103B0A8A00be2DDC778e6e7eaa21791Cd364625){
        s_subscriptionId = _subscriptionId;
        COORDINATOR = VRFCoordinatorV2Interface(0x8103B0A8A00be2DDC778e6e7eaa21791Cd364625);
    }

    function mintTokens(address _to, uint id) public {
        _safeMint(_to, id);
        unchecked {
            s_tokensMinted++;
        }
    }

    function spaceTravel(address _to, uint256 _id, uint256 _requestId) external {
        require(isInsidePod[_id], 'Enter pod to travel');
        isInsidePod[_id] = false;
        _safeMint(_to, s_results[_requestId]);
    }

    function enterPod(uint _id) external returns(uint256 requestId){
        require(ownerOf(_id) == msg.sender, 'Not owner of NFT');
        requestId = COORDINATOR.requestRandomWords(
            s_keyHash,
            s_subscriptionId,
            requestConfirmations,
            callbackGasLimit,
            numWords
        );
        requestIds.push(requestId);
        lastRequestId = requestId;
        isInsidePod[_id] = true;
        _burn(_id);
        return requestId;
    }

    function getLastRequestId() external returns(uint256 lastRequestId){
        return lastRequestId;
    }

    function fulfillRandomWords(uint256 requestId, uint256[] memory randomWords) internal override {
        // transform the result to a number between 1 and 20 inclusively
        uint256 d20Value = (randomWords[0] % 20) + 1;
        // assign the transformed value to the address in the s_results mapping variable
        s_results[requestId] = d20Value;
    }

}
