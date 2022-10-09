// SPDX-License-Identifier: MIT

pragma solidity >0.4.23 <0.9.0;

import "./NFTCollection.sol";

contract NFTgen {
    NFTCollection[] public nftCollections;
    uint256 collectionsAmount;

    constructor() {}

    function createCollection(
        string memory collectionName,
        string memory collectionSymbol,
        uint256 maxAmount,
        string memory metadataBaseURI
    ) public {
        NFTCollection nftCollection = new NFTCollection(
            collectionName,
            collectionSymbol,
            maxAmount,
            metadataBaseURI
        );

        nftCollections.push(nftCollection);
        collectionsAmount++;
    }
}
