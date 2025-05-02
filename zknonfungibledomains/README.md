## Inspiration
The rise of decentralized identity has always clashed with one major concern: **privacy**. While ENS and similar systems prove ownership on-chain, they also expose sensitive associations — domain-to-wallet links, metadata, and more.

This project was inspired by the question:  
**"Can we prove domain ownership *without revealing the domain name itself*?"**  
That idea led to **zkNFDomain Credentials** — a fully private, zk-native solution.

---

## What it does
**zkNFDomain Credentials** is a privacy-preserving identity credentialing system built on the Aleo blockchain. It allows users to mint **verifiable NFTs** that prove they own a domain name — all without revealing the domain publicly. These Credential NFTs are issued as **ZKPasses**, representing proof of domain ownership using zero-knowledge proofs.

The project combines:
- **Aleo Name Service (ANS)** for decentralized domain name registration,
- **ZKPass** for issuing private, Merkle-based identity credentials,
- **ZK ArtFactory** for minting Credential NFTs tied to ZPass proofs.

> “We wanted to bridge digital identity, privacy, and ownership — and domain names were the perfect anchor. This project proves you own something, without showing the world what that thing is.”

---

## How we built it
This project was built using the **Leo programming language** and deployed on Aleo's zero-knowledge blockchain.

### 🔗 Components Integrated:
- `aleo_name_service_registry.aleo`: For secure domain registration and metadata.
- `zpass_merkle_8.aleo`: To construct a Merkle tree representing identity traits, and issue ZPass records.
- `leo_nft.aleo`: For minting soulbound NFTs representing credential ownership.

## Challenges we ran into
- **Mapping multiple zk systems into a single transition** required complex reasoning around hashes, Merkle trees, and data types.
- Debugging with Leo's evolving toolchain meant we had to **manually simulate some logic** before testing on-chain.
- Ensuring **cross-contract compatibility** and matching data structures took detailed planning.
- Constructing **verifiable but private proofs** without leaking metadata took careful Merkle root construction.

---

## Accomplishments that we're proud of
We wrote a custom Leo program called `zknonfungibledomains.aleo` that:
1. Verifies the caller’s domain ownership.
2. Generates a ZKPass using the Merkle root of identity + domain data.
3. Mints a Credential NFT that’s **private by default** but verifiable.

## What we learned
- How to build modular zkApps using Leo and deploy to Aleo.
- Advanced concepts in **zero-knowledge Merkle proofs**, commitment schemes, and record management in Aleo.
- How to write interoperable zk programs that link NFTs, names, and identity in a seamless UX.

---

## What's next for ZK NonFungibleDomains (ZKNFD)
This is more than a hackathon project. The same mechanism can be used to:
- Prove ownership of domains in anonymous DAOs.
- Provide credentials for Web3 onboarding or gated access.
- Issue **privacy-first soulbound identity badges** — all powered by Aleo.

We’re excited to keep building and invite collaborators to join in.


# 🔐 Use Cases for Private Domain Ownership Proofs

In a privacy-preserving blockchain like Aleo, the ability to **prove domain ownership without revealing the actual domain** unlocks a new class of applications. Below are real-world scenarios where this zero-knowledge property becomes a powerful tool.

---

## 1. 🗳️ Private DAO Membership or Access Control

> “Only domain owners can vote, but the DAO shouldn’t know which domains they hold.”

- Gated communities where access, voting, or governance rights are tied to domain ownership.
- Zero-knowledge proofs allow participation without revealing which domain a user controls.

---

## 2. 👤 Anonymous Web3 Identity

> “Prove you’re verified without revealing who you are.”

- Domain-based credentials as **anonymous identity markers**.
- Works well in privacy-preserving systems that want verified users — not their public keys or domains.

---

## 3. ⚖️ Compliance in Regulated Environments

> “Regulators need assurance, but public exposure isn’t safe.”

- Enterprises can prove domain control for regulatory compliance (e.g., KYB, AML) without exposing business operations or infrastructure publicly.
- Useful for accessing compliant DeFi platforms, stablecoins, or CBDC systems.

---

## 4. 🌐 KYC Alternative for Web3 Onboarding

> “Only real organizations can mint, but we don’t leak our customer base.”

- Domain-based identity as a lightweight **KYC proxy**.
- Ensures that only legitimate entities interact with dApps, APIs, or token systems — privately.

---

## 5. 🏆 Privacy-Preserving Reputation Systems

> “Earn domain-based badges without revealing the domain name.”

- Users can receive or prove **long-term domain ownership** without linking themselves publicly.
- For example: “I own a domain registered 5+ years ago” → gain credibility in Web3 networks.

---

## 6. 🧾 ZK Credential Marketplaces

> “Sell or lend identity-linked rights privately.”

- Ownership of a domain might grant rights (e.g., discounts, hosting credits, publishing access).
- Credentials can be proven and exchanged **without revealing the underlying domain**.

---

## 7. ✅🚫 Decentralized Whitelisting / Blacklisting

> “Prove you're on the list — without leaking your identity.”

- Whitelist access (e.g., to NFT mints, airdrops) or blacklist avoidance can be verified privately.
- Keeps individual or business affiliations hidden while enforcing access control.

---

## 🔐 Why This Matters

Proving domain ownership without revealing the domain enables:

- ✅ Selective disclosure
- ✅ Anti-censorship by design
- ✅ Private authentication
- ✅ Anonymous trust and reputation
- ✅ On-chain compliance without leaks

It’s a foundational zero-knowledge primitive that unlocks secure, private participation in Web3 ecosystems.

---
