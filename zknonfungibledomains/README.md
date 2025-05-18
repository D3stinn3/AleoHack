# 🔐 ZK NonFungibleDomains (ZKNFD)

ZKNFD is a privacy-preserving domain credentialing protocol on the Aleo blockchain. It issues **zero-knowledge NFTs** to prove domain ownership — **without ever revealing the domain name** publicly. These NFTs are fully private, soulbound, and verifiable using ZPass-style Merkle proofs.

---

## 🚀 Live Deployment

- **Program ID:** `zknonfungibledomains_v1.aleo`
- **Address:** `aleo1le9uklfd948egtdjuyra8afh85gu5n7xx3g7k7tpwe3gyhcc6cqsdjzgky`
- **Deployment TX:** `at1tt4q0c0fzupe600dv5vpp44gttxl3le748mhavfnehmcp8gshq8smu9cq4`

---

## 🧠 Inspiration

The rise of decentralized identity always clashed with one major concern: **privacy**. Most domain and identity systems expose on-chain metadata and wallet links.

This project asks:

> **"Can we prove domain ownership *without revealing the domain name itself*?"**

And answers it with: **ZKNFD** — a zk-native identity system that bridges domains, ZKPass, and NFTs.

---

## ✅ What it Does

ZKNFD lets domain owners mint **soulbound NFTs** that prove domain control privately.

- Mints NFTs with **private owner + private data**.
- Verifies domain credentials via **Merkle root + signature**.
- **No domain string, wallet address, or metadata is leaked**.

### 🔗 Built on:
- ✅ `ARC-721 NFT Standard` (private NFTs + public commitments)
- ✅ `ZPass SDK` (Merkle root signature system)
- ✅ `Aleo` for private computation and zero-knowledge proof verification

---

## 🛠 How We Built It

### 🔧 Smart Contract Components

- **`issue_domain_credential(...)`**  
  - Accepts a ZPass signature + domain hash → issues a private NFT + verifiable root.

- **`verify_domain_credential(...)`**  
  - Confirms that a leaf (e.g., domain_hash or owner_hash) is part of a Merkle credential.

---

## 🔐 Privacy Architecture

- 🧱 NFT `CredentialNFT` is a private record: owner, metadata, edition.
- 🔏 Data is committed using `BHP256::commit_to_field(...)`.
- 🌐 Public commitment is stored in `nft_commits`; ownership optional via `nft_owners`.

---

## 🧩 Real-World Use Cases

### 1. 🗳️ Private DAO Voting
- Verify member identity based on domain ownership
- Keep identities and domains fully private

### 2. 👤 Web3 Onboarding
- Mint a domain credential badge as a KYC proxy
- Use `attest_access()` to grant login, resource access, or whitelist slots

### 3. 🏷️ Soulbound Badges for Reputable Domains
- Mint non-transferable identity NFTs based on long-term domain control

---

## 🔍 Challenges We Overcame

- Mapping multiple ZK systems across a single flow
- Leo’s evolving async model (finalize + mapping + record output)
- Preventing double-minting with `nft_commits`
- Merging ZPass SDK, NFT standards, and Merkle verification logic

---

## 📚 What We Learned

- Advanced Leo patterns: `async transition → finalize(...)`
- How to enforce NFT uniqueness without revealing identity
- Designing Aleo-compliant NFT protocols that align with ARC-721
- Extending NFTs with **off-chain + on-chain proof interoperability**

---

## 🔮 What’s Next

- 🧾 Add `publish_nft_content()` for optional metadata visibility
- 🧠 Enable DAO integrations that auto-verify domain credentials
- 🧪 Create a lightweight credential registry for Web3 access
- 📜 Propose ZKNFD as a model for Aleo-based digital passports

---

## 🌐 Use Cases for Private Domain Proofs

### ✅ Gated DAO Membership
> “Only domain owners can vote — but no one knows who owns what.”

### ✅ ZK Identity for Web3
> “Log in to dApps anonymously — yet verifiably.”

### ✅ Compliance Without Exposure
> “Prove domain ownership for KYC or KYB — without leaking business info.”

---

## 🏆 Submission Tracks

- ✅ **Aleo NFT Standard Bounty**: Compliant with ARC-721
- ✅ **ZPass Credentialing Track**: Merkle root + signature integration
- ✅ **Verifiable Private States**: All NFTs are private and verifiable

---

We invite teams, DAOs, and infra projects to extend this into a **ZK credential layer for Web3**.
