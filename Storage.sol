pragma solidity 0.8.0;

contract Storage{
    
   
    address public controller;
    
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
        string  cname;
        uint256 cid;
        bool isCandidate;
        address cadd;
    }
    
    //counter variables
    uint256 public voterCounter;
    uint256 public candidateCounter;
    
    
    //mapping(address =>Voter) public voter; //mapping for voter
   // mapping(address=>Candidate) public  candidate;   //mapping for candidate
    
     mapping(uint256 =>Voter) public voter; //mapping for voter
    mapping(uint256 =>Candidate) public  candidate;   //mapping for candidate
    
      constructor (address _controller) {
        controller = _controller;
    }
    
    modifier onlyController() {
        require( msg.sender == controller, "Storage: controller function" );
        _;
    }
    
    modifier initialised() {
        require( controller != address(0), "Storage: contract not initialised" );
        _;
    }
    
    function setController(address _controller) initialised onlyController public {
        require(_controller != address(0), "Storage: controller cannot be zero address");
        controller = _controller;
    }
    
    
    
    //modifier to check that voter and candidates cannot register with same address
   /* modifier registered{
      require(msg.sender != candidate[candidateCounter].cadd,"try another address ");  
        _;
    }*/
    
   /*modifier notController{
      require(msg.sender != controller,"try another address ");  
        _;
    }*/
    
    //modifier to check voter is exist or not
     modifier checkVoter(){
    require(voter[voterCounter].id != 0,"Voter doesn't exist");
            _;
    }
    //modifier to check candidate is exist or not
     modifier checkCandidate(){
    require(candidate[candidateCounter].cid != 0,"Candidate doesn't exist");
            _;
    }
    
    
    //register voter
    function RegisterVoter(string memory _name, uint8 _age)   initialised  public  {
        require(msg.sender != candidate[candidateCounter].cadd,"Already registered by Candidate");  
        require(msg.sender != voter[voterCounter].vadd,"Alrady registered by Voter");
        voterCounter++;
        Voter memory vot;
        vot.id      = voterCounter; 
        vot.name    = _name;
        vot.age     = _age;
        vot.vadd    = msg.sender;
        vot.isVoter = true;
        voter[voterCounter] = vot;
        
      
    }
        
   //function to set voter active
    function setVoterActive(uint256 _id) checkVoter initialised public{
        require(voter[_id].age >= 18 ,"You age must be 18");
        voter[_id].isActive = true;
    }
    
        //register candidate
    function RegisterCandidate(string memory _cname)  initialised   public{
         require(msg.sender != candidate[candidateCounter].cadd,"Already registered by Candidate");  
        require(msg.sender != voter[voterCounter].vadd,"Alrady registered by Voter");
        candidateCounter++;
        Candidate memory can;
        can.cid         = candidateCounter;
        can.cname        = _cname;
        //can.age         = _cage;
           
        can.cadd        = msg.sender;
        can.isCandidate = true;
        candidate[candidateCounter] = can;
    }
    
    
    
    
}









/*//function to set voter active
    function setCandActive(address add) checkCandidate initialised public{
        require(candidate[add].age >= 18 ,"You age must be 18");
        candidate[add].iscActive = true;*/