// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "hardhat/console.sol";
import "./Base64.sol";

contract horoscopeNFT is ERC721URIStorage {
  using Counters for Counters.Counter;
  Counters.Counter private _tokenIds;

  string baseSvg = '<svg width="350" height="350" xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="xMinYMin meet"><g><rect id="background" fill="black" height="100%" width="100%"/><text id="word-bg-1" font-size="200px" font-family="serif" fill="#111111" text-anchor="middle" dominant-baseline="middle" class="base" y="50%" x="50%">//////////////////////////</text><text id="word-bg-2" font-size="200px" font-family="serif" fill="#222222" text-anchor="top" dominant-baseline="top" class="base" y="5%" x="-20%">//////////////////////////</text><text id="word-bg-3" font-size="200px" font-family="serif" fill="#222222" text-anchor="bottom" dominant-baseline="bottom" class="base" y="120%" x="-50%">//////////////////////////</text><text id="word" font-size="30px" font-family="sans" font-weight="bold" fill="white" text-anchor="middle" dominant-baseline="middle" class="base" y="50%" x="50%">';

  constructor() ERC721("Horoscope", "HSCP") {}

  function mintNFT(address recipient, string memory zodiacSign)
  public returns (uint256) {
    _tokenIds.increment();

    string memory finalSvg = string(
      abi.encodePacked(baseSvg, zodiacSign, '</text></g></svg>')
    );

    string memory json = Base64.encode(
      bytes(
        string(
          abi.encodePacked(
              '{"name": "',zodiacSign,
              '", "description": "On-chain Zodiac Sign NFTs", "attributes": [{"trait_type": "Zodiac Sign", "value": "',
              zodiacSign, '"}], "image": "data:image/svg+xml;base64,', Base64.encode(bytes(finalSvg)), '"}'
          )
        )
      )
    );

    string memory finalTokenUri = string(
      abi.encodePacked("data:application/json;base64,", json)
    );

    uint256 newItemId = _tokenIds.current();
    _mint(recipient, newItemId);
    _setTokenURI(newItemId, zodiacSign);

    return newItemId;
  }
}