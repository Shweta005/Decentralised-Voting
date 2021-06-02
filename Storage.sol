pragma solidity 0.8.0;

contract Storage{
    
    struct Voter{
        string name;
        uint8  age;
        uint256 id;
        bool isActive;
    }
    
    struct Candidate{
        string  name;
        uint8   age;
        uint256 cid;
        
    }
    
    uint256 public voterCounter;
    uint256 public candidateCounter;
    
    mapping(uint256 =>Voter) public voter;
    mapping(uint256=>Candidate) public  candidate;
    
    function registerUser(string memory _name, uint8 _age) public  {
        voterCounter++;
        Voter memory vot;
        vot.id   = voterCounter; 
        vot.name = _name;
        vot.age  = _age;
        voter[voterCounter] = vot;
        }
        
        modifier checkVoter(){
            require(voter[voterCounter].id != 0,"Voter doesn't exist");
            _;
        }
       
        
    function voterActive(uint8 _id) checkVoter public{
        require(voter[_id].age >= 18 ,"You age must be 18");
        voter[_id].isActive = true;
        
    }
    
    
    
}