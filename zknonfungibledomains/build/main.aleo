program zknonfungibledomains.aleo;

struct CredentialTokenId:
    domain_hash as field;
    owner_hash as field;

record CredentialNFT:
    owner as address.private;
    token_id as CredentialTokenId.private;
    edition as scalar.private;

record DomainZPass:
    owner as address.private;
    issuer as address.private;
    root as field.private;

struct TokenId:
    data1 as u128;
    data2 as u128;
    data3 as u128;
    data4 as u128;
    parent as field;

mapping nft_owners:
    key as field.public;
    value as address.public;

function issue_domain_credential:
    input r0 as signature.private;
    input r1 as [u128; 4u32].private;
    input r2 as field.private;
    input r3 as field.private;
    input r4 as address.private;
    cast r1[0u32] r1[1u32] r1[2u32] r1[3u32] r2 into r5 as TokenId;
    hash.psd2 r5 into r6 as field;
    sign.verify r0 r4 r3 into r7;
    assert.eq r7 true;
    hash.psd2 self.caller into r8 as field;
    cast r6 r8 into r9 as CredentialTokenId;
    cast self.caller r9 0scalar into r10 as CredentialNFT.record;
    cast self.caller r4 r3 into r11 as DomainZPass.record;
    output r10 as CredentialNFT.record;
    output r11 as DomainZPass.record;

function verify_domain_credential:
    input r0 as DomainZPass.record;
    input r1 as field.private;
    input r2 as [field; 3u32].private;
    add r1 r2[0u32] into r3;
    hash.psd2 r3 into r4 as field;
    add r4 r2[1u32] into r5;
    hash.psd2 r5 into r6 as field;
    add r6 r2[2u32] into r7;
    hash.psd2 r7 into r8 as field;
    assert.eq r8 r0.root;
    output true as boolean.private;
