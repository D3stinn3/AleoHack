// The 'zknonfungibledomains' program.
import zpass_merkle_8.aleo;
import aleo_name_service_registry.aleo;

program zknonfungibledomains.aleo {

    struct CredentialTokenId {
        domain_hash: field,
        owner_hash: field,
    }

    record CredentialNFT {
        owner: address,
        token_id: CredentialTokenId,
        edition: scalar,
    }

    // ----------------------------------
    // Credential Issuance Using ZKPass
    // ----------------------------------
    // Main transition to issue credential NFT and ZPass
    transition issue_credential(
        private sig: signature,
        private name: [u128; 4],
        private parent: field,
        private issuer: address
    ) -> (CredentialNFT, zpass_merkle_8.aleo/ZPass) {
        
        // ✅ Use a function-style call to calc_name_hash
        let name_hash: field = aleo_name_service_registry.aleo/calc_name_hash(name, parent);



        // Hash the caller address
        let owner_hash: field = Poseidon2::hash_to_field(self.caller);

        // Prepare leaves for Merkle root
        let leaves: [field; 8] = [
            Poseidon2::hash_to_field(issuer),
            name_hash,
            owner_hash,
            0field, 0field, 0field, 0field, 0field,
        ];

        // Issue a ZPass from imported zpass contract
        let zpass: zpass_merkle_8.aleo/ZPass = zpass_merkle_8.aleo/issue(sig, leaves, issuer);

        // Construct credential NFT
        let token_id: CredentialTokenId = CredentialTokenId {
            domain_hash: name_hash,
            owner_hash,
        };

        let nft: CredentialNFT = CredentialNFT {
            owner: self.caller,
            token_id,
            edition: 0scalar,
        };

        return (nft, zpass);
    }

    // Optional: wrap verifier from zpass
    transition verify_zpass(
        zpass: zpass_merkle_8.aleo/ZPass,
        leaf_hash: field,
        proof: [field; 3]
    ) -> bool {
        return zpass_merkle_8.aleo/verify(zpass, leaf_hash, proof);
    }
}
