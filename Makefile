-include .env

build:; forge build
test:; forge test

DEFAULT_ANVIL_KEY := 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80
DEFAULT_ANVIL_KEY_2 := 0x59c6995e998f97a5a0044966f0945389dc9e86dae88c7a8412f4603b6b78690d
DEFAULT_ANVIL_ADDRESS := 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266

SIGNER := 0x39430e4990aa8a1f7d056d9a5f611eb27f8280425efbf03634690a02f26b957a

NETWORK_ARGS := --rpc-url http://127.0.0.1:8545 --private-key $(DEFAULT_ANVIL_KEY) 

SIGNATURE := 12e145324b60cd4d302bfad59f72946d45ffad8b9fd608e672fd7f02029de7c438cfa0b8251ea803f361522da811406d441df04ee99c3dc7d65f8550e12be2ca1c

deploy:
	@forge script script/DeployMerkleAirdrop.s.sol:DeployMerkleAirdrop $(NETWORK_ARGS) --broadcast

claim:
	forge script script/Interact.s.sol:ClaimAirdrop --rpc-url http://127.0.0.1:8545 --private-key $(DEFAULT_ANVIL_KEY_2) --broadcast

call-message-anvil:
	cast call 0x59b670e9fA9D0A427751Af201D676719a970857b "getMessage(address,uint256)" $(DEFAULT_ANVIL_ADDRESS) 25000000000000000000 --rpc-url http://127.0.0.1:8545

wallet-sign-anvil:
	cast wallet sign --no-hash 0x4ee8224141f37b30f457fc2da2f446ddfb22f51c45e3239a49119e337f50066b --private-key $(DEFAULT_ANVIL_KEY) 


deploy-sepolia-test:
	forge script script/DeployBasicNFT.s.sol:DeployBasicNFT --rpc-url ${SEPOLIA_RPC_URL} --account MetaMaskTestAcc --sender ${MetaMaskTestAccPubKey} --broadcast --verify --etherscan-api-key ${ETHERSCAN_API_KEY} -vvvv

deploy-base-sepolia-test:
	forge script script/DeployBasicNFT.s.sol:DeployBasicNFT --rpc-url ${BASE_SEP_RPC_URL} --account MetaMaskTestAcc --sender ${MetaMaskTestAccPubKey} --broadcast -vvvv

mint-sepolia-test:
	forge script script/Interactions.s.sol:MintBasicNFT --rpc-url ${SEPOLIA_RPC_URL} --account MetaMaskTestAcc --sender ${MetaMaskTestAccPubKey} --broadcast --verify --etherscan-api-key ${ETHERSCAN_API_KEY} -vvvv

mint-base-sepolia-test:
	forge script script/Interactions.s.sol:MintBasicNFT --rpc-url ${BASE_SEP_RPC_URL} --account MetaMaskTestAcc --sender ${MetaMaskTestAccPubKey} --broadcast -vvvv

deploy-moodnft-sepolia-test:
	forge script script/DeployMoodNFT.s.sol:DeployMoodNFT --rpc-url ${SEPOLIA_RPC_URL} --account MetaMaskTestAcc --sender ${MetaMaskTestAccPubKey} --broadcast --verify --etherscan-api-key ${ETHERSCAN_API_KEY} -vvvv

mint-mood:
	cast send 0x93B704111e0A2cd481fd35222c27DcCcFC3eA63b "mintNFT()" --rpc-url ${SEPOLIA_RPC_URL} --account MetaMaskTestAcc

deploy-moodnft-base-sepolia-test:
	forge script script/DeployMoodNFT.s.sol:DeployMoodNFT --rpc-url ${BASE_SEP_RPC_URL} --account MetaMaskTestAcc --sender ${MetaMaskTestAccPubKey} --broadcast --verify --etherscan-api-key ${ETHERSCAN_API_KEY} -vvvv

mint-mood-base:
	cast send 0x2f7F8Bf54F99f16b4622b1d322FFe96e4F3A3615 "mintNFT()" --rpc-url ${BASE_SEP_RPC_URL} --account MetaMaskTestAcc
