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
    }
    
    //Candidate's Data
    struct Candidate{
        string  name;
        uint8   age;
        uint256 cid;
        bool isCandidate;
        bool iscActive;
        address cadd;
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
    require(voter[msg.sender].id != 0,"Voter doesn't exist");
            _;
    }
    //modifier to check candidate is exist or not
     modifier checkCandidate(){
    require(candidate[msg.sender].cid != 0,"Candidate doesn't exist");
            _;
    }
    
    
    //register voter
    function RegisterVoter(string memory _name, uint8 _age) registered  public  {
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
    function setVoterActive(address _add) checkVoter public{
        require(voter[_add].age >= 18 ,"You age must be 18");
        voter[_add].isActive = true;
    }
    
        //register candidate
    function RegisterCandidate(string memory _cname, uint8 _cage) public{
        candidateCounter++;
        Candidate memory can;
        can.cid         = candidateCounter;
        can.name        = _cname;
        can.age         = _cage;
        can.cadd        = msg.sender;
        can.isCandidate = true;
        candidate[msg.sender] = can;
    }
    
    //function to set voter active
    function setCandActive(address add) checkCandidate  public{
        require(candidate[add].age >= 18 ,"You age must be 18");
        candidate[add].iscActive = true;
    }
    
    
    
    
    
}