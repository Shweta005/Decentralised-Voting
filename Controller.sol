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
    
    
    function RegisterVoter(string memory _name, uint8 _age) initialised public {
        store.RegisterVoter(_name, _age);
    }
    
     function setVoterActive(address _add) initialised public{
         store.setVoterActive(_add);
     }
    
    function RegisterCandidate(string memory _cname) initialised public{
        store.RegisterCandidate(_cname);
    }
}