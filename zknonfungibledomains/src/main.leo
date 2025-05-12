// The 'zknonfungibledomains' program.

program zknonfungibledomains.aleo {

    struct CredentialTokenId {
        domain_hash: field,
        owner_hash: field,
    }

    struct TokenId {
        data1: u128,
        data2: u128,
        data3: u128,
        data4: u128,
        parent: field,
    }

    record CredentialNFT {
        owner: address,
        token_id: CredentialTokenId,
        edition: scalar,
    }

    record DomainZPass {
        owner: address,
        issuer: address,
        root: field,
    }

    mapping nft_owners: field => address;

    // === Issue Domain Credential ===
    transition issue_domain_credential(
        private sig: signature,
        private name: [u128; 4],
        private parent: field,
        private root: field,
        private issuer: address
    ) -> (CredentialNFT, DomainZPass) {
        // Step 1: Reconstruct TokenId struct from inputs
        let token_id: TokenId = TokenId {
            data1: name[0u32],
            data2: name[1u32],
            data3: name[2u32],
            data4: name[3u32],
            parent: parent,
        };

        let domain_hash: field = Poseidon2::hash_to_field(token_id);

        // Step 2: Confirm domain is registered and caller is owner
        // let owner: address = nft_owners.get(domain_hash);
        // assert_eq(owner, self.caller);

        // Step 3: Verify signature on Merkle root
        assert_eq(signature::verify(sig, issuer, root), true);

        // Step 4: Compute owner hash
        let owner_hash: field = Poseidon2::hash_to_field(self.caller);

        // Step 5: Create domain credential NFT
        let zk_token_id: CredentialTokenId = CredentialTokenId {
            domain_hash,
            owner_hash,
        };

        let nft: CredentialNFT = CredentialNFT {
            owner: self.caller,
            token_id: zk_token_id,
            edition: 0scalar,
        };

        let zpass: DomainZPass = DomainZPass {
            owner: self.caller,
            issuer,
            root,
        };

        return (nft, zpass);
    }

    // === Verifier for Domain Credential ===
    transition verify_domain_credential(
        zpass: DomainZPass,
        leaf_hash: field,
        proof: [field; 3]
    ) -> bool {
        let element: field = leaf_hash;

        element = Poseidon2::hash_to_field(element + proof[0u32]);
        element = Poseidon2::hash_to_field(element + proof[1u32]);
        element = Poseidon2::hash_to_field(element + proof[2u32]);

        assert_eq(element, zpass.root);
        return true;
    }

}
