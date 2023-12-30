// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";

/**
 * @title GalacticCredits
 * @dev This contract implements a basic ERC20 token with additional features.
 */
contract GalacticCredits is ERC20, Ownable, AccessControl {
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");

    /**
     * @dev Initializes the contract by setting up the token name, symbol, and initial supply.
     * It also sets up the default admin role and minter role, both assigned to the contract deployer.
     */
    constructor() ERC20("Galactic Credits", "CRED") {
        uint256 tokenSupply = 250000000000 * 10**decimals(); // 250 billion tokens with decimals
        _mint(msg.sender, tokenSupply);

        _setupRole(DEFAULT_ADMIN_ROLE, msg.sender);
        _setupRole(MINTER_ROLE, msg.sender);
    }

    /**
     * @dev Allows the contract owner to renounce ownership, transferring ownership to address(0).
     * This action is irreversible and should be used with caution.
     */
    function renounceContractOwnership() external onlyOwner {
        // Renounce ownership by transferring ownership to address(0)
        transferOwnership(address(0));
    }

    /**
     * @dev Mint new tokens.
     * @param account The address to which new tokens will be minted.
     * @param amount The amount of tokens to mint.
     * Requirements:
     * - The caller must have the MINTER_ROLE.
     */
    function mint(address account, uint256 amount) external onlyRole(MINTER_ROLE) {
        _mint(account, amount);
    }

    /**
     * @dev Burn tokens.
     * @param amount The amount of tokens to burn.
     */
    function burn(uint256 amount) external {
        _burn(msg.sender, amount);
    }
}
