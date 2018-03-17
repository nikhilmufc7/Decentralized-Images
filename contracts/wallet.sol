pragma solidity ^0.4.18;

contract MyWallet{
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
    event imgBought(address indexed _by, address indexed _of, uint256 downloads_owner);

    uint256 img_ctr;
    uint256 proposal_ctr;
    
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
        uint256 m_downloads=downloads[author_add];
        m_downloads+=1;
        downloads[author_add]=m_downloads;
        if(author_add!=address(0)){
        return (author_add ); }// for direct pay
        else{
            revert();
        }
        
    }
     
    function get_total_images() public returns(uint256){
        return img_ctr;
    }
    function get_downloads() public returns(uint256){
        uint256 m_downloads=downloads[msg.sender];
        return m_downloads;
    }
    
    
    
    function() payable public {
        if (msg.value>0) {
            emit receivedFunds(msg.sender, msg.value);
        }
    }
}
