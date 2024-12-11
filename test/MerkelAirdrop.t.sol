// SPDX-License-Identifier: MIT
pragma solidity 0.8.28;

import {MerkleAirdrop} from "../src/MerkleAirdrop.sol";
import {IERC20, SafeERC20} from "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";   
import {MerkleProof} from "@openzeppelin/contracts/utils/cryptography/MerkleProof.sol";
import {Test, console} from "forge-std/Test.sol";
import {BagelToken} from "../src/BagelToken.sol";

contract MerkleAirdropTest is Test {

    MerkleAirdrop public airdrop;
    BagelToken public token;

    bytes32 public ROOT = 0xaa5d581231e596618465a56aa0f5870ba6e20785fe436d5bfb82b08662ccc7c4;
    uint256 public amounttoClaim = 25 * 1e18;
    bytes32[] public proof = [
            bytes32(0x0fd7c981d39bece61f7499702bf59b3114a90e66b51ba2c53abdf7b62986c00a),
            bytes32(0xe5ebd1e1b5a5478a944ecab36a9a954ac3b6b8216875f6524caa7a1d87096576)
        ];
    uint256 public AMOUNT_TO_SEND = 100 * 1e18;

    address user;
    address public gasPayer;
    uint256 userPrivKey;

    function setUp() public {
        token = new BagelToken();
        airdrop = new MerkleAirdrop(ROOT, token);
        token.mint(token.owner(), AMOUNT_TO_SEND);
        token.transfer(address(airdrop), AMOUNT_TO_SEND);
        console.log("airdrop", token.balanceOf(address(airdrop)));
        (user, userPrivKey) = makeAddrAndKey("user");
        gasPayer = makeAddr("gasPayer");
    }

    function testUsersCanClaim() public {
        console.log("user", user);
        uint256 startingbalance = token.balanceOf(user);
        console.log("startingbalance", startingbalance);

        vm.startPrank(user);
        bytes32 message = airdrop.getMessage(user, amounttoClaim);
        (uint8 v, bytes32 r, bytes32 s) = vm.sign(userPrivKey, message);
        vm.stopPrank();

        vm.prank(gasPayer);
        airdrop.claim(user, amounttoClaim, proof, v, r, s);

        uint256 endingbalance = token.balanceOf(user);
        console.log("endingbalance", endingbalance);

        assertEq(endingbalance, startingbalance + amounttoClaim);
       
    }

}