pragma solidity ^0.5.3;
contract voting {
    address public contractowner;
    address[] public candidatelist;
    mapping (address=>uint8) public voterecieved;
    address public winner;
    uint public winnervotes;
    constructor() public{
        contractowner=msg.sender;
    }
    modifier onlyowner{
        if(msg.sender == contractowner)
        {
            _;
        }
    }

    function registerCandidate(address _candidate)onlyowner public
    {
        candidatelist.push(_candidate);
    }
    function vote(address _candidate)public{
        require (validcandidate(_candidate),"Not a valid candidate");
        voterecieved[_candidate]+=1;
    }
    function validcandidate(address _candidate) view public returns(bool){
        for(uint i=0;i<candidatelist.length;i++)
        {
            if(candidatelist[i] == _candidate)
                return true;
        }return false;
    } 
    function votescount(address _candidate)public view returns(uint){
         require (validcandidate(_candidate),"Not a valid candidate");
         return voterecieved[_candidate];
    }
    function result() public{
         for(uint i=0;i<candidatelist.length;i++)
         {
             if(voterecieved[candidatelist[i]]>winnervotes)
             {
                 winnervotes=voterecieved[candidatelist[i]];
                 winner=candidatelist[i];
             }
         }
    }
}
