import zpass_merkle_8.aleo;
import ans_utils.aleo;
import aleo_name_service_registry.aleo;
program zknonfungibledomains.aleo;

struct CredentialTokenId:
    domain_hash as field;
    owner_hash as field;

record CredentialNFT:
    owner as address.private;
    token_id as CredentialTokenId.private;
    edition as scalar.private;

struct Name:
    name as [u128; 4u32];
    parent as field;

struct NameStruct:
    name as [u128; 4u32];
    parent as field;
    resolver as u128;

struct data:
    metadata as [field; 4u32];
    content as Name;

function issue_domain_credential:
    input r0 as signature.private;
    input r1 as [u128; 4u32].private;
    input r2 as field.private;
    input r3 as address.private;
    call aleo_name_service_registry.aleo/calc_name_hash r1 r2 into r4;
    hash.psd2 self.caller into r5 as field;
    hash.psd2 r3 into r6 as field;
    cast  r6 r4 r5 0field 0field 0field 0field 0field into r7 as [field; 8u32];
    call zpass_merkle_8.aleo/issue r0 r7 r3 into r8;
    cast r4 r5 into r9 as CredentialTokenId;
    cast self.caller r9 0scalar into r10 as CredentialNFT.record;
    output r10 as CredentialNFT.record;
    output r8 as zpass_merkle_8.aleo/ZPass.record;

function verify_domain_credential:
    input r0 as zpass_merkle_8.aleo/ZPass.record;
    input r1 as field.private;
    input r2 as [field; 3u32].private;
    call zpass_merkle_8.aleo/verify r0 r1 r2 into r3;
    output r3 as boolean.private;
