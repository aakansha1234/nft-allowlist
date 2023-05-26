//SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

// Use openzeppelin to inherit battle-tested implementations (ERC20, ERC721, etc)
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

/**
 * A smart contract that allows changing a state variable of the contract and tracking the changes
 * It also allows the owner to withdraw the Ether in the contract
 * @author aakansha1234
 */
contract AddressMapping is ERC721, Ownable {

    mapping(address => bool) public allowed;
    mapping(address => bool) public claimed;

    uint public tokenId;

    constructor(string memory name_, string memory symbol_, address owner_) ERC721(name_, symbol_) {
        transferOwnership(owner_);
    }

    function addToAllowed(address[] calldata a) external onlyOwner {
        for (uint i=0; i < a.length; i++) {
            allowed[a[i]] = true;
        }
    }

    function mint() external {
        require(allowed[msg.sender] && !claimed[msg.sender]);
        claimed[msg.sender] = true;
        _mint(msg.sender, tokenId);
        tokenId++;
    }
}
