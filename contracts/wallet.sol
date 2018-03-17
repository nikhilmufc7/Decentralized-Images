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
    
    
    mapping(uint256 => imgValue) imgCtr;
    mapping(address => photographers) imgCtr_author;
    mapping(string => address) author_photo;
    event receivedFunds(address indexed _from,uint256 indexed _amount);
    event imgUploaded(address indexed _from,uint256 indexed _price, string indexed _hash);
    uint256 img_ctr;
    function MyWallet() public{
        creator=msg.sender;
    }
    function imgUpload(address _from, uint256 _price, string _hash) public returns(uint256){
       img_ctr+=1;
       imgCtr[img_ctr]=imgValue(_from,_price,_hash);
       author_photo[_hash]=_from;
       emit imgUploaded(_from,_price,_hash);
       return img_ctr;
    }
    
    function buyImage(string _hash) public returns(address,uint256){
        address author_add=author_photo[_hash];
        return (author_add,);
        
    }
    function sendMoneyToAuthors(address _to, uint256 sales)public {
        
        
    } 
    
    

    function() payable public {
        if (msg.value>0) {
            receivedFunds(msg.sender, msg.value);
        }
    }
}
