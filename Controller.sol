pragma solidity ^0.8.0;

import "./IStorage.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";

contract Controller is Ownable {
    
    IStorage public store;
    
    modifier initialised () {
        require( store != IStorage(address(0)), "Controller: storage not initialised" );
        _;
    }
    
    function setStorage(IStorage _storage) onlyOwner external {
        require(_storage != IStorage(address(0)), "Controller: storage cannot be zero");
        store = _storage;
    }
    
    function setNewController(address _newController) onlyOwner public {
        store.setController(_newController);
    }
    
    //Voter
    function registerVoter(string memory _name, uint8 _age) initialised public {
       
        store.registerVoter(_name, _age, msg.sender);
    }
    
    function updateName(string memory _newName) initialised public {
        store.updateName(_newName, msg.sender);
    }
    
    function updateAge(uint8 _newAge) initialised public {
         store.updateAge(_newAge, msg.sender);
    }
    
    function getVoter() initialised public view returns(string memory name_, uint8 age_) {
        string memory name;
        uint8 age;
        (name, age) = store.getVoter(msg.sender);
        return (name, age);
    }
    
    function getVoterId() initialised public view returns(uint256 id_){
        return store.getVoterId(msg.sender);
    }
    function setVoterActive(address _voter) initialised public  {
        store.setVoterActive(msg.sender);
    }
    
    //Candidate
     function registerCandidate(string memory _name) initialised public {
        store.registerCandidate(_name, msg.sender);
    }
    
     function updateCName(string memory _newName) initialised public {
        store.updateCName(_newName, msg.sender);
    }
      function getCandidate() initialised public view returns(string memory name_, uint256 votes_) {
        string memory name;
        uint256 votes;
        (name, votes) = store.getCandidate(msg.sender);
        return (name, votes);
    }
    
}