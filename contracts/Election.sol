pragma solidity >=0.4.21 <0.7.0;

contract Election{

  struct Candidate {
    uint id;
    string name;
    uint voteCount;
  }
  // Store accounts that have voted
   mapping(address => bool) public voters;

  //Store candidates
  mapping(uint => Candidate) public candidates;

//address:voter address
  mapping(address => Candidate) public records;


  // Store candidates Count
  uint public candidatesCount;

  

  // voted event
  event votedEvent (
      uint indexed _candidateId
  );

  // Constructor
  constructor() public {
    candidatesCount = 1;
    addCandidate("Candidate 1");
    addCandidate("Candidate 2");
  }

  // Add candidate
  function addCandidate (string memory _name) private {
    candidates[candidatesCount] = Candidate(candidatesCount, _name, 0);
    candidatesCount ++;
  }

  

  function vote(uint _candidateId) public {
    require(!voters[msg.sender]);
    require(_candidateId > 0 && _candidateId <= candidatesCount);
    voters[msg.sender] = true;

    candidates[_candidateId].voteCount ++;

    records[msg.sender] = candidates[_candidateId];

    emit votedEvent(_candidateId);

  }
  function getRecord(address _address) public view returns(uint){
    return(records[_address].id);

  }
  
}
