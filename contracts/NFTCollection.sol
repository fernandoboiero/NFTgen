// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract NFTCollection is ERC721 {
    using Counters for Counters.Counter;

    Counters.Counter private _tokenIdCounter;

    uint256 private _maxAmount;
    string private _metadataBaseURI;

    constructor(
        string memory collectionName,
        string memory collectionSymbol,
        uint256 maxAmount,
        string memory metadataBaseURI
    ) ERC721(collectionName, collectionSymbol) {
        _tokenIdCounter.increment();
        _maxAmount = maxAmount;
        _metadataBaseURI = metadataBaseURI;
    }

    function _baseURI() internal view override returns (string memory) {
        return _metadataBaseURI;
    }

    function safeMint(address to) public {
        uint256 tokenId = _tokenIdCounter.current();

        require(tokenId <= _maxAmount, "Max amount of NFTs reached.");

        _tokenIdCounter.increment();
        _safeMint(to, tokenId);
    }
}
