pragma solidity ^0.8.0;

interface IStorage {
    function registerVoter(string memory _name, uint8 _age, address _voter) external;
    function registerCandidate(string memory _name,address _can) external;
    function updateName(string memory _name, address _voter) external;
    function updateCName(string memory _name, address _can) external;
    function updateAge(uint8 _age, address _voter) external;
    function setController(address _controller) external;
    
    function setVoterActive(address _voter)external;
    function getVoter(address _voter) external view returns(string memory name_, uint8 age_);
    function getVoterId(address _voter) external view returns(uint256 id_);
     function getCandidate(address _can) external view returns(string memory name_, uint256 votes_);
  
    
}