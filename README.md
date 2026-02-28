# 🔗 Avoid Counterfeiting Using Blockchain

![Solidity](https://img.shields.io/badge/Solidity-0.8.12-363636?style=for-the-badge&logo=solidity&logoColor=white)
![Ethereum](https://img.shields.io/badge/Ethereum-Blockchain-3C3C3D?style=for-the-badge&logo=ethereum&logoColor=white)
![Truffle](https://img.shields.io/badge/Truffle-Framework-5E464D?style=for-the-badge)
![JavaScript](https://img.shields.io/badge/JavaScript-Frontend-F7DF1E?style=for-the-badge&logo=javascript&logoColor=black)
![QR Code](https://img.shields.io/badge/QR--Code-Verification-009688?style=for-the-badge)


> MSc Cyber Security Dissertation Project — University of Southampton 🎓
> A decentralised product authentication system that uses Ethereum smart contracts and QR code scanning to detect and prevent counterfeit goods in supply chains.

---

## 📌 Overview

Counterfeit products cost the global economy **$4.5 trillion annually** and pose serious safety risks to consumers. Traditional centralised databases are vulnerable to tampering and single points of failure.

This project solves the problem using **blockchain immutability** — once a product is registered on the Ethereum network, its authenticity record cannot be altered or faked. Consumers scan a QR code to instantly verify if a product is genuine.

### Key Innovation
> By storing product provenance on a decentralised, tamper-proof ledger, this system eliminates the ability for counterfeiters to replicate or forge authentication records — even if they copy the physical product.

---

## 🏗️ System Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                        MANUFACTURER                         │
│  Registers product → Smart Contract → Unique ID + QR Code  │
└─────────────────────────┬───────────────────────────────────┘
                          │ Immutable record on Ethereum
                          ▼
┌─────────────────────────────────────────────────────────────┐
│                   ETHEREUM BLOCKCHAIN                        │
│         Smart Contract stores: Product ID, Timestamp,       │
│         Manufacturer address, Ownership history             │
└─────────────────────────┬───────────────────────────────────┘
                          │ QR Code scan
                          ▼
┌─────────────────────────────────────────────────────────────┐
│                       CONSUMER                              │
│   Scans QR Code → Web UI queries blockchain → GENUINE ✅   │
│                                             or FAKE ❌      │
└─────────────────────────────────────────────────────────────┘
```

---

## ✨ Features

- **Smart Contract Registration** — Manufacturers register products on Ethereum with tamper-proof records
- **QR Code Generation** — Each registered product gets a unique blockchain-linked QR code
- **QR Code Scanning** — Consumers scan via browser camera using html5-qrcode
- **Instant Verification** — Real-time blockchain query returns GENUINE or COUNTERFEIT status
- **Ownership Transfer** — Supply chain handoffs recorded immutably on-chain
- **Decentralised** — No central authority, no single point of failure or tampering

---

## 🛠️ Tech Stack

| Layer | Technology |
|---|---|
| Smart Contracts | Solidity 0.8.12 |
| Blockchain Framework | Truffle Suite |
| Local Blockchain | Ganache |
| Frontend | HTML5, JavaScript, Web3.js |
| QR Scanning | html5-qrcode |
| Dev Server | lite-server |
| Backend API | Node.js, Express, CORS |
| Database | PostgreSQL (pg) |
| Wallet Provider | @truffle/hdwallet-provider |

---

## 📋 Prerequisites

```bash
# Node.js (v16+ recommended)
node --version

# Truffle Suite
npm install -g truffle

# Ganache (Local Ethereum blockchain)
# Download GUI: https://trufflesuite.com/ganache/
# Or CLI:
npm install -g ganache
```

---

## 🚀 Installation & Setup

### 1. Clone the repository
```bash
git clone https://github.com/shubham8174/Avoid-Counterfeiting-Blockchain.git
cd Avoid-Counterfeiting-Blockchain
```

### 2. Install dependencies
```bash
npm install
```

### 3. Start local blockchain (Ganache)
```bash
# Option A — Ganache GUI
# Open Ganache, create new workspace, set port to 7545

# Option B — Ganache CLI
ganache --port 7545
```

### 4. Compile smart contracts
```bash
truffle compile
```

### 5. Deploy contracts to local blockchain
```bash
truffle migrate --reset
```

### 6. Start the web application
```bash
npm run dev
```

### 7. Open in browser
```
http://localhost:3000
```

---

## 📁 Project Structure

```
Avoid-Counterfeiting-Blockchain/
│
├── contracts/                    # Solidity smart contracts
│   ├── Migrations.sol
│   └── ProductAuthentication.sol # Core anti-counterfeiting contract
│
├── migrations/                   # Truffle deployment scripts
│   ├── 1_initial_migration.js
│   └── 2_deploy_contracts.js
│
├── webUI/                        # Frontend web application
│   ├── index.html                # Main UI
│   ├── manufacturer.html         # Product registration page
│   ├── consumer.html             # QR scan & verification page
│   ├── css/
│   └── js/
│       ├── app.js                # Web3.js integration
│       └── web3.min.js
│
├── build/contracts/              # Compiled contract ABIs (auto-generated)
│
├── test/                         # Smart contract test files
│
├── truffle-config.js             # Truffle network configuration
├── bs-config.json                # Lite-server configuration
├── package.json
└── README.md
```

---

## 🔐 Smart Contract Overview

The core `ProductAuthentication.sol` contract handles:

```solidity
// Key functions in the smart contract:

// Manufacturer registers a new product
function registerProduct(string memory productId, string memory productName) public

// Transfer ownership through supply chain
function transferOwnership(string memory productId, address newOwner) public

// Consumer verifies product authenticity
function verifyProduct(string memory productId) public view returns (bool, address, uint256)

// Check full ownership history
function getProductHistory(string memory productId) public view returns (address[] memory)
```

---

## 🔄 How It Works — Step by Step

**For Manufacturers:**
1. Connect MetaMask wallet to the application
2. Fill in product details (name, batch number, manufacturing date)
3. Click **"Register Product"** — transaction sent to Ethereum
4. Smart contract stores product data with manufacturer's wallet address
5. System generates a unique QR code linked to the blockchain record
6. QR code printed on physical product packaging

**For Consumers:**
1. Open the verification page on any browser
2. Click **"Scan QR Code"** and point camera at product
3. App decodes QR → queries Ethereum smart contract
4. Displays: ✅ **GENUINE** (with manufacturer details + history) or ❌ **COUNTERFEIT**

---

## 🧪 Running Tests

```bash
# Run all smart contract tests
truffle test

# Run specific test file
truffle test ./test/ProductAuthentication.test.js
```

---

## 🌐 Network Configuration

The project is configured for **local development** with Ganache:

```javascript
// truffle-config.js
development: {
  host: "127.0.0.1",
  port: 7545,
  network_id: "*"
}
```

For testnet deployment (Sepolia/Goerli), add your Infura project ID and wallet mnemonic to `.env`:

```bash
INFURA_PROJECT_ID=your_infura_id
MNEMONIC=your_twelve_word_phrase
```

> ⚠️ **Security Note:** Never commit `.secret` or `.env` files to GitHub. Add them to `.gitignore`.

---

## 🔒 Security Considerations

This project demonstrates several blockchain security principles:

- **Immutability** — Once registered, product records cannot be altered
- **Decentralisation** — No single point of failure or tamper risk
- **Cryptographic proof** — Each transaction signed by manufacturer's private key
- **Transparency** — Full audit trail of ownership history on-chain
- **Access control** — Only contract owner/manufacturer can register products

---

## 🎓 Academic Context

**Project:** MSc Cyber Security Dissertation
**University:** University of Southampton, United Kingdom
**Year:** 2022–2023
**Focus Areas:** Blockchain Security, Decentralised Systems, Supply Chain Security, Smart Contract Development

**Problem Statement:** Traditional anti-counterfeiting methods (holograms, serial numbers) are centralised and replicable. This project proposes blockchain as a fundamentally unforgeable alternative.

---

## 🔮 Future Enhancements

- [ ] Deploy to Ethereum Sepolia testnet
- [ ] Mobile app (React Native) for consumer scanning
- [ ] IPFS integration for storing product images
- [ ] Multi-manufacturer support with role-based access
- [ ] Integration with IoT sensors for cold chain tracking
- [ ] Zero-knowledge proofs for privacy-preserving verification

---

## 👤 Author

**Shubham Singh**
MSc Cyber Security — University of Southampton 🇬🇧
Information Security Analyst | Blockchain Developer | Smart Contract Security

[![LinkedIn](https://img.shields.io/badge/LinkedIn-Connect-0077B5?style=flat&logo=linkedin)](https://www.linkedin.com/in/shubham-singh99/)
[![GitHub](https://img.shields.io/badge/GitHub-Follow-181717?style=flat&logo=github)](https://github.com/shubham8174)


---

## 🙏 Acknowledgements

- University of Southampton — MSc Cyber Security Programme
- Truffle Suite — Ethereum development framework
- OpenZeppelin — Smart contract security standards reference
- Ethereum Foundation — Web3.js documentation
