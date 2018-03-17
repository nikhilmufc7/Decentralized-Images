pragma solidity ^0.4.18;

contract owned{
    address owner;
    modifier onlyowner(){
        if(msg.sender==owner){
            _;
        }
    }
    function owned() public{
        owner=msg.sender;
    }
}

contract mortal is owned {
    function kill() public{
        if(msg.sender==owner){
            selfdestruct(owner);
        }
    }
}


contract MyWallet is mortal {
    address creator;
    
    struct photographers{
        address add;
        uint256 ctr;
    }
    
    struct imgValue{
        address auth;
        uint256 price;
        string hash;
    }
    
    
    mapping(uint256 => imgValue) imgCtr_author;
    mapping(address => photographers) imgCtr;
    
    
    function MyWallet(){
        creator=msg.sender;
    }
    function imgUpload(address _from, uint256 _val, string _hash) public{
       
    }
    
    function buyImage(string _hash, address _from) public{
        
    }
    function sendMoneyToAuthors(address _to, uint256 sales){
        
    } 
    
    

    function() payable public {
        if (msg.value>0) {
            receivedFunds(msg.sender, msg.value);
        }
    }
}
