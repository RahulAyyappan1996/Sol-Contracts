pragma solidity ^0.5.0;

contract Voting {
    struct Candidate {
        uint id;
        address addr;
        string name;
        string promises;
        uint votes;
    }
    uint public candidateCount = 0;
    address winner;
    address owner;
    mapping(uint => Candidate) candidatesList;
    mapping (address => bool) candidateAlreadyRegistered;
    mapping (address => bool) votersAlreadyVoted;
    
    event WinnerIsDeclared(address indexed _winner, string  _name);
    constructor() public {
        owner = msg.sender;
    }
    
    modifier onlyCreator() {
        require(msg.sender == owner, "You need to be creator of this smart contract!");
        _;
    }
    function registerAsCandidate(string memory _name, string memory _promises) payable public {
        require(msg.sender != owner, "Creator cannot register as Candidate!");
        require(candidateAlreadyRegistered[msg.sender] == false, "You've already registered!");
        require(msg.value == 1 ether, "You need to pay 1 ether to register for elections!");
        require(bytes(_name).length >= 1, "Name should be at least one character long");
        require(bytes(_promises).length >= 1, "Promise should not be an empty promise!");
        
        candidateAlreadyRegistered[msg.sender] = true;
        candidatesList[candidateCount] = Candidate(candidateCount, msg.sender, _name, _promises, 0);
        candidateCount++;
    }
    
    function viewCandidate(uint index) public view returns (string memory name, string memory promises, uint votes) {
        
        Candidate memory c = candidatesList[index];
        return (c.name, c.promises, c.votes);
    }
    
    function voteForCandidate(uint index) public {
        require(index >= 0 && index < candidateCount, "Invalid index for Candidate");
        require(msg.sender != candidatesList[index].addr, "You cannot vote for yourself!");
        require(votersAlreadyVoted[msg.sender] == false, "You can't vote more than once!");
        Candidate storage c = candidatesList[index];
        
        votersAlreadyVoted[msg.sender] = true;
        c.votes++;
    }
    
    function declareWinner() public onlyCreator {
        require(candidateCount > 0, "Need to have candidates to declare winner!");
        uint maxVotesSeenTillNow = 0;
        
        uint winnerIndex=candidateCount+5;
        
        for(uint i=0; i< candidateCount;i++){
            if(candidatesList[i].votes > maxVotesSeenTillNow)
            { 
                maxVotesSeenTillNow = candidatesList[i].votes;
                winnerIndex = i;
            }
        }
        winner = candidatesList[winnerIndex].addr;
        emit WinnerIsDeclared(winner, candidatesList[winnerIndex].name);
        
    }
}