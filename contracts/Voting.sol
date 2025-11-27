// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Voting {
    struct Poll {
        string question;
        string[] options;
        mapping(uint => uint) votes;
        bool exists;
    }

    uint public pollCount;
    mapping(uint => Poll) public polls;

    function createPoll(string memory _question, string[] memory _options) public {
        require(_options.length >= 2, "Need at least 2 options");

        Poll storage p = polls[pollCount];
        p.question = _question;
        p.options = _options;
        p.exists = true;

        pollCount++;
    }

    function vote(uint pollId, uint option) public {
        require(polls[pollId].exists, "Poll not found");
        require(option < polls[pollId].options.length, "Invalid option");

        polls[pollId].votes[option]++;
    }

    function getVotes(uint pollId, uint option) public view returns (uint) {
        require(polls[pollId].exists, "Poll not found");
        return polls[pollId].votes[option];
    }
}
