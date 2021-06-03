pragma solidity 0.8.0;

interface IStorage{
    
    function RegisterVoter(string memory _name, uint8 _age) external;
    function setVoterActive(address _add) external;
    function RegisterCandidate(string memory _cname) external;
     function setController(address _controller) external;
}