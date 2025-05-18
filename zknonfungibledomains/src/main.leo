// The 'zknonfungibledomains' program.

program zknonfungibledomains_v1.aleo {

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

    struct Data {
        metadata: [field; 4],
    }

    record CredentialNFT {
        private owner: address,
        private data: Data,
        private edition: scalar,
    }

    record CredentialNFTView {
        private owner: address,
        private data: Data,
        private edition: scalar,
        private is_view: bool,
    }

    record DomainZPass {
        owner: address,
        issuer: address,
        root: field,
    }

    mapping nft_owners: field => address;
    mapping nft_commits: field => bool;

    inline commit_nft(data: Data, edition: scalar) -> field {
        let hash: field = BHP256::hash_to_field(data);
        let commit: field = BHP256::commit_to_field(hash, edition);
        return commit;
    }

    async transition issue_domain_credential(
        private sig: signature,
        private name: [u128; 4],
        private parent: field,
        private root: field,
        private issuer: address
    ) -> Future {
        let token_id: TokenId = TokenId {
            data1: name[0u32],
            data2: name[1u32],
            data3: name[2u32],
            data4: name[3u32],
            parent: parent,
        };

        let domain_hash: field = Poseidon2::hash_to_field(token_id);
        let metadata: Data = Data {
            metadata: [domain_hash, 0field, 0field, 0field],
        };
        let edition: scalar = 0scalar;
        let commit: field = commit_nft(metadata, edition);
        let owner: address = self.caller;

        assert_eq(signature::verify(sig, issuer, root), true);

        return finalize_issue(commit, owner, metadata, edition, issuer, root);
    }

    async function finalize_issue(
        commit: field,
        owner: address,
        metadata: Data,
        edition: scalar,
        issuer: address,
        root: field
    ) {
        nft_commits.set(commit, true);
        nft_owners.set(commit, owner);

        let nft: CredentialNFT = CredentialNFT {
            owner,
            data: metadata,
            edition,
        };

        let zpass: DomainZPass = DomainZPass {
            owner,
            issuer,
            root,
        };
    }

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


