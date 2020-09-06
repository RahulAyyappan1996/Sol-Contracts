pragma solidity ^0.5.0;

contract One
{
    string private stateVariable = "This is sample solidity program";
    function SampleOne() public view returns (string memory) {
        return stateVariable;
    }
}
