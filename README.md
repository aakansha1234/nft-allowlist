# Methods to create allowlists in smart contracts

Create a merkle tree of addresses is the popular way of opening access to NFT minting and ERC20 airdrops. However, that's not the only way. Since calldata is costly on rollups, Arbitrum for their airdrop created a mapping of addresses instead. Any address present in that mapping could claim the airdrop. This reduces calldata and reduces the gas cost on rollups.

There is a third way where a special address can create signatures for all the allowed addresses. The mint function can check the validity of the signature before minting `msg.sender` an NFT.

This scaffold-eth fork has three contracts each showing one of these methods:
- [**MerkleTree.sol**](./packages/hardhat/contracts/MerkleTree.sol)
- [**AddressMapping.sol**](./packages/hardhat/contracts/AddressMapping.sol)
- [**Signature.sol**](./packages/hardhat/contracts/Signature.sol)

## Requirements

Before you begin, you need to install the following tools:

- [Node (v18 LTS)](https://nodejs.org/en/download/)
- Yarn ([v1](https://classic.yarnpkg.com/en/docs/install/) or [v2+](https://yarnpkg.com/getting-started/install))

## Quickstart

To get started with Scaffold-ETH 2, follow the steps below:

1. Clone this repo & install dependencies

Run `yarn install`.

2. Run a local network in the first terminal:

```
yarn chain
```

This command starts a local Ethereum network using Hardhat. The network runs on your local machine and can be used for testing and development. You can customize the network configuration in `hardhat.config.ts`.

3. On a third terminal, start your NextJS app:

```
yarn start
```

Visit your app on: `http://localhost:3000`. You can interact with your smart contract using the contract component or the example ui in the frontend. You can tweak the app config in `packages/nextjs/scaffold.config.ts`.

Run smart contract test with `yarn hardhat:test`

- Edit your smart contract `YourContract.sol` in `packages/hardhat/contracts`
- Edit your frontend in `packages/nextjs/pages`
- Edit your deployment scripts in `packages/hardhat/deploy`

4. On a second terminal, deploy the test contract:
Copy the address from the localhost window and replace the address in `00_deploy_your_contract.ts`. Now run
```
yarn deploy
```

This command deploys a test smart contract to the local network. The contract is located in `packages/hardhat/contracts` and can be modified to suit your needs. The `yarn deploy` command uses the deploy script located in `packages/hardhat/deploy` to deploy the contract to the network. You can also customize the deploy script.

### Interacting with contracts

Open another window with localhost:3000 (in incognito mode to have a different wallet address).

The first window is the owner and the second window is the one which will perform minting.

There is a debug interface which can be used to call smart contracts. There is an additional page which can be used to generate signature. From the first window, just enter an address which you want to allow.