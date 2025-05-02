## Inspiration
The rise of decentralized identity has always clashed with one major concern: **privacy**. While ENS and similar systems prove ownership on-chain, they also expose sensitive associations — domain-to-wallet links, metadata, and more.

This project was inspired by the question:  
**"Can we prove domain ownership *without revealing the domain name itself*?"**  
That idea led to **zkDomain Credentials** — a fully private, zk-native solution.

---

## What it does
**zkDomain Credentials** is a privacy-preserving identity credentialing system built on the Aleo blockchain. It allows users to mint **verifiable NFTs** that prove they own a domain name — all without revealing the domain publicly. These Credential NFTs are issued as **ZKPasses**, representing proof of domain ownership using zero-knowledge proofs.

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