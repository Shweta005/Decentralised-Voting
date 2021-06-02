pragma solidity 0.8.0;

contract Storage{
    
    struct Voter{
        string name;
        uint8  age;
        uint256 id;
        address vadd;
        bool isVoter;
        bool isActive;
    }
    
    struct Candidate{
        string  name;
        uint8   age;
        uint256 cid;
        bool isCandidate;
        bool iscActive;
        address cadd;
    }
    
    uint256 public voterCounter;
    uint256 public candidateCounter;
    
    mapping(address =>Voter) public voter;
    mapping(address=>Candidate) public  candidate;
    
    /* modifier registered(address add){
      require(msg.sender != candidate[add].cadd," ");  
        _;
    }*/
    
    function registerVoter(string memory _name, uint8 _age)   public  {
        voterCounter++;
        Voter memory vot;
        vot.id      = voterCounter; 
        vot.name    = _name;
        vot.age     = _age;
        vot.vadd    = msg.sender;
        vot.isVoter = true;
        voter[msg.sender] = vot;
    }
        
    modifier checkVoter(){
    require(voter[msg.sender].id != 0,"Voter doesn't exist");
            _;
    }
    
 
    function setVoterActive(address _add) checkVoter public{
        require(voter[_add].age >= 18 ,"You age must be 18");
        voter[_add].isActive = true;
        
    }
    
    function registerCandidate(string memory _cname, uint8 _cage) public{
        candidateCounter++;
        Candidate memory can;
        can.cid         = candidateCounter;
        can.name        = _cname;
        can.age         = _cage;
        can.cadd        = msg.sender;
        can.isCandidate = true;
        candidate[msg.sender] = can;
    }
    function setCandActive(address _add) checkVoter public{
        require(candidate[_add].age >= 18 ,"You age must be 18");
        candidate[_add].iscActive = true;
    }
    
    
    
    
    
}