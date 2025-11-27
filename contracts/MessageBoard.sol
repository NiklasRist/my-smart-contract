// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract MessageBoard {
    struct Message {
        address sender;
        string text;
    }

    Message[] public messages;

    function postMessage(string memory text) public {
        messages.push(Message(msg.sender, text));
    }

    function getMessagesCount() public view returns (uint) {
        return messages.length;
    }
}
