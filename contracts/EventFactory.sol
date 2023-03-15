//SPDX-License-Identifier:UNLICENSED

pragma solidity ^0.8.12;

import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "./CreateEvent.sol";

contract EventFactory is Initializable {
    address payable public owner;
    uint256 public contractCount;
    address[] public contracts;

    function initialize() public initializer {
        owner = payable(msg.sender);
    }

    event Create(
        address payable owner,
        string eventName,
        string eventCategory,
        uint256 ticketPrice,
        uint256 eventID,
        uint256 ticketTotalSupply,
        uint256 perUserMaxTicket,
        uint256 eventStartTime,
        uint256 eventEndTime,
        address indexed contractAddress
    );

    function createNFT(
        string memory _eventName,
        string memory _eventCategory,
        uint256 _eventID,
        uint256 _ticketPrice,
        uint256 _ticketTotalSupply,
        uint256 _perUserMaxTicket,
        uint256 _eventStartTime,
        uint256 _eventEndTime
    ) public {
        require(msg.sender == owner);
        owner = payable(msg.sender);
        address newContract = address(
            new CreateEvent(
                owner,
                _eventName,
                _eventCategory,
                _eventID,
                _ticketPrice,
                _ticketTotalSupply,
                _perUserMaxTicket,
                _eventStartTime,
                _eventEndTime
            )
        );
        contractCount++;
        contracts.push(newContract);

        emit Create(
            payable(msg.sender),
            _eventName,
            _eventCategory,
            _ticketPrice,
            _eventID,
            _ticketTotalSupply,
            _perUserMaxTicket,
            _eventStartTime,
            _eventEndTime,
            newContract
        );
    }

    function getNFTContracts() public view returns (address[] memory) {
        return contracts;
    }
}
