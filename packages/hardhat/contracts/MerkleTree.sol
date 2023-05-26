//SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

// Use openzeppelin to inherit battle-tested implementations (ERC20, ERC721, etc)
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/cryptography/MerkleProof.sol";

/**
 * A smart contract that allows changing a state variable of the contract and tracking the changes
 * It also allows the owner to withdraw the Ether in the contract
 * @author aakansha1234
 */
contract MerkleTree is ERC721, Ownable {

    mapping(address => bool) public claimed;

    uint public tokenId;
    bytes32 public root;

    constructor(string memory name_, string memory symbol_, address owner_) ERC721(name_, symbol_) {
        transferOwnership(owner_);
    }

    function setRoot(bytes32 a) external onlyOwner {
        root = a;
    }

    function mint(bytes32[] memory proof) external {
        require(!claimed[msg.sender]);
        claimed[msg.sender] = true;
        bytes32 leaf = keccak256(abi.encodePacked(bytes32(bytes20(msg.sender))));

        require(MerkleProof.verify(proof, root, leaf));
        _mint(msg.sender, tokenId);
        tokenId++;
    }
}
