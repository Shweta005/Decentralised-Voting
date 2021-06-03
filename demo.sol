pragma solidity 0.8.0;

contract Storage{
    //Voter's Data
    struct Voter{
        string name;
        uint8  age;
        uint256 id;
        address vadd;
        bool isVoter;
        bool isActive;
        bool isVoted;
    }
    
    //Candidate's Data
    struct Candidate{
        string  name;
       
        uint256 cid;
        bool isCandidate;
        bool iscActive;
        address cadd;
        uint256 votes;
        bool isVoted;
    }
    uint256 public totalVotes;
    address public Owner;
    constructor(){
       Owner = msg.sender;
    }
    
    //counter variables
    uint256 public voterCounter;
    uint256 public candidateCounter;
    
    
    mapping(address =>Voter) public voter; //mapping for voter
    mapping(address=>Candidate) public  candidate;   //mapping for candidate
    
    
    //modifier to check that voter and candidates cannot register with same address
    modifier registered{
      require(msg.sender != candidate[msg.sender].cadd,"try another address ");  
        _;
    }
    
    //modifier to check voter is exist or not
     modifier checkVoter(){
    require(voter[msg.sender].id == 0,"Voter doesn't exist");
            _;
    }
    //modifier to check candidate is exist or not
    /* modifier checkCandidate(){
    require(candidate[msg.sender].cid != 0,"Candidate doesn't exist");
            _;
    }*/
    modifier onlyOwner(){
        require(msg.sender == Owner,"You dont have access");
        _;
    }
    
    
    //register voter
    function RegisterVoter(string memory _name, uint8 _age) registered  public  {
         require(msg.sender != Owner,"Its Owners Addres");
         require(msg.sender != voter[msg.sender].vadd,"Candidate registered with this address");
        voterCounter++;
        Voter memory vot;
        vot.id      = voterCounter; 
        vot.name    = _name;
        vot.age     = _age;
        vot.vadd    = msg.sender;
        vot.isVoter = true;
        voter[msg.sender] = vot;
    }
        
   //function to set voter active
    function setVoterActive(address _add) checkVoter onlyOwner public{
        require(voter[_add].age >= 18 ,"You age must be 18");
        voter[_add].isActive = true;
    }
    
        //register candidate
    function RegisterCandidate(string memory _cname) public{
        require(msg.sender != Owner,"Its Owners Addres");
        require(msg.sender != candidate[msg.sender].cadd,"Candidate registered with this address");
        candidateCounter++;
        Candidate memory can;
        can.cid         = candidateCounter;
        can.name        = _cname;
        can.cadd        = msg.sender;
        can.isCandidate = true;
        candidate[msg.sender] = can;
    }
    
    function Vote(address _cadd) public{
       totalVotes++;
       candidate[_cadd].votes += 1;
      if(voter[msg.sender].vadd== msg.sender){
         voter[msg.sender].isVoted = true; 
      }
       if(candidate[msg.sender].cadd==msg.sender){
           candidate[msg.sender].isVoted = true; 
       }
        }
        
        function checkVotesByName(string memory name)public {
            
        }
    
   
    
    
    
    
    
}