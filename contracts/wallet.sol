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
    
    struct proposal{
        address _from;
        address _to;
        uint256 _amount;
        bool sent;
    }
    
    mapping(uint256 => imgValue) imgCtr;
    mapping(address => uint256) imgCtr_author;
    mapping(address => uint256) downloads;
    mapping(string => address) author_photo;
    mapping(uint256 => proposal) m_proposals;
    event receivedFunds(address indexed _from,uint256 indexed _amount);
    event imgUploaded(address indexed _from,uint256 indexed _price, string indexed _hash);
    event proposalReceived(address indexed _from, address indexed _to, uint256 proposal_id);

    uint256 img_ctr;
    uint256 proposal_ctr;
    uint256 download_ctr;
    
    function MyWallet() public{
        creator=msg.sender;
    }
    function imgUpload(uint256 _price, string _hash) public returns(uint256){
       img_ctr+=1;
       imgCtr[img_ctr]=imgValue(msg.sender,_price,_hash);
       author_photo[_hash]=msg.sender;
       uint256 auth_count=imgCtr_author[msg.sender];
       auth_count+=1;
       imgCtr_author[msg.sender]=auth_count;
       emit imgUploaded(msg.sender,_price,_hash);
       return img_ctr;
    }
    
    function buyImage(string _hash) public returns(address){
        address author_add=author_photo[_hash];
        if(author_add!=address(0)){
        return (author_add ); }// for direct pay
        else{
            revert();
        }
        
    }
    function sendMoneyToAuthors(address _to, uint256 sales)public {
        
        
    } 
     
    function get_total_images() public returns(uint256){
        return img_ctr;
    }
    function get_downloads() public returns(uint256){
        return download_ctr;
    }
    
    function() payable public {
        if (msg.value>0) {
            emit receivedFunds(msg.sender, msg.value);
        }
    }
}
