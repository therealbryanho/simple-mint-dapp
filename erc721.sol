// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract FreeMintERC721 is ERC721Enumerable, Ownable {
    constructor(string memory _name, string memory _symbol) ERC721(_name, _symbol) {}

    // Mapping from tokenId to whether it has been minted
    mapping(uint256 => bool) private _mintedTokens;

    // Base URI for metadata (optional)
    string private _baseTokenURI;

    // Set the base URI for metadata
    function setBaseURI(string memory baseURI) external onlyOwner {
        _baseTokenURI = baseURI;
    }

    // Returns the base URI for metadata
    function _baseURI() internal view override returns (string memory) {
        return _baseTokenURI;
    }

    // Mint a new token for a given address
    function mint(address to) external onlyOwner {
        require(totalSupply() < type(uint256).max, "Max limit reached");
        uint256 tokenId = totalSupply() + 1;

        _mintedTokens[tokenId] = true;
        _mint(to, tokenId);
    }

    // Check if a token has been minted
    function isMinted(uint256 tokenId) external view returns (bool) {
        return _mintedTokens[tokenId];
    }
}
