// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/IERC721Enumerable.sol"; // Update import statement

contract NFTMarketplace {
    address public owner;

    struct Listing {
        address seller;
        address nftContract;
        uint256 tokenId;
        uint256 price;
    }

    Listing[] public listings;

    event ListingCreated(
        address indexed seller,
        address indexed nftContract,
        uint256 indexed tokenId,
        uint256 price
    );

    event ListingSold(
        address indexed seller,
        address indexed buyer,
        address indexed nftContract,
        uint256 tokenId,
        uint256 price
    );

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can perform this action");
        _;
    }

    function createListing(
        address _nftContract,
        uint256 _tokenId,
        uint256 _price
    ) external {
        IERC721Enumerable nft = IERC721Enumerable(_nftContract); // Update interface
        require(
            nft.ownerOf(_tokenId) == msg.sender,
            "You must own the NFT to create a listing"
        );
        nft.transferFrom(msg.sender, address(this), _tokenId);
        listings.push(
            Listing({
                seller: msg.sender,
                nftContract: _nftContract,
                tokenId: _tokenId,
                price: _price
            })
        );
        emit ListingCreated(msg.sender, _nftContract, _tokenId, _price);
    }

    function buyListing(uint256 _listingIndex) external payable {
        require(
            _listingIndex < listings.length,
            "Invalid listing index provided"
        );
        Listing memory listing = listings[_listingIndex];
        require(
            msg.value >= listing.price,
            "Insufficient funds to buy the listing"
        );
        IERC721Enumerable nft = IERC721Enumerable(listing.nftContract); // Update interface
        nft.transferFrom(address(this), msg.sender, listing.tokenId);
        payable(listing.seller).transfer(listing.price);
        emit ListingSold(
            listing.seller,
            msg.sender,
            listing.nftContract,
            listing.tokenId,
            listing.price
        );
    }

    function withdrawFunds() external onlyOwner {
        payable(owner).transfer(address(this).balance);
    }
}
