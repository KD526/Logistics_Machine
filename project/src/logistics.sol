// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;


contract logistics {
    address public owner;
    uint startTimechain;
    uint public timechainDuration=15 days;
    uint public alltimechains;
 
    struct transport {
        bool transported;
        bool isProposed;
        bool isAccepted;
    }

    mapping(address=>transport) public _transport;
    uint public transportCount;

    constructor(uint _alltimechains) {
        owner=msg.sender;
        startTimechain=block.timestamp;
        alltimechains=_alltimechains;
    }

    function prposeTransport(uint amount) public {
     
        require(amount>=1000, "amount must be at least 1000");
        require(block.timestamp>=startTimechain, "timechain not complete");
        require(alltimechains<=50, "there must be 50 timechains and you have to execute by it");
        require(!_transport[msg.sender].isProposed, "proposal done");
          require(!_transport[msg.sender].isAccepted, "acceptance not given");
        _transport[msg.sender]=transport({
            isProposed:true,
            transported:false,
            isAccepted:true
        });
      
        
    }

  
    function transported() public {
        require(msg.sender==owner, "only owner has access");
          require(_transport[msg.sender].isProposed, "proposal done");
            require(!_transport[msg.sender].transported, "transport done");
            _transport[msg.sender].transported=true;
            transportCount++;

    }

    function nextTimechain() public {
        require(msg.sender==owner, "owner only has access");
        require(block.timestamp>=startTimechain, "timechain yet not over");
        alltimechains-=1;
        startTimechain = block.timestamp + timechainDuration;
    }

}