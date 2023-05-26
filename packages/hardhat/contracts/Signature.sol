//SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

// Use openzeppelin to inherit battle-tested implementations (ERC20, ERC721, etc)
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/cryptography/ECDSA.sol";
import "hardhat/console.sol";


/**
 * A smart contract that allows changing a state variable of the contract and tracking the changes
 * It also allows the owner to withdraw the Ether in the contract
 * @author aakansha1234
 */
contract Signature is ERC721, Ownable {

    mapping(address => bool) public claimed;

    uint public tokenId;
    address public signer;

    constructor(string memory name_, string memory symbol_, address owner_) ERC721(name_, symbol_) {
        transferOwnership(owner_);
    }

    function setSigner(address a) external onlyOwner {
        signer = a;
    }

    function mint(bytes memory signature) external {
        require(!claimed[msg.sender]);
        claimed[msg.sender] = true;

        bytes32 hash = keccak256(abi.encodePacked("\x19Ethereum Signed Message:\n20", msg.sender));
        require(ECDSA.recover(hash, signature) == signer);

        _mint(msg.sender, tokenId);
        tokenId++;
    }
}
