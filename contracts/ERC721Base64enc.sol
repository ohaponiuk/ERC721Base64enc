// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "base64-sol/base64.sol";

/**
 * @dev ERC721 token with token URI encoded in base64.
 * The basic idea is that you have a struct with your data (showed in a description) and image as a link to IPFS. You have an array/mapping of these structs.
 * Token owner can change the data and it will accordingly change in description on the OpenSea. (You have to refresh the metadata on OpenSea.)
 */

 contract ERC721Base64enc is ERC721 {

     // Example struct
     struct Data {
         string data1;
         string data2;
         string linkToImage;
     }

     Data[] private _tokenURIs;

     constructor(string memory name_, string memory symbol_) ERC721(name_, symbol_) {}

     function tokenURI(uint256 tokenId) public view virtual override returns (string memory) {
        require(_exists(tokenId), "ERC721Base64enc: URI query for nonexistent token");
        return
            string(
                abi.encodePacked(
                    "data:application/json;base64, ",
                    Base64.encode(
                        bytes(
                            abi.encodePacked(
                                '{"name":"',
                                name(),
                                '", "description":"',
                                _tokenURIs[tokenId].data1,
                                '\\n\\n',
                                _tokenURIs[tokenId].data2,
                                '", "image": "',
                                _tokenURIs[tokenId].linkToImage,
                                '"}'
                            )
                        )
                    )
                )
            );
     }

     function changeDescription(uint256 tokenId, string memory _data1, string memory _data2) public {
         require(_isApprovedOrOwner(_msgSender(), tokenId), "ERC721Base64enc: change description caller is not owner nor approved");
         _tokenURIs[tokenId].data1 = _data1;
         _tokenURIs[tokenId].data2 = _data2;
     }

     function mint(string memory _data1, string memory _data2, string memory _linkToImage) public {
         Data memory newData = Data({
            data1: _data1,
            data2: _data2,
            linkToImage: _linkToImage
        });
        _tokenURIs.push(newData);
        _safeMint(_msgSender(), _tokenURIs.length - 1);
     }

     function burn(uint256 tokenId) public {
        require(_exists(tokenId), "ERC721Base64enc: burn query for nonexistent token");
        require(_isApprovedOrOwner(_msgSender(), tokenId), "ERC721Base64enc: burn caller is not owner nor approved");

        super._burn(tokenId);

        if (bytes(_tokenURIs[tokenId].linkToImage).length != 0) {
            delete _tokenURIs[tokenId];
        }
    }
 }