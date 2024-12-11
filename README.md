# Bagel Token and Merkle Airdrop Contracts

---

## Overview

This repository contains two Solidity contracts:
1. **Bagel Token** (`BagelToken.sol`) - A simple ERC20 token implementation with minting functionality restricted to the contract owner.
2. **Merkle Airdrop** (`MerkleAirdrop.sol`) - A contract enabling secure, verifiable token distribution using Merkle proofs and EIP-712 signature validation.

---

## Contracts

### Bagel Token (`BagelToken.sol`)

A basic ERC20 token implementation with the following features:
- **Name**: Bagel Token
- **Symbol**: BT
- **Owner-Controlled Minting**: The contract owner can mint new tokens using the `mint` function.

#### Key Functions
- `constructor()` - Initializes the ERC20 token.
- `mint(address to, uint256 amount)` - Allows the owner to mint tokens to a specific address.

---

### Merkle Airdrop (`MerkleAirdrop.sol`)

This contract facilitates airdropping tokens securely to eligible users by:
- Verifying eligibility using a Merkle proof.
- Ensuring each user can only claim their tokens once.
- Using EIP-712 for additional off-chain signature validation.

#### Key Features
- Merkle proof-based eligibility verification.
- Prevention of double claims.
- Secure transfer of tokens to eligible claimants.

#### Key Functions
- `claim(address account, uint256 amount, bytes32[] calldata merkleProof, uint8 v, bytes32 r, bytes32 s)`:
  - Verifies the Merkle proof and EIP-712 signature.
  - Transfers the claimed amount to the user if valid.
- `getMessage(address account, uint256 amount)`:
  - Returns the hashed message used for EIP-712 signature verification.
- `getMerkleRoot()`:
  - Returns the Merkle root used for eligibility checks.
- `getAirdropToken()`:
  - Returns the token used for the airdrop.

## Notes

- This repository is part of the **[Cyfrin Updraft Advanced Foundry Course](https://updraft.cyfrin.io/courses/advanced-foundry)**.

