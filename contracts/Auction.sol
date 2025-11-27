// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Auction {
    address public owner;
    bool public auctionStarted;
    bool public auctionEnded;
    uint public highestBid;
    address public highestBidder;

    mapping(address => uint) public pendingReturns;

    constructor() {
        owner = msg.sender;
    }

    function startAuction() public {
        require(msg.sender == owner, "Only owner can start");
        require(!auctionStarted, "Already started");
        auctionStarted = true;
    }

    function bid() public payable {
        require(auctionStarted, "Auction not started");
        require(!auctionEnded, "Auction already ended");
        require(msg.value > highestBid, "Bid too low");

        if (highestBid > 0) {
            // refund old bidder
            pendingReturns[highestBidder] += highestBid;
        }

        highestBid = msg.value;
        highestBidder = msg.sender;
    }

    function withdraw() public {
        uint amount = pendingReturns[msg.sender];
        require(amount > 0, "Nothing to withdraw");

        pendingReturns[msg.sender] = 0;
        payable(msg.sender).transfer(amount);
    }

    function endAuction() public {
        require(msg.sender == owner, "Only owner");
        require(!auctionEnded, "Already ended");

        auctionEnded = true;
        payable(owner).transfer(highestBid);
    }
}
