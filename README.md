# FarmToken: Decentralized NFT Marketplace on Stacks Blockchain

Welcome to **FarmToken**, a decentralized NFT marketplace built on the **Stacks blockchain**. FarmToken allows users to mint, buy, sell, and auction tokenized digital artwork (NFTs) in a secure, transparent, and decentralized environment. This README outlines the various smart contracts used to implement FarmToken and explains how they enable key features of the platform.

---

## Table of Contents

1. [Overview](#overview)
2. [Features](#features)
3. [Smart Contracts](#smart-contracts)

   * [NFT Minting Contract](#1-nft-minting-contract)
   * [Marketplace Listing Contract](#2-marketplace-listing-contract)
   * [Marketplace Buying Contract](#3-marketplace-buying-contract)
   * [Royalty Management Contract](#4-royalty-management-contract)
   * [Escrow Contract](#5-escrow-contract)
   * [Bid/Auction Contract](#6-bid-auction-contract)
   * [Verification and Security Contract](#7-verification-and-security-contract)
   * [User Profile Contract](#8-user-profile-contract)
   * [Admin/Governance Contract](#9-admin-governance-contract)
   * [Fee Collection Contract](#10-fee-collection-contract)
   * [Governance Voting Contract (Optional)](#11-governance-voting-contract-optional)
4. [Installation](#installation)
5. [Deployment](#deployment)
6. [Usage](#usage)
7. [Contributing](#contributing)
8. [License](#license)

---

## Overview

FarmToken is a decentralized NFT marketplace built on the **Stacks blockchain**, designed to empower creators, collectors, and investors in the world of digital art. By using **Clarity** smart contracts, FarmToken ensures secure and transparent interactions between users, where digital art can be minted, sold, and auctioned. With royalties for creators, secure transactions, and decentralized governance, FarmToken aims to revolutionize the NFT space.

---

## Features

* **Minting Digital Art**: Creators can mint their digital artworks as NFTs with associated metadata (e.g., title, description, image).
* **Buying and Selling**: Users can list, buy, and sell NFTs with a secure and transparent process using STX or other tokens.
* **Auctions**: Users can place bids on NFTs, and auctions are automatically concluded, with NFTs being transferred to the highest bidder.
* **Royalties for Creators**: Creators earn a royalty each time their NFT is resold on the platform.
* **Escrow Services**: Funds are held in escrow until the NFT is transferred, ensuring both parties fulfill their obligations.
* **User Profiles**: Users can create and manage profiles to track transactions, earnings, and activity.
* **Governance**: FarmToken is governed by decentralized voting to make platform-wide decisions.
* **Security**: Built-in verification systems ensure the legitimacy of creators, ownership of NFTs, and prevent fraud.

---

## Smart Contracts

The following **Clarity smart contracts** form the backbone of FarmToken. These contracts manage the core functionalities of the marketplace.

### 1. **NFT Minting Contract**

**Purpose:** To allow users to mint new NFTs (digital artworks) that can later be traded on the marketplace.

**Key Functions:**

* `mint-nft`: Mints a new NFT with metadata (title, description, image URL).
* `set-metadata`: Allows NFT creators to update metadata.
* `transfer`: Facilitates the transfer of NFT ownership to new owners.

### 2. **Marketplace Listing Contract**

**Purpose:** To enable users to list NFTs for sale on the decentralized marketplace.

**Key Functions:**

* `list-nft`: List an NFT for sale at a specified price.
* `delist-nft`: Remove an NFT from the marketplace.
* `get-listing`: Retrieve details about a specific NFT listing.
* `update-listing`: Update the price or other listing details.

### 3. **Marketplace Buying Contract**

**Purpose:** Handles the buying and selling of NFTs on the marketplace.

**Key Functions:**

* `buy-nft`: Handles the transaction when a user buys an NFT.
* `refund`: Facilitates refunds in case of a failed or invalid transaction.
* `get-nft-price`: Retrieve the price of an NFT listed on the marketplace.

### 4. **Royalty Management Contract**

**Purpose:** Ensures creators receive royalties each time their NFT is resold.

**Key Functions:**

* `set-royalty`: Allow creators to set a royalty percentage.
* `pay-royalty`: Automatically transfers royalties to the creator on resale.
* `get-royalty`: Retrieve the royalty percentage for an NFT.

### 5. **Escrow Contract**

**Purpose:** Holds funds in escrow during the transaction process to ensure secure transfers.

**Key Functions:**

* `hold-funds`: Holds the buyer’s funds until the NFT is transferred.
* `release-funds`: Release the funds to the seller after successful transfer.
* `cancel-escrow`: Cancel the transaction and refund the buyer if the transaction fails.

### 6. **Bid/Auction Contract**

**Purpose:** Enables users to place bids on NFTs in an auction-style marketplace.

**Key Functions:**

* `start-auction`: Start an auction for an NFT.
* `place-bid`: Place a bid on an auction.
* `end-auction`: End the auction and transfer the NFT to the highest bidder.
* `get-highest-bid`: Retrieve the highest bid for an ongoing auction.

### 7. **Verification and Security Contract**

**Purpose:** Ensures only verified creators can mint and trade NFTs, and ensures NFTs are legitimate.

**Key Functions:**

* `is-verified-creator`: Checks if a user is a verified creator.
* `check-nft-ownership`: Verifies ownership of an NFT before listing.
* `audit-nft`: Audits the NFT metadata to prevent fraud.

### 8. **User Profile Contract**

**Purpose:** Manages user profiles and transaction histories on the platform.

**Key Functions:**

* `create-profile`: Allows a user to create a profile.
* `update-profile`: Update a user’s profile information.
* `get-profile`: Retrieve a user’s profile details.

### 9. **Admin/Governance Contract**

**Purpose:** Administer platform governance and operations.

**Key Functions:**

* `set-fee`: Set platform transaction fees.
* `update-policies`: Modify marketplace rules or policies.
* `admin-override`: Allow admins to intervene in case of issues.

### 10. **Fee Collection Contract**

**Purpose:** Collect transaction fees from each sale, listing, and purchase.

**Key Functions:**

* `collect-fee`: Collect platform fees from sales and listings.
* `set-fee-percentage`: Define the transaction fee percentage.

### 11. **Governance Voting Contract (Optional)**

**Purpose:** Enables platform governance through decentralized voting.

**Key Functions:**

* `submit-proposal`: Submit a governance proposal.
* `vote`: Cast votes on platform proposals.
* `execute-vote`: Execute a proposal once it has passed.

---

## Installation

To deploy FarmToken, you will need to set up a development environment with the following tools:

1. **Stacks CLI**: Command-line tool for interacting with the Stacks blockchain.
2. **Clarity Language**: The smart contract language used to write FarmToken’s contracts.
3. **Stacks Testnet**: For testing the deployment of the smart contracts before going live.
4. **Node.js**: For running scripts and managing the application.

### Prerequisites

```bash
# Install Stacks CLI
curl -fsSL https://stacks.co/install.sh | bash

# Install Node.js (if not already installed)
sudo apt install nodejs

# Install npm (if not already installed)
sudo apt install npm
```

---

## Deployment

### Deploying Smart Contracts

1. Write your Clarity smart contracts in a `.clar` file.
2. Use the Stacks CLI to deploy the contracts to the Stacks Testnet or Mainnet.

   ```bash
   stacks deploy contract <contract-file> --network testnet
   ```

### Deploying the Application

FarmToken’s frontend can be deployed using traditional web deployment methods (e.g., on a static web host, such as GitHub Pages, Vercel, or Netlify). Ensure the frontend interacts with the smart contracts via the Stacks.js library to perform actions like minting, listing, and buying NFTs.

---

## Usage

Once deployed, users can interact with FarmToken’s frontend to:

* **Mint NFTs**: Upload digital artwork and mint NFTs.
* **List NFTs for Sale**: Set prices and list NFTs on the marketplace.
* **Buy and Sell NFTs**: Engage in direct purchases and trades of NFTs.
* **Place Bids**: Participate in NFT auctions.
* **Track Royalties**: Creators automatically receive royalties on resales.
* **Create Profiles**: Users can create and manage their profiles.
* **Governance**: Participate in voting on platform-wide proposals.

---

## Contributing

We welcome contributions to FarmToken! To contribute:

1. Fork the repository.
2. Create a new branch (`git checkout -b feature-name`).
3. Commit your changes (`git commit -am 'Add new feature'`).
4. Push to the branch (`git push origin feature-name`).
5. Create a new Pull Request.

---

## License

FarmToken is licensed under the **MIT License**. See [LICENSE](LICENSE) for more details.

