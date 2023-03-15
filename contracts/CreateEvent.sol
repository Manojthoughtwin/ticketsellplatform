//SPDX-License-Identifier:UNLICENSED

pragma solidity ^0.8.12;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/cryptography/MerkleProof.sol";

contract CreateEvent is ERC721, Ownable {
    mapping(uint256 => EventDetails) public events;

    string private baseURI;

    bytes32 public merkleRoot;

    uint256 ticketNumber = 0;
    uint256 public remainingTickets;

    struct EventDetails {
        address payable owner;
        string eventName;
        string eventCategory;
        uint256 ticketPrice;
        uint256 eventID;
        uint256 ticketTotalSupply;
        uint256 perUserMaxTicket;
        uint256 eventStartTime;
        uint256 totalFunds;
        uint256 eventEndTime;
        address[] buyers;
        mapping(address => BuyerDetails) tickets;
    }

    struct BuyerDetails {
        uint256 index;
        address buyerAddress;
        uint256 totalUserTickets;
    }

    event EventCreated(uint256 eventID);

    constructor(
        address payable owner,
        string memory _eventName,
        string memory _eventCategory,
        uint256 _eventID,
        uint256 _ticketPrice,
        uint256 _ticketTotalSupply,
        uint256 _perUserMaxTicket,
        uint256 _eventStartTime,
        uint256 _eventEndTime
    ) ERC721(_eventName, _eventCategory) {
        require(
            _ticketTotalSupply > 0,
            "CreateEvent: Ticket totalSupply can't be Zero"
        );

        require(
            _perUserMaxTicket > 0,
            "CreateEvent: PerUserMaxTicket can't be Zero "
        );

        require(
            _perUserMaxTicket < _ticketTotalSupply,
            "CreateEvent: PerUserMaxTicket can't be grater that Total Ticket Supply"
        );

        events[_eventID].owner = payable(msg.sender);
        events[_eventID].eventName = _eventName;
        events[_eventID].eventCategory = _eventCategory;
        events[_eventID].eventID = _eventID;
        events[_eventID].ticketPrice = _ticketPrice;
        events[_eventID].ticketTotalSupply = _ticketTotalSupply;
        events[_eventID].perUserMaxTicket = _perUserMaxTicket;
        events[_eventID].eventStartTime = _eventStartTime;
        events[_eventID].eventEndTime = _eventEndTime;
        remainingTickets = events[_eventID].ticketTotalSupply;
        _transferOwnership(owner);

        emit EventCreated(_eventID);
    }

    function _baseURI() internal view override returns (string memory) {
        return baseURI;
    }

    function setMerkelRoot(bytes32 _merkleRoot) external onlyOwner {
        merkleRoot = _merkleRoot;
    }

    function setbaseURI(string memory newbaseURI) external onlyOwner {
        baseURI = newbaseURI;
    }

    function viewFund(
        uint256 _eventID
    ) external view onlyOwner returns (uint256 currentFund) {
        return (events[_eventID].totalFunds);
    }

    function withdrawFund(uint256 _eventID) external onlyOwner {
        require(
            events[_eventID].totalFunds > 0,
            "CreateEvent: No fund to Withdraw"
        );
        require(
            events[_eventID].eventStartTime > block.timestamp,
            "CreateEvent: Can't Withdraw Now As Event not Started yet"
        );

        uint256 withdrawTicketFund = events[_eventID].totalFunds;

        payable(msg.sender).transfer(withdrawTicketFund);

        events[_eventID].totalFunds = 0;
    }

    function buyTicket(uint256 _eventID) external payable {
        require(
            events[_eventID].eventStartTime > block.timestamp,
            "CreateEvent: Can't Buy Tickets as Event is Started"
        );
        require(
            ticketNumber < events[_eventID].ticketTotalSupply,
            "CreateEvent: OOPS! Tickets Not Available"
        );

        require(
            events[_eventID].tickets[msg.sender].totalUserTickets <
                events[_eventID].perUserMaxTicket,
            "CreateEvent: OOPS! You Book More Tickets"
        );
        require(
            msg.value >= events[_eventID].ticketPrice,
            "CreateEvent: Invalid Amount Sent "
        );

        _mint(msg.sender, ticketNumber);

        events[_eventID].totalFunds += msg.value;
        ticketNumber++;
        remainingTickets--;
        events[_eventID].tickets[msg.sender].totalUserTickets++;
    }

    function verifyUser(
        bytes32[] calldata _merkleProof
    ) external view returns (string memory) {
        bytes32 leaf = keccak256(abi.encodePacked(msg.sender));
        require(
            MerkleProof.verify(_merkleProof, merkleRoot, leaf),
            "Merkle Proof is Invalid"
        );

        return "User Verfied SuccesFully";
    }
}
