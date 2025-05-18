program zknonfungibledomains_v1.aleo;

struct Data:
    metadata as [field; 4u32];

record CredentialNFT:
    owner as address.private;
    data as Data.private;
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

mapping nft_commits:
    key as field.public;
    value as boolean.public;

function issue_domain_credential:
    input r0 as signature.private;
    input r1 as [u128; 4u32].private;
    input r2 as field.private;
    input r3 as field.private;
    input r4 as address.private;
    cast r1[0u32] r1[1u32] r1[2u32] r1[3u32] r2 into r5 as TokenId;
    hash.psd2 r5 into r6 as field;
    cast  r6 0field 0field 0field into r7 as [field; 4u32];
    cast r7 into r8 as Data;
    hash.bhp256 r8 into r9 as field;
    commit.bhp256 r9 0scalar into r10 as field;
    sign.verify r0 r4 r3 into r11;
    assert.eq r11 true;
    async issue_domain_credential r10 self.caller r8 0scalar r4 r3 into r12;
    output r12 as zknonfungibledomains_v1.aleo/issue_domain_credential.future;

finalize issue_domain_credential:
    input r0 as field.public;
    input r1 as address.public;
    input r2 as Data.public;
    input r3 as scalar.public;
    input r4 as address.public;
    input r5 as field.public;
    set true into nft_commits[r0];
    set r1 into nft_owners[r0];

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
