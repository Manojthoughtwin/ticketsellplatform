//SPDX-License-Identifier:UNLICENSED

pragma solidity ^0.8.12;

import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract CreateEvent is IERC721, Ownable {
    mapping(uint256 => EventDetails) public events;

    string private baseURI;

    uint256 ticketNumber = 0;

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

        emit EventCreated(_eventID);
    }

    function _baseURI() internal view override returns (string memory) {
        return baseURI;
    }

    function setbaseURI(string memory newbaseURI) external onlyOwner {
        baseURI = newbaseURI;
    }

    function viewFund(uint256 _eventID)
        external
        view
        onlyOwner
        returns (uint256 currentFund)
    {
        return (events[_eventID].totalFunds);
    }

    function withdrawFund(uint256 _eventID) external onlyOwner {
        uint256 withdrawTicketFund = events[_eventID].totalFunds;
        events[_eventID].totalFunds = 0;

        (bool success, ) = events[_eventID].owner.call{
            value: withdrawTicketFund
        }("");
        require(success, "Fund Transfer Failed");
    }

    function buyTicket(uint256 _eventID) external payable {
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
            msg.value == events[_eventID].ticketPrice,
            "CreateEvent: Invalid Amount Sent "
        );

        _mint(msg.sender, ticketNumber);

        events[_eventID].totalFunds += msg.value;

        ticketNumber++;

        events[_eventID].tickets[msg.sender].totalUserTickets++;

        payable(address(this)).transfer(msg.value);
    }
}
