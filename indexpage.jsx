// App.js

import React, { useState } from 'react';
import './App.css';

function App() {
  const [nftListings, setNFTListings] = useState([]);
  const [seller, setSeller] = useState('');
  const [nftContract, setNFTContract] = useState('');
  const [tokenId, setTokenId] = useState('');
  const [price, setPrice] = useState('');

  const handleListingCreate = (e) => {
    e.preventDefault();
    // Add validation and listing creation logic here
    const newListing = {
      seller: seller,
      nftContract: nftContract,
      tokenId: tokenId,
      price: price
    };
    setNFTListings([...nftListings, newListing]);
    // Clear form fields
    setSeller('');
    setNFTContract('');
    setTokenId('');
    setPrice('');
  };

  const handlePurchase = (listingIndex) => {
    // Add purchase logic here
    console.log(`Purchased NFT at index ${listingIndex}`);
  };

  return (
    <div className="App">
      <h1>NFT Marketplace</h1>
      <form onSubmit={handleListingCreate}>
        <h2>Create NFT Listing</h2>
        <label>
          Seller:
          <input
            type="text"
            value={seller}
            onChange={(e) => setSeller(e.target.value)}
          />
        </label>
        <label>
          NFT Contract:
          <input
            type="text"
            value={nftContract}
            onChange={(e) => setNFTContract(e.target.value)}
          />
        </label>
        <label>
          Token ID:
          <input
            type="number"
            value={tokenId}
            onChange={(e) => setTokenId(e.target.value)}
          />
        </label>
        <label>
          Price:
          <input
            type="number"
            value={price}
            onChange={(e) => setPrice(e.target.value)}
          />
        </label>
        <button type="submit">Create Listing</button>
      </form>
      <h2>NFT Listings</h2>
      <ul>
        {nftListings.map((listing, index) => (
          <li key={index}>
            <div>Seller: {listing.seller}</div>
            <div>NFT Contract: {listing.nftContract}</div>
            <div>Token ID: {listing.tokenId}</div>
            <div>Price: {listing.price} BNB</div>
            <button onClick={() => handlePurchase(index)}>Purchase</button>
          </li>
        ))}
      </ul>
    </div>
  );
}

export default App;
