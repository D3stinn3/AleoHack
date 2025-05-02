import ans_utils.aleo;

program aleo_name_service_registry.aleo;

struct Name:
    name as [u128; 4u32];
    parent as field;

struct NameStruct:
    name as [u128; 4u32];
    parent as field;
    resolver as u128;

struct Allowance:
    account as address;
    spender as address;

struct data:
    metadata as [field; 4u32];
    content as Name;

record NFT:
    owner as address.private;
    data as data.private;
    edition as scalar.private;

record NFTView:
    owner as address.private;
    data as data.private;
    edition as scalar.private;
    is_view as boolean.private;

mapping nft_owners:
    key as field.public;
    value as address.public;

mapping names:
    key as field.public;
    value as NameStruct.public;

mapping primary_names:
    key as address.public;
    value as field.public;

mapping name_versions:
    key as field.public;
    value as u64.public;

mapping for_all_allowances:
    key as field.public;
    value as boolean.public;

mapping allowances:
    key as field.public;
    value as field.public;

mapping general_settings:
    key as u8.public;
    value as u128.public;

mapping toggle_settings:
    key as u8.public;
    value as u32.public;

function initialize_collection:
    input r0 as u128.public;
    input r1 as u128.public;
    input r2 as [u128; 4u32].public;
    hash.bhp256 self.caller into r3 as u128;
    async initialize_collection r0 r1 r3 r2 into r4;
    output r4 as aleo_name_service_registry.aleo/initialize_collection.future;

finalize initialize_collection:
    input r0 as u128.public;
    input r1 as u128.public;
    input r2 as u128.public;
    input r3 as [u128; 4u32].public;
    get.or_use toggle_settings[0u8] 0u32 into r4;
    and r4 1u32 into r5;
    assert.eq r5 0u32 ;
    set r0 into general_settings[0u8];
    set r0 into general_settings[1u8];
    set r1 into general_settings[2u8];
    set r3[0u32] into general_settings[3u8];
    set r3[1u32] into general_settings[4u8];
    set r3[2u32] into general_settings[5u8];
    set r3[3u32] into general_settings[6u8];
    set r2 into general_settings[7u8];
    set 1u32 into toggle_settings[0u8];

function set_admin:
    input r0 as address.private;
    hash.bhp256 self.caller into r1 as u128;
    hash.bhp256 r0 into r2 as u128;
    async set_admin r1 r2 into r3;
    output r3 as aleo_name_service_registry.aleo/set_admin.future;

finalize set_admin:
    input r0 as u128.public;
    input r1 as u128.public;
    get general_settings[7u8] into r2;
    assert.eq r0 r2 ;
    set r1 into general_settings[7u8];

function update_base_uri:
    input r0 as [u128; 4u32].public;
    hash.bhp256 self.caller into r1 as u128;
    async update_base_uri r1 r0 into r2;
    output r2 as aleo_name_service_registry.aleo/update_base_uri.future;

finalize update_base_uri:
    input r0 as u128.public;
    input r1 as [u128; 4u32].public;
    get general_settings[7u8] into r2;
    assert.eq r0 r2 ;
    get toggle_settings[0u8] into r3;
    and r3 9u32 into r4;
    assert.eq r4 1u32 ;
    set r1[0u32] into general_settings[3u8];
    set r1[1u32] into general_settings[4u8];
    set r1[2u32] into general_settings[5u8];
    set r1[3u32] into general_settings[6u8];

function update_toggle_settings:
    input r0 as u32.public;
    hash.bhp256 self.caller into r1 as u128;
    async update_toggle_settings r1 r0 into r2;
    output r2 as aleo_name_service_registry.aleo/update_toggle_settings.future;

finalize update_toggle_settings:
    input r0 as u128.public;
    input r1 as u32.public;
    get general_settings[7u8] into r2;
    assert.eq r0 r2 ;
    get toggle_settings[0u8] into r3;
    and r3 9u32 into r4;
    assert.eq r4 1u32 ;
    and r1 1u32 into r5;
    assert.eq r5 1u32 ;
    set r1 into toggle_settings[0u8];

closure calc_name_hash:
    input r0 as [u128; 4u32];
    input r1 as field;
    cast r0 r1 into r2 as Name;
    hash.psd2 r2 into r3 as field;
    output r3 as field;

function register_tld:
    input r0 as address.private;
    input r1 as [u128; 4u32].private;
    call calc_name_hash r1 0field into r2;
    hash.bhp256 self.caller into r3 as u128;
    cast r1 0field 0u128 into r4 as NameStruct;
    async register_tld r3 r0 r2 r4 into r5;
    output r5 as aleo_name_service_registry.aleo/register_tld.future;

finalize register_tld:
    input r0 as u128.public;
    input r1 as address.public;
    input r2 as field.public;
    input r3 as NameStruct.public;
    get general_settings[7u8] into r4;
    assert.eq r0 r4 ;
    set r3 into names[r2];
    set r1 into nft_owners[r2];

function register:
    input r0 as [u128; 4u32].private;
    input r1 as field.private;
    input r2 as address.private;
    input r3 as u128.private;
    call ans_utils.aleo/validate_name r0 into r4;
    assert.eq r4 true ;
    call calc_name_hash r0 r1 into r5;
    cast r5 0field 0field 0field into r6 as [field; 4u32];
    cast r0 r1 into r7 as Name;
    cast r6 r7 into r8 as data;
    cast r2 r8 0scalar into r9 as NFT.record;
    async register r5 r0 r1 r3 self.caller into r10;
    output r9 as NFT.record;
    output r10 as aleo_name_service_registry.aleo/register.future;

finalize register:
    input r0 as field.public;
    input r1 as [u128; 4u32].public;
    input r2 as field.public;
    input r3 as u128.public;
    input r4 as address.public;
    get nft_owners[r2] into r5;
    assert.eq r4 r5 ;
    contains names[r0] into r6;
    assert.eq r6 false ;
    get toggle_settings[0u8] into r7;
    and r7 3u32 into r8;
    assert.eq r8 3u32 ;
    cast r1 r2 r3 into r9 as NameStruct;
    set r9 into names[r0];

function register_private:
    input r0 as [u128; 4u32].private;
    input r1 as NFT.record;
    input r2 as address.private;
    input r3 as u128.private;
    call ans_utils.aleo/validate_name r0 into r4;
    assert.eq r4 true ;
    call calc_name_hash r0 r1.data.metadata[0u32] into r5;
    cast r5 0field 0field 0field into r6 as [field; 4u32];
    cast r0 r1.data.metadata[0u32] into r7 as Name;
    cast r6 r7 into r8 as data;
    cast r2 r8 0scalar into r9 as NFT.record;
    cast r1.owner r1.data r1.edition into r10 as NFT.record;
    async register_private r5 r0 r1.data.metadata[0u32] r3 into r11;
    output r9 as NFT.record;
    output r10 as NFT.record;
    output r11 as aleo_name_service_registry.aleo/register_private.future;

finalize register_private:
    input r0 as field.public;
    input r1 as [u128; 4u32].public;
    input r2 as field.public;
    input r3 as u128.public;
    contains names[r0] into r4;
    assert.eq r4 false ;
    get toggle_settings[0u8] into r5;
    and r5 3u32 into r6;
    assert.eq r6 3u32 ;
    cast r1 r2 r3 into r7 as NameStruct;
    set r7 into names[r0];

function register_public:
    input r0 as [u128; 4u32].private;
    input r1 as field.private;
    input r2 as address.private;
    input r3 as u128.private;
    call ans_utils.aleo/validate_name r0 into r4;
    assert.eq r4 true ;
    call calc_name_hash r0 r1 into r5;
    cast r5 0field 0field 0field into r6 as [field; 4u32];
    cast r0 r1 into r7 as Name;
    cast r6 r7 into r8 as data;
    cast r2 r8 0scalar into r9 as NFT.record;
    async register_public r5 r0 r1 r3 self.signer into r10;
    output r9 as NFT.record;
    output r10 as aleo_name_service_registry.aleo/register_public.future;

finalize register_public:
    input r0 as field.public;
    input r1 as [u128; 4u32].public;
    input r2 as field.public;
    input r3 as u128.public;
    input r4 as address.public;
    get nft_owners[r2] into r5;
    assert.eq r4 r5 ;
    contains names[r0] into r6;
    assert.eq r6 false ;
    get toggle_settings[0u8] into r7;
    and r7 3u32 into r8;
    assert.eq r8 3u32 ;
    cast r1 r2 r3 into r9 as NameStruct;
    set r9 into names[r0];

function transfer_private:
    input r0 as NFT.record;
    input r1 as address.private;
    cast r1 r0.data 0scalar into r2 as NFT.record;
    output r2 as NFT.record;

function transfer_public:
    input r0 as data.private;
    input r1 as scalar.private;
    input r2 as address.public;
    call calc_name_hash r0.content.name r0.content.parent into r3;
    assert.eq r0.metadata[0u32] r3 ;
    cast r2 r0 r1 true into r4 as NFTView.record;
    async transfer_public r2 r0.metadata[0u32] self.caller into r5;
    output r4 as NFTView.record;
    output r5 as aleo_name_service_registry.aleo/transfer_public.future;

finalize transfer_public:
    input r0 as address.public;
    input r1 as field.public;
    input r2 as address.public;
    get nft_owners[r1] into r3;
    assert.eq r2 r3 ;
    set r0 into nft_owners[r1];
    remove allowances[r1];
    get.or_use name_versions[r1] 1u64 into r4;
    add r4 1u64 into r5;
    set r5 into name_versions[r1];
    get.or_use primary_names[r3] 0field into r6;
    is.eq r6 r1 into r7;
    is.neq r3 r0 into r8;
    and r7 r8 into r9;
    branch.eq r9 false to end_then_0_0;
    remove primary_names[r3];
    branch.eq true true to end_otherwise_0_1;
    position end_then_0_0;
    position end_otherwise_0_1;

function transfer_private_to_public:
    input r0 as NFT.record;
    input r1 as address.private;
    cast r1 r0.data r0.edition true into r2 as NFTView.record;
    async transfer_private_to_public r1 r0.data.metadata[0u32] into r3;
    output r2 as NFTView.record;
    output r3 as aleo_name_service_registry.aleo/transfer_private_to_public.future;

finalize transfer_private_to_public:
    input r0 as address.public;
    input r1 as field.public;
    set r0 into nft_owners[r1];

function transfer_public_to_private:
    input r0 as data.private;
    input r1 as scalar.private;
    input r2 as address.private;
    call calc_name_hash r0.content.name r0.content.parent into r3;
    assert.eq r0.metadata[0u32] r3 ;
    cast r2 r0 0scalar into r4 as NFT.record;
    async transfer_public_to_private self.caller r0.metadata[0u32] into r5;
    output r4 as NFT.record;
    output r5 as aleo_name_service_registry.aleo/transfer_public_to_private.future;

finalize transfer_public_to_private:
    input r0 as address.public;
    input r1 as field.public;
    get nft_owners[r1] into r2;
    assert.eq r0 r2 ;
    remove nft_owners[r1];
    remove allowances[r1];
    get.or_use name_versions[r1] 1u64 into r3;
    add r3 1u64 into r4;
    set r4 into name_versions[r1];
    get.or_use primary_names[r2] 0field into r5;
    is.eq r5 r1 into r6;
    branch.eq r6 false to end_then_0_2;
    remove primary_names[r2];
    branch.eq true true to end_otherwise_0_3;
    position end_then_0_2;
    position end_otherwise_0_3;

function set_primary_name:
    input r0 as field.private;
    async set_primary_name r0 self.caller into r1;
    output r1 as aleo_name_service_registry.aleo/set_primary_name.future;

finalize set_primary_name:
    input r0 as field.public;
    input r1 as address.public;
    get nft_owners[r0] into r2;
    assert.eq r1 r2 ;
    set r0 into primary_names[r1];

function unset_primary_name:
    async unset_primary_name self.caller into r0;
    output r0 as aleo_name_service_registry.aleo/unset_primary_name.future;

finalize unset_primary_name:
    input r0 as address.public;
    remove primary_names[r0];

function set_resolver:
    input r0 as field.private;
    input r1 as u128.private;
    async set_resolver r0 self.caller r1 into r2;
    output r2 as aleo_name_service_registry.aleo/set_resolver.future;

finalize set_resolver:
    input r0 as field.public;
    input r1 as address.public;
    input r2 as u128.public;
    get nft_owners[r0] into r3;
    assert.eq r1 r3 ;
    get names[r0] into r4;
    cast r4.name r4.parent r2 into r5 as NameStruct;
    set r5 into names[r0];

function authorize:
    input r0 as NFT.record;
    async authorize into r1;
    output r1 as aleo_name_service_registry.aleo/authorize.future;

finalize authorize:
    assert.eq 0u8 1u8 ;

function burn:
    input r0 as NFT.record;
    async burn r0.data.metadata[0u32] into r1;
    output r1 as aleo_name_service_registry.aleo/burn.future;

finalize burn:
    input r0 as field.public;
    remove names[r0];

function approve_public:
    input r0 as address.private;
    input r1 as data.private;
    input r2 as scalar.private;
    call calc_name_hash r1.content.name r1.content.parent into r3;
    assert.eq r1.metadata[0u32] r3 ;
    cast self.caller r0 into r4 as Allowance;
    hash.bhp256 r4 into r5 as field;
    async approve_public self.caller r5 r1.metadata[0u32] into r6;
    output r6 as aleo_name_service_registry.aleo/approve_public.future;

finalize approve_public:
    input r0 as address.public;
    input r1 as field.public;
    input r2 as field.public;
    get nft_owners[r2] into r3;
    assert.eq r3 r0 ;
    set r1 into allowances[r2];

function set_for_all_approval:
    input r0 as address.private;
    input r1 as boolean.private;
    cast self.caller r0 into r2 as Allowance;
    hash.bhp256 r2 into r3 as field;
    async set_for_all_approval r3 r1 into r4;
    output r4 as aleo_name_service_registry.aleo/set_for_all_approval.future;

finalize set_for_all_approval:
    input r0 as field.public;
    input r1 as boolean.public;
    set r1 into for_all_allowances[r0];

function transfer_from_public:
    input r0 as address.public;
    input r1 as address.public;
    input r2 as data.private;
    input r3 as scalar.private;
    call calc_name_hash r2.content.name r2.content.parent into r4;
    assert.eq r2.metadata[0u32] r4 ;
    cast r1 r2 r3 true into r5 as NFTView.record;
    cast r0 self.caller into r6 as Allowance;
    hash.bhp256 r6 into r7 as field;
    async transfer_from_public r7 r0 r1 r2.metadata[0u32] into r8;
    output r5 as NFTView.record;
    output r8 as aleo_name_service_registry.aleo/transfer_from_public.future;

finalize transfer_from_public:
    input r0 as field.public;
    input r1 as address.public;
    input r2 as address.public;
    input r3 as field.public;
    get.or_use allowances[r3] 0field into r4;
    is.eq r4 r0 into r5;
    get.or_use for_all_allowances[r0] false into r6;
    or r5 r6 into r7;
    assert.eq r7 true ;
    get nft_owners[r3] into r8;
    assert.eq r1 r8 ;
    remove allowances[r3];
    set r2 into nft_owners[r3];
    get.or_use name_versions[r3] 1u64 into r9;
    add r9 1u64 into r10;
    set r10 into name_versions[r3];
    get.or_use primary_names[r8] 0field into r11;
    is.eq r11 r3 into r12;
    branch.eq r12 false to end_then_0_4;
    remove primary_names[r8];
    branch.eq true true to end_otherwise_0_5;
    position end_then_0_4;
    position end_otherwise_0_5;
