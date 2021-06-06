pragma solidity ^0.8.0;

contract Storage{
    
    address public controller;
    
    struct Voter{
        string name;
        uint8 age;
        bool isVoter;
        bool isActive;
        bool isVoted;
    }
     
     struct Candidate{
        string name;
        uint256 votes;
       }
    
    uint256 public _voterCounter;
    uint256 public _canCounter;
    mapping(address => uint256) private _voterIds;
    mapping(uint256 => Voter) private _voters;
    
    mapping(address => uint256) private _canIds;
    mapping(uint256 => Candidate) private _cans;
    
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
    
    
    //Register Voter
    function registerVoter(string memory _name, uint8 _age, address _voter) onlyController initialised public {
        //require(msg.sender != controller,"Its Owner's Address");
        _voterCounter++;
        Voter memory voter = Voter(_name, _age,true,false,false);
        _voterIds[_voter] = _voterCounter;
        _voters[_voterCounter] = voter;
    }
    
    //updates voter's Name
    function updateName(string memory _newName, address _voter) onlyController initialised public {
        uint256 voterId = _voterIds[_voter];
        _voters[voterId].name = _newName;
    }
    
     //updates voter's Name
    function updateAge(uint8 _newAge, address _voter) onlyController initialised public {
        uint256 voterId = _voterIds[_voter];
        _voters[voterId].age = _newAge;
    }

    //get Voter's data
    function getVoter(address _voter) public initialised view returns(string memory name_, uint8 age_,bool  ,bool  ,bool) {
        uint256 voterId = _voterIds[_voter];
        return (_voters[voterId].name, _voters[voterId].age, _voters[voterId].isVoter, _voters[voterId].isActive, _voters[voterId].isVoted);
    }
    
    //get voter's ID
    function getVoterId(address _voter) public  initialised view returns(uint id_){
        return _voterIds[_voter];
    }
    
    function setVoterActive(address _voter) onlyController initialised public  {
        
          uint256 Id = _voterIds[_voter]; 
          require(_voters[Id].age >= 18 , "You must be 18 years old");
          _voters[Id].isActive = true;
    }
    
   
    
    //Candidate
    
    //Register Candidate
    function registerCandidate(string memory _name, address _canAdd) onlyController initialised public {
        // require(msg.sender != controller,"Its Owner's Address");
        _canCounter++;
        Candidate memory can = Candidate(_name, 0);
        _canIds[_canAdd] = _canCounter;
        _cans[_canCounter] = can;
    }
    
     //updates Candidate's Name
    function updateCName(string memory _newName, address _can) onlyController initialised public {
        uint256 canId = _canIds[_can];
        _cans[canId].name = _newName;
    }
    
    //get Candidate's data
    function getCandidate(address _can) public initialised view returns(string memory name_, uint256 _votes) {
        uint256 canId = _canIds[_can];
        return (_cans[canId].name,_cans[canId].votes);
    }
    
    
    
    
    
}