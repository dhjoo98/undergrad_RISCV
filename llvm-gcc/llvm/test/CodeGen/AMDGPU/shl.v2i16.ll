; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -march=amdgcn -mcpu=gfx900 -mattr=-flat-for-global -verify-machineinstrs < %s | FileCheck -enable-var-scope --check-prefix=GFX9 %s
; RUN: llc -march=amdgcn -mcpu=tonga -mattr=-flat-for-global -verify-machineinstrs < %s | FileCheck -enable-var-scope --check-prefix=VI %s
; RUN: llc -march=amdgcn -mcpu=bonaire -verify-machineinstrs < %s | FileCheck -enable-var-scope --check-prefix=CI %s
; RUN: llc -march=amdgcn -mcpu=gfx1010 -mattr=-flat-for-global -verify-machineinstrs < %s | FileCheck -enable-var-scope --check-prefix=GFX10 %s

define amdgpu_kernel void @s_shl_v2i16(<2 x i16> addrspace(1)* %out, <2 x i16> %lhs, <2 x i16> %rhs) #0 {
; GFX9-LABEL: s_shl_v2i16:
; GFX9:       ; %bb.0:
; GFX9-NEXT:    s_load_dwordx2 s[4:5], s[0:1], 0x24
; GFX9-NEXT:    s_load_dword s2, s[0:1], 0x2c
; GFX9-NEXT:    s_load_dword s3, s[0:1], 0x30
; GFX9-NEXT:    s_mov_b32 s7, 0xf000
; GFX9-NEXT:    s_mov_b32 s6, -1
; GFX9-NEXT:    s_waitcnt lgkmcnt(0)
; GFX9-NEXT:    v_mov_b32_e32 v0, s2
; GFX9-NEXT:    v_pk_lshlrev_b16 v0, s3, v0
; GFX9-NEXT:    buffer_store_dword v0, off, s[4:7], 0
; GFX9-NEXT:    s_endpgm
;
; VI-LABEL: s_shl_v2i16:
; VI:       ; %bb.0:
; VI-NEXT:    s_load_dwordx2 s[4:5], s[0:1], 0x24
; VI-NEXT:    s_load_dword s2, s[0:1], 0x2c
; VI-NEXT:    s_load_dword s0, s[0:1], 0x30
; VI-NEXT:    s_mov_b32 s3, 0xffff
; VI-NEXT:    s_mov_b32 s7, 0xf000
; VI-NEXT:    s_mov_b32 s6, -1
; VI-NEXT:    s_waitcnt lgkmcnt(0)
; VI-NEXT:    s_lshr_b32 s1, s2, 16
; VI-NEXT:    s_lshr_b32 s8, s0, 16
; VI-NEXT:    s_and_b32 s2, s2, s3
; VI-NEXT:    s_and_b32 s0, s0, s3
; VI-NEXT:    s_lshl_b32 s0, s2, s0
; VI-NEXT:    s_lshl_b32 s1, s1, s8
; VI-NEXT:    s_lshl_b32 s1, s1, 16
; VI-NEXT:    s_and_b32 s0, s0, s3
; VI-NEXT:    s_or_b32 s0, s0, s1
; VI-NEXT:    v_mov_b32_e32 v0, s0
; VI-NEXT:    buffer_store_dword v0, off, s[4:7], 0
; VI-NEXT:    s_endpgm
;
; CI-LABEL: s_shl_v2i16:
; CI:       ; %bb.0:
; CI-NEXT:    s_load_dwordx2 s[4:5], s[0:1], 0x9
; CI-NEXT:    s_load_dword s2, s[0:1], 0xb
; CI-NEXT:    s_load_dword s0, s[0:1], 0xc
; CI-NEXT:    s_mov_b32 s3, 0xffff
; CI-NEXT:    s_mov_b32 s7, 0xf000
; CI-NEXT:    s_mov_b32 s6, -1
; CI-NEXT:    s_waitcnt lgkmcnt(0)
; CI-NEXT:    s_lshr_b32 s1, s2, 16
; CI-NEXT:    s_and_b32 s8, s0, s3
; CI-NEXT:    s_lshr_b32 s0, s0, 16
; CI-NEXT:    s_lshl_b32 s0, s1, s0
; CI-NEXT:    s_lshl_b32 s1, s2, s8
; CI-NEXT:    s_lshl_b32 s0, s0, 16
; CI-NEXT:    s_and_b32 s1, s1, s3
; CI-NEXT:    s_or_b32 s0, s1, s0
; CI-NEXT:    v_mov_b32_e32 v0, s0
; CI-NEXT:    buffer_store_dword v0, off, s[4:7], 0
; CI-NEXT:    s_endpgm
;
; GFX10-LABEL: s_shl_v2i16:
; GFX10:       ; %bb.0:
; GFX10-NEXT:    s_clause 0x2
; GFX10-NEXT:    s_load_dword s2, s[0:1], 0x2c
; GFX10-NEXT:    s_load_dword s3, s[0:1], 0x30
; GFX10-NEXT:    s_load_dwordx2 s[4:5], s[0:1], 0x24
; GFX10-NEXT:    s_mov_b32 s7, 0x31016000
; GFX10-NEXT:    s_mov_b32 s6, -1
; GFX10-NEXT:    s_waitcnt lgkmcnt(0)
; GFX10-NEXT:    v_pk_lshlrev_b16 v0, s3, s2
; GFX10-NEXT:    buffer_store_dword v0, off, s[4:7], 0
; GFX10-NEXT:    s_endpgm
  %result = shl <2 x i16> %lhs, %rhs
  store <2 x i16> %result, <2 x i16> addrspace(1)* %out
  ret void
}

define amdgpu_kernel void @v_shl_v2i16(<2 x i16> addrspace(1)* %out, <2 x i16> addrspace(1)* %in) #0 {
; GFX9-LABEL: v_shl_v2i16:
; GFX9:       ; %bb.0:
; GFX9-NEXT:    s_load_dwordx4 s[0:3], s[0:1], 0x24
; GFX9-NEXT:    v_lshlrev_b32_e32 v0, 2, v0
; GFX9-NEXT:    s_waitcnt lgkmcnt(0)
; GFX9-NEXT:    global_load_dword v1, v0, s[2:3]
; GFX9-NEXT:    global_load_dword v2, v0, s[2:3] offset:4
; GFX9-NEXT:    s_waitcnt vmcnt(0)
; GFX9-NEXT:    v_pk_lshlrev_b16 v1, v2, v1
; GFX9-NEXT:    global_store_dword v0, v1, s[0:1]
; GFX9-NEXT:    s_endpgm
;
; VI-LABEL: v_shl_v2i16:
; VI:       ; %bb.0:
; VI-NEXT:    s_load_dwordx4 s[0:3], s[0:1], 0x24
; VI-NEXT:    v_lshlrev_b32_e32 v4, 2, v0
; VI-NEXT:    s_waitcnt lgkmcnt(0)
; VI-NEXT:    v_mov_b32_e32 v1, s3
; VI-NEXT:    v_add_u32_e32 v0, vcc, s2, v4
; VI-NEXT:    v_addc_u32_e32 v1, vcc, 0, v1, vcc
; VI-NEXT:    v_add_u32_e32 v2, vcc, 4, v0
; VI-NEXT:    v_addc_u32_e32 v3, vcc, 0, v1, vcc
; VI-NEXT:    flat_load_dword v5, v[0:1]
; VI-NEXT:    flat_load_dword v2, v[2:3]
; VI-NEXT:    v_mov_b32_e32 v1, s1
; VI-NEXT:    v_add_u32_e32 v0, vcc, s0, v4
; VI-NEXT:    v_addc_u32_e32 v1, vcc, 0, v1, vcc
; VI-NEXT:    s_waitcnt vmcnt(0)
; VI-NEXT:    v_lshlrev_b16_e32 v3, v2, v5
; VI-NEXT:    v_lshlrev_b16_sdwa v2, v2, v5 dst_sel:WORD_1 dst_unused:UNUSED_PAD src0_sel:WORD_1 src1_sel:WORD_1
; VI-NEXT:    v_or_b32_e32 v2, v3, v2
; VI-NEXT:    flat_store_dword v[0:1], v2
; VI-NEXT:    s_endpgm
;
; CI-LABEL: v_shl_v2i16:
; CI:       ; %bb.0:
; CI-NEXT:    s_load_dwordx4 s[4:7], s[0:1], 0x9
; CI-NEXT:    s_mov_b32 s3, 0xf000
; CI-NEXT:    s_mov_b32 s2, 0
; CI-NEXT:    v_lshlrev_b32_e32 v0, 2, v0
; CI-NEXT:    v_mov_b32_e32 v1, 0
; CI-NEXT:    s_waitcnt lgkmcnt(0)
; CI-NEXT:    s_mov_b64 s[0:1], s[6:7]
; CI-NEXT:    buffer_load_dword v2, v[0:1], s[0:3], 0 addr64
; CI-NEXT:    buffer_load_dword v3, v[0:1], s[0:3], 0 addr64 offset:4
; CI-NEXT:    s_mov_b32 s0, 0xffff
; CI-NEXT:    s_mov_b64 s[6:7], s[2:3]
; CI-NEXT:    s_waitcnt vmcnt(1)
; CI-NEXT:    v_lshrrev_b32_e32 v4, 16, v2
; CI-NEXT:    s_waitcnt vmcnt(0)
; CI-NEXT:    v_and_b32_e32 v5, s0, v3
; CI-NEXT:    v_lshrrev_b32_e32 v3, 16, v3
; CI-NEXT:    v_lshl_b32_e32 v3, v4, v3
; CI-NEXT:    v_lshl_b32_e32 v2, v2, v5
; CI-NEXT:    v_lshlrev_b32_e32 v3, 16, v3
; CI-NEXT:    v_and_b32_e32 v2, s0, v2
; CI-NEXT:    v_or_b32_e32 v2, v2, v3
; CI-NEXT:    buffer_store_dword v2, v[0:1], s[4:7], 0 addr64
; CI-NEXT:    s_endpgm
;
; GFX10-LABEL: v_shl_v2i16:
; GFX10:       ; %bb.0:
; GFX10-NEXT:    s_load_dwordx4 s[0:3], s[0:1], 0x24
; GFX10-NEXT:    v_lshlrev_b32_e32 v0, 2, v0
; GFX10-NEXT:    s_waitcnt lgkmcnt(0)
; GFX10-NEXT:    s_clause 0x1
; GFX10-NEXT:    global_load_dword v1, v0, s[2:3]
; GFX10-NEXT:    global_load_dword v2, v0, s[2:3] offset:4
; GFX10-NEXT:    s_waitcnt vmcnt(0)
; GFX10-NEXT:    v_pk_lshlrev_b16 v1, v2, v1
; GFX10-NEXT:    global_store_dword v0, v1, s[0:1]
; GFX10-NEXT:    s_endpgm
  %tid = call i32 @llvm.amdgcn.workitem.id.x()
  %tid.ext = sext i32 %tid to i64
  %in.gep = getelementptr inbounds <2 x i16>, <2 x i16> addrspace(1)* %in, i64 %tid.ext
  %out.gep = getelementptr inbounds <2 x i16>, <2 x i16> addrspace(1)* %out, i64 %tid.ext
  %b_ptr = getelementptr <2 x i16>, <2 x i16> addrspace(1)* %in.gep, i32 1
  %a = load <2 x i16>, <2 x i16> addrspace(1)* %in.gep
  %b = load <2 x i16>, <2 x i16> addrspace(1)* %b_ptr
  %result = shl <2 x i16> %a, %b
  store <2 x i16> %result, <2 x i16> addrspace(1)* %out.gep
  ret void
}

define amdgpu_kernel void @shl_v_s_v2i16(<2 x i16> addrspace(1)* %out, <2 x i16> addrspace(1)* %in, <2 x i16> %sgpr) #0 {
; GFX9-LABEL: shl_v_s_v2i16:
; GFX9:       ; %bb.0:
; GFX9-NEXT:    s_load_dwordx4 s[4:7], s[0:1], 0x24
; GFX9-NEXT:    s_load_dword s2, s[0:1], 0x34
; GFX9-NEXT:    v_lshlrev_b32_e32 v0, 2, v0
; GFX9-NEXT:    s_waitcnt lgkmcnt(0)
; GFX9-NEXT:    global_load_dword v1, v0, s[6:7]
; GFX9-NEXT:    s_waitcnt vmcnt(0)
; GFX9-NEXT:    v_pk_lshlrev_b16 v1, s2, v1
; GFX9-NEXT:    global_store_dword v0, v1, s[4:5]
; GFX9-NEXT:    s_endpgm
;
; VI-LABEL: shl_v_s_v2i16:
; VI:       ; %bb.0:
; VI-NEXT:    s_load_dwordx4 s[4:7], s[0:1], 0x24
; VI-NEXT:    s_load_dword s0, s[0:1], 0x34
; VI-NEXT:    v_lshlrev_b32_e32 v2, 2, v0
; VI-NEXT:    s_waitcnt lgkmcnt(0)
; VI-NEXT:    v_mov_b32_e32 v1, s7
; VI-NEXT:    v_add_u32_e32 v0, vcc, s6, v2
; VI-NEXT:    v_addc_u32_e32 v1, vcc, 0, v1, vcc
; VI-NEXT:    flat_load_dword v3, v[0:1]
; VI-NEXT:    s_lshr_b32 s1, s0, 16
; VI-NEXT:    v_add_u32_e32 v0, vcc, s4, v2
; VI-NEXT:    v_mov_b32_e32 v2, s1
; VI-NEXT:    v_mov_b32_e32 v1, s5
; VI-NEXT:    v_addc_u32_e32 v1, vcc, 0, v1, vcc
; VI-NEXT:    s_waitcnt vmcnt(0)
; VI-NEXT:    v_lshlrev_b16_e32 v4, s0, v3
; VI-NEXT:    v_lshlrev_b16_sdwa v2, v2, v3 dst_sel:WORD_1 dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:WORD_1
; VI-NEXT:    v_or_b32_e32 v2, v4, v2
; VI-NEXT:    flat_store_dword v[0:1], v2
; VI-NEXT:    s_endpgm
;
; CI-LABEL: shl_v_s_v2i16:
; CI:       ; %bb.0:
; CI-NEXT:    s_load_dwordx4 s[4:7], s[0:1], 0x9
; CI-NEXT:    s_load_dword s8, s[0:1], 0xd
; CI-NEXT:    s_mov_b32 s3, 0xf000
; CI-NEXT:    s_mov_b32 s2, 0
; CI-NEXT:    v_lshlrev_b32_e32 v0, 2, v0
; CI-NEXT:    s_waitcnt lgkmcnt(0)
; CI-NEXT:    s_mov_b64 s[0:1], s[6:7]
; CI-NEXT:    v_mov_b32_e32 v1, 0
; CI-NEXT:    buffer_load_dword v2, v[0:1], s[0:3], 0 addr64
; CI-NEXT:    s_mov_b32 s0, 0xffff
; CI-NEXT:    s_lshr_b32 s1, s8, 16
; CI-NEXT:    s_and_b32 s8, s8, s0
; CI-NEXT:    s_mov_b64 s[6:7], s[2:3]
; CI-NEXT:    s_waitcnt vmcnt(0)
; CI-NEXT:    v_lshrrev_b32_e32 v3, 16, v2
; CI-NEXT:    v_lshlrev_b32_e32 v2, s8, v2
; CI-NEXT:    v_lshlrev_b32_e32 v3, s1, v3
; CI-NEXT:    v_and_b32_e32 v2, s0, v2
; CI-NEXT:    v_lshlrev_b32_e32 v3, 16, v3
; CI-NEXT:    v_or_b32_e32 v2, v2, v3
; CI-NEXT:    buffer_store_dword v2, v[0:1], s[4:7], 0 addr64
; CI-NEXT:    s_endpgm
;
; GFX10-LABEL: shl_v_s_v2i16:
; GFX10:       ; %bb.0:
; GFX10-NEXT:    s_load_dwordx4 s[4:7], s[0:1], 0x24
; GFX10-NEXT:    v_lshlrev_b32_e32 v0, 2, v0
; GFX10-NEXT:    s_load_dword s0, s[0:1], 0x34
; GFX10-NEXT:    s_waitcnt lgkmcnt(0)
; GFX10-NEXT:    global_load_dword v1, v0, s[6:7]
; GFX10-NEXT:    s_waitcnt vmcnt(0)
; GFX10-NEXT:    v_pk_lshlrev_b16 v1, s0, v1
; GFX10-NEXT:    global_store_dword v0, v1, s[4:5]
; GFX10-NEXT:    s_endpgm
  %tid = call i32 @llvm.amdgcn.workitem.id.x()
  %tid.ext = sext i32 %tid to i64
  %in.gep = getelementptr inbounds <2 x i16>, <2 x i16> addrspace(1)* %in, i64 %tid.ext
  %out.gep = getelementptr inbounds <2 x i16>, <2 x i16> addrspace(1)* %out, i64 %tid.ext
  %vgpr = load <2 x i16>, <2 x i16> addrspace(1)* %in.gep
  %result = shl <2 x i16> %vgpr, %sgpr
  store <2 x i16> %result, <2 x i16> addrspace(1)* %out.gep
  ret void
}

define amdgpu_kernel void @shl_s_v_v2i16(<2 x i16> addrspace(1)* %out, <2 x i16> addrspace(1)* %in, <2 x i16> %sgpr) #0 {
; GFX9-LABEL: shl_s_v_v2i16:
; GFX9:       ; %bb.0:
; GFX9-NEXT:    s_load_dwordx4 s[4:7], s[0:1], 0x24
; GFX9-NEXT:    s_load_dword s2, s[0:1], 0x34
; GFX9-NEXT:    v_lshlrev_b32_e32 v0, 2, v0
; GFX9-NEXT:    s_waitcnt lgkmcnt(0)
; GFX9-NEXT:    global_load_dword v1, v0, s[6:7]
; GFX9-NEXT:    s_waitcnt vmcnt(0)
; GFX9-NEXT:    v_pk_lshlrev_b16 v1, v1, s2
; GFX9-NEXT:    global_store_dword v0, v1, s[4:5]
; GFX9-NEXT:    s_endpgm
;
; VI-LABEL: shl_s_v_v2i16:
; VI:       ; %bb.0:
; VI-NEXT:    s_load_dwordx4 s[4:7], s[0:1], 0x24
; VI-NEXT:    s_load_dword s0, s[0:1], 0x34
; VI-NEXT:    v_lshlrev_b32_e32 v2, 2, v0
; VI-NEXT:    s_waitcnt lgkmcnt(0)
; VI-NEXT:    v_mov_b32_e32 v1, s7
; VI-NEXT:    v_add_u32_e32 v0, vcc, s6, v2
; VI-NEXT:    v_addc_u32_e32 v1, vcc, 0, v1, vcc
; VI-NEXT:    flat_load_dword v3, v[0:1]
; VI-NEXT:    s_lshr_b32 s1, s0, 16
; VI-NEXT:    v_add_u32_e32 v0, vcc, s4, v2
; VI-NEXT:    v_mov_b32_e32 v2, s1
; VI-NEXT:    v_mov_b32_e32 v1, s5
; VI-NEXT:    v_addc_u32_e32 v1, vcc, 0, v1, vcc
; VI-NEXT:    s_waitcnt vmcnt(0)
; VI-NEXT:    v_lshlrev_b16_e64 v4, v3, s0
; VI-NEXT:    v_lshlrev_b16_sdwa v2, v3, v2 dst_sel:WORD_1 dst_unused:UNUSED_PAD src0_sel:WORD_1 src1_sel:DWORD
; VI-NEXT:    v_or_b32_e32 v2, v4, v2
; VI-NEXT:    flat_store_dword v[0:1], v2
; VI-NEXT:    s_endpgm
;
; CI-LABEL: shl_s_v_v2i16:
; CI:       ; %bb.0:
; CI-NEXT:    s_load_dwordx4 s[4:7], s[0:1], 0x9
; CI-NEXT:    s_load_dword s8, s[0:1], 0xd
; CI-NEXT:    s_mov_b32 s3, 0xf000
; CI-NEXT:    s_mov_b32 s2, 0
; CI-NEXT:    v_lshlrev_b32_e32 v0, 2, v0
; CI-NEXT:    s_waitcnt lgkmcnt(0)
; CI-NEXT:    s_mov_b64 s[0:1], s[6:7]
; CI-NEXT:    v_mov_b32_e32 v1, 0
; CI-NEXT:    buffer_load_dword v2, v[0:1], s[0:3], 0 addr64
; CI-NEXT:    s_mov_b32 s0, 0xffff
; CI-NEXT:    s_lshr_b32 s1, s8, 16
; CI-NEXT:    s_mov_b64 s[6:7], s[2:3]
; CI-NEXT:    s_waitcnt vmcnt(0)
; CI-NEXT:    v_and_b32_e32 v3, s0, v2
; CI-NEXT:    v_lshrrev_b32_e32 v2, 16, v2
; CI-NEXT:    v_lshl_b32_e32 v2, s1, v2
; CI-NEXT:    v_lshl_b32_e32 v3, s8, v3
; CI-NEXT:    v_lshlrev_b32_e32 v2, 16, v2
; CI-NEXT:    v_and_b32_e32 v3, s0, v3
; CI-NEXT:    v_or_b32_e32 v2, v3, v2
; CI-NEXT:    buffer_store_dword v2, v[0:1], s[4:7], 0 addr64
; CI-NEXT:    s_endpgm
;
; GFX10-LABEL: shl_s_v_v2i16:
; GFX10:       ; %bb.0:
; GFX10-NEXT:    s_load_dwordx4 s[4:7], s[0:1], 0x24
; GFX10-NEXT:    v_lshlrev_b32_e32 v0, 2, v0
; GFX10-NEXT:    s_load_dword s0, s[0:1], 0x34
; GFX10-NEXT:    s_waitcnt lgkmcnt(0)
; GFX10-NEXT:    global_load_dword v1, v0, s[6:7]
; GFX10-NEXT:    s_waitcnt vmcnt(0)
; GFX10-NEXT:    v_pk_lshlrev_b16 v1, v1, s0
; GFX10-NEXT:    global_store_dword v0, v1, s[4:5]
; GFX10-NEXT:    s_endpgm
  %tid = call i32 @llvm.amdgcn.workitem.id.x()
  %tid.ext = sext i32 %tid to i64
  %in.gep = getelementptr inbounds <2 x i16>, <2 x i16> addrspace(1)* %in, i64 %tid.ext
  %out.gep = getelementptr inbounds <2 x i16>, <2 x i16> addrspace(1)* %out, i64 %tid.ext
  %vgpr = load <2 x i16>, <2 x i16> addrspace(1)* %in.gep
  %result = shl <2 x i16> %sgpr, %vgpr
  store <2 x i16> %result, <2 x i16> addrspace(1)* %out.gep
  ret void
}

define amdgpu_kernel void @shl_imm_v_v2i16(<2 x i16> addrspace(1)* %out, <2 x i16> addrspace(1)* %in) #0 {
; GFX9-LABEL: shl_imm_v_v2i16:
; GFX9:       ; %bb.0:
; GFX9-NEXT:    s_load_dwordx4 s[0:3], s[0:1], 0x24
; GFX9-NEXT:    v_lshlrev_b32_e32 v0, 2, v0
; GFX9-NEXT:    s_waitcnt lgkmcnt(0)
; GFX9-NEXT:    global_load_dword v1, v0, s[2:3]
; GFX9-NEXT:    s_waitcnt vmcnt(0)
; GFX9-NEXT:    v_pk_lshlrev_b16 v1, v1, 8 op_sel_hi:[1,0]
; GFX9-NEXT:    global_store_dword v0, v1, s[0:1]
; GFX9-NEXT:    s_endpgm
;
; VI-LABEL: shl_imm_v_v2i16:
; VI:       ; %bb.0:
; VI-NEXT:    s_load_dwordx4 s[0:3], s[0:1], 0x24
; VI-NEXT:    v_lshlrev_b32_e32 v2, 2, v0
; VI-NEXT:    v_mov_b32_e32 v4, 8
; VI-NEXT:    s_waitcnt lgkmcnt(0)
; VI-NEXT:    v_mov_b32_e32 v1, s3
; VI-NEXT:    v_add_u32_e32 v0, vcc, s2, v2
; VI-NEXT:    v_addc_u32_e32 v1, vcc, 0, v1, vcc
; VI-NEXT:    flat_load_dword v3, v[0:1]
; VI-NEXT:    v_add_u32_e32 v0, vcc, s0, v2
; VI-NEXT:    v_mov_b32_e32 v1, s1
; VI-NEXT:    v_addc_u32_e32 v1, vcc, 0, v1, vcc
; VI-NEXT:    s_waitcnt vmcnt(0)
; VI-NEXT:    v_lshlrev_b16_e64 v2, v3, 8
; VI-NEXT:    v_lshlrev_b16_sdwa v3, v3, v4 dst_sel:WORD_1 dst_unused:UNUSED_PAD src0_sel:WORD_1 src1_sel:DWORD
; VI-NEXT:    v_or_b32_e32 v2, v2, v3
; VI-NEXT:    flat_store_dword v[0:1], v2
; VI-NEXT:    s_endpgm
;
; CI-LABEL: shl_imm_v_v2i16:
; CI:       ; %bb.0:
; CI-NEXT:    s_load_dwordx4 s[4:7], s[0:1], 0x9
; CI-NEXT:    s_mov_b32 s3, 0xf000
; CI-NEXT:    s_mov_b32 s2, 0
; CI-NEXT:    v_lshlrev_b32_e32 v0, 2, v0
; CI-NEXT:    v_mov_b32_e32 v1, 0
; CI-NEXT:    s_waitcnt lgkmcnt(0)
; CI-NEXT:    s_mov_b64 s[0:1], s[6:7]
; CI-NEXT:    buffer_load_dword v2, v[0:1], s[0:3], 0 addr64
; CI-NEXT:    s_mov_b64 s[6:7], s[2:3]
; CI-NEXT:    s_waitcnt vmcnt(0)
; CI-NEXT:    v_and_b32_e32 v3, 0xffff, v2
; CI-NEXT:    v_lshrrev_b32_e32 v2, 16, v2
; CI-NEXT:    v_lshl_b32_e32 v2, 8, v2
; CI-NEXT:    v_lshl_b32_e32 v3, 8, v3
; CI-NEXT:    v_lshlrev_b32_e32 v2, 16, v2
; CI-NEXT:    v_and_b32_e32 v3, 0xfff8, v3
; CI-NEXT:    v_or_b32_e32 v2, v3, v2
; CI-NEXT:    buffer_store_dword v2, v[0:1], s[4:7], 0 addr64
; CI-NEXT:    s_endpgm
;
; GFX10-LABEL: shl_imm_v_v2i16:
; GFX10:       ; %bb.0:
; GFX10-NEXT:    s_load_dwordx4 s[0:3], s[0:1], 0x24
; GFX10-NEXT:    v_lshlrev_b32_e32 v0, 2, v0
; GFX10-NEXT:    s_waitcnt lgkmcnt(0)
; GFX10-NEXT:    global_load_dword v1, v0, s[2:3]
; GFX10-NEXT:    s_waitcnt vmcnt(0)
; GFX10-NEXT:    v_pk_lshlrev_b16 v1, v1, 8 op_sel_hi:[1,0]
; GFX10-NEXT:    global_store_dword v0, v1, s[0:1]
; GFX10-NEXT:    s_endpgm
  %tid = call i32 @llvm.amdgcn.workitem.id.x()
  %tid.ext = sext i32 %tid to i64
  %in.gep = getelementptr inbounds <2 x i16>, <2 x i16> addrspace(1)* %in, i64 %tid.ext
  %out.gep = getelementptr inbounds <2 x i16>, <2 x i16> addrspace(1)* %out, i64 %tid.ext
  %vgpr = load <2 x i16>, <2 x i16> addrspace(1)* %in.gep
  %result = shl <2 x i16> <i16 8, i16 8>, %vgpr
  store <2 x i16> %result, <2 x i16> addrspace(1)* %out.gep
  ret void
}

define amdgpu_kernel void @shl_v_imm_v2i16(<2 x i16> addrspace(1)* %out, <2 x i16> addrspace(1)* %in) #0 {
; GFX9-LABEL: shl_v_imm_v2i16:
; GFX9:       ; %bb.0:
; GFX9-NEXT:    s_load_dwordx4 s[0:3], s[0:1], 0x24
; GFX9-NEXT:    v_lshlrev_b32_e32 v0, 2, v0
; GFX9-NEXT:    s_waitcnt lgkmcnt(0)
; GFX9-NEXT:    global_load_dword v1, v0, s[2:3]
; GFX9-NEXT:    s_waitcnt vmcnt(0)
; GFX9-NEXT:    v_pk_lshlrev_b16 v1, 8, v1 op_sel_hi:[0,1]
; GFX9-NEXT:    global_store_dword v0, v1, s[0:1]
; GFX9-NEXT:    s_endpgm
;
; VI-LABEL: shl_v_imm_v2i16:
; VI:       ; %bb.0:
; VI-NEXT:    s_load_dwordx4 s[0:3], s[0:1], 0x24
; VI-NEXT:    v_lshlrev_b32_e32 v2, 2, v0
; VI-NEXT:    s_waitcnt lgkmcnt(0)
; VI-NEXT:    v_mov_b32_e32 v1, s3
; VI-NEXT:    v_add_u32_e32 v0, vcc, s2, v2
; VI-NEXT:    v_addc_u32_e32 v1, vcc, 0, v1, vcc
; VI-NEXT:    flat_load_dword v3, v[0:1]
; VI-NEXT:    v_add_u32_e32 v0, vcc, s0, v2
; VI-NEXT:    v_mov_b32_e32 v1, s1
; VI-NEXT:    v_addc_u32_e32 v1, vcc, 0, v1, vcc
; VI-NEXT:    s_waitcnt vmcnt(0)
; VI-NEXT:    v_lshlrev_b32_e32 v2, 8, v3
; VI-NEXT:    v_and_b32_e32 v2, 0xff000000, v2
; VI-NEXT:    v_lshlrev_b16_e32 v3, 8, v3
; VI-NEXT:    v_or_b32_e32 v2, v3, v2
; VI-NEXT:    flat_store_dword v[0:1], v2
; VI-NEXT:    s_endpgm
;
; CI-LABEL: shl_v_imm_v2i16:
; CI:       ; %bb.0:
; CI-NEXT:    s_load_dwordx4 s[4:7], s[0:1], 0x9
; CI-NEXT:    s_mov_b32 s3, 0xf000
; CI-NEXT:    s_mov_b32 s2, 0
; CI-NEXT:    v_lshlrev_b32_e32 v0, 2, v0
; CI-NEXT:    v_mov_b32_e32 v1, 0
; CI-NEXT:    s_waitcnt lgkmcnt(0)
; CI-NEXT:    s_mov_b64 s[0:1], s[6:7]
; CI-NEXT:    buffer_load_dword v2, v[0:1], s[0:3], 0 addr64
; CI-NEXT:    s_mov_b64 s[6:7], s[2:3]
; CI-NEXT:    s_waitcnt vmcnt(0)
; CI-NEXT:    v_lshlrev_b32_e32 v2, 8, v2
; CI-NEXT:    v_and_b32_e32 v2, 0xff00ff00, v2
; CI-NEXT:    buffer_store_dword v2, v[0:1], s[4:7], 0 addr64
; CI-NEXT:    s_endpgm
;
; GFX10-LABEL: shl_v_imm_v2i16:
; GFX10:       ; %bb.0:
; GFX10-NEXT:    s_load_dwordx4 s[0:3], s[0:1], 0x24
; GFX10-NEXT:    v_lshlrev_b32_e32 v0, 2, v0
; GFX10-NEXT:    s_waitcnt lgkmcnt(0)
; GFX10-NEXT:    global_load_dword v1, v0, s[2:3]
; GFX10-NEXT:    s_waitcnt vmcnt(0)
; GFX10-NEXT:    v_pk_lshlrev_b16 v1, 8, v1 op_sel_hi:[0,1]
; GFX10-NEXT:    global_store_dword v0, v1, s[0:1]
; GFX10-NEXT:    s_endpgm
  %tid = call i32 @llvm.amdgcn.workitem.id.x()
  %tid.ext = sext i32 %tid to i64
  %in.gep = getelementptr inbounds <2 x i16>, <2 x i16> addrspace(1)* %in, i64 %tid.ext
  %out.gep = getelementptr inbounds <2 x i16>, <2 x i16> addrspace(1)* %out, i64 %tid.ext
  %vgpr = load <2 x i16>, <2 x i16> addrspace(1)* %in.gep
  %result = shl <2 x i16> %vgpr, <i16 8, i16 8>
  store <2 x i16> %result, <2 x i16> addrspace(1)* %out.gep
  ret void
}

define amdgpu_kernel void @v_shl_v4i16(<4 x i16> addrspace(1)* %out, <4 x i16> addrspace(1)* %in) #0 {
; GFX9-LABEL: v_shl_v4i16:
; GFX9:       ; %bb.0:
; GFX9-NEXT:    s_load_dwordx4 s[0:3], s[0:1], 0x24
; GFX9-NEXT:    v_lshlrev_b32_e32 v4, 3, v0
; GFX9-NEXT:    s_waitcnt lgkmcnt(0)
; GFX9-NEXT:    global_load_dwordx2 v[0:1], v4, s[2:3]
; GFX9-NEXT:    global_load_dwordx2 v[2:3], v4, s[2:3] offset:8
; GFX9-NEXT:    s_waitcnt vmcnt(0)
; GFX9-NEXT:    v_pk_lshlrev_b16 v1, v3, v1
; GFX9-NEXT:    v_pk_lshlrev_b16 v0, v2, v0
; GFX9-NEXT:    global_store_dwordx2 v4, v[0:1], s[0:1]
; GFX9-NEXT:    s_endpgm
;
; VI-LABEL: v_shl_v4i16:
; VI:       ; %bb.0:
; VI-NEXT:    s_load_dwordx4 s[0:3], s[0:1], 0x24
; VI-NEXT:    v_lshlrev_b32_e32 v4, 3, v0
; VI-NEXT:    s_waitcnt lgkmcnt(0)
; VI-NEXT:    v_mov_b32_e32 v1, s3
; VI-NEXT:    v_add_u32_e32 v0, vcc, s2, v4
; VI-NEXT:    v_addc_u32_e32 v1, vcc, 0, v1, vcc
; VI-NEXT:    v_add_u32_e32 v2, vcc, 8, v0
; VI-NEXT:    v_addc_u32_e32 v3, vcc, 0, v1, vcc
; VI-NEXT:    flat_load_dwordx2 v[0:1], v[0:1]
; VI-NEXT:    flat_load_dwordx2 v[2:3], v[2:3]
; VI-NEXT:    v_mov_b32_e32 v5, s1
; VI-NEXT:    v_add_u32_e32 v4, vcc, s0, v4
; VI-NEXT:    v_addc_u32_e32 v5, vcc, 0, v5, vcc
; VI-NEXT:    s_waitcnt vmcnt(0)
; VI-NEXT:    v_lshlrev_b16_e32 v6, v3, v1
; VI-NEXT:    v_lshlrev_b16_sdwa v1, v3, v1 dst_sel:WORD_1 dst_unused:UNUSED_PAD src0_sel:WORD_1 src1_sel:WORD_1
; VI-NEXT:    v_lshlrev_b16_e32 v3, v2, v0
; VI-NEXT:    v_lshlrev_b16_sdwa v0, v2, v0 dst_sel:WORD_1 dst_unused:UNUSED_PAD src0_sel:WORD_1 src1_sel:WORD_1
; VI-NEXT:    v_or_b32_e32 v1, v6, v1
; VI-NEXT:    v_or_b32_e32 v0, v3, v0
; VI-NEXT:    flat_store_dwordx2 v[4:5], v[0:1]
; VI-NEXT:    s_endpgm
;
; CI-LABEL: v_shl_v4i16:
; CI:       ; %bb.0:
; CI-NEXT:    s_load_dwordx4 s[4:7], s[0:1], 0x9
; CI-NEXT:    s_mov_b32 s3, 0xf000
; CI-NEXT:    s_mov_b32 s2, 0
; CI-NEXT:    v_lshlrev_b32_e32 v0, 3, v0
; CI-NEXT:    v_mov_b32_e32 v1, 0
; CI-NEXT:    s_waitcnt lgkmcnt(0)
; CI-NEXT:    s_mov_b64 s[0:1], s[6:7]
; CI-NEXT:    buffer_load_dwordx2 v[2:3], v[0:1], s[0:3], 0 addr64
; CI-NEXT:    buffer_load_dwordx2 v[4:5], v[0:1], s[0:3], 0 addr64 offset:8
; CI-NEXT:    s_mov_b32 s0, 0xffff
; CI-NEXT:    s_mov_b64 s[6:7], s[2:3]
; CI-NEXT:    s_waitcnt vmcnt(1)
; CI-NEXT:    v_lshrrev_b32_e32 v6, 16, v2
; CI-NEXT:    s_waitcnt vmcnt(0)
; CI-NEXT:    v_and_b32_e32 v8, s0, v4
; CI-NEXT:    v_lshrrev_b32_e32 v4, 16, v4
; CI-NEXT:    v_and_b32_e32 v9, s0, v5
; CI-NEXT:    v_lshrrev_b32_e32 v7, 16, v3
; CI-NEXT:    v_lshrrev_b32_e32 v5, 16, v5
; CI-NEXT:    v_lshl_b32_e32 v5, v7, v5
; CI-NEXT:    v_lshl_b32_e32 v3, v3, v9
; CI-NEXT:    v_lshl_b32_e32 v4, v6, v4
; CI-NEXT:    v_lshl_b32_e32 v2, v2, v8
; CI-NEXT:    v_lshlrev_b32_e32 v5, 16, v5
; CI-NEXT:    v_and_b32_e32 v3, s0, v3
; CI-NEXT:    v_lshlrev_b32_e32 v4, 16, v4
; CI-NEXT:    v_and_b32_e32 v2, s0, v2
; CI-NEXT:    v_or_b32_e32 v3, v3, v5
; CI-NEXT:    v_or_b32_e32 v2, v2, v4
; CI-NEXT:    buffer_store_dwordx2 v[2:3], v[0:1], s[4:7], 0 addr64
; CI-NEXT:    s_endpgm
;
; GFX10-LABEL: v_shl_v4i16:
; GFX10:       ; %bb.0:
; GFX10-NEXT:    s_load_dwordx4 s[0:3], s[0:1], 0x24
; GFX10-NEXT:    v_lshlrev_b32_e32 v4, 3, v0
; GFX10-NEXT:    s_waitcnt lgkmcnt(0)
; GFX10-NEXT:    s_clause 0x1
; GFX10-NEXT:    global_load_dwordx2 v[0:1], v4, s[2:3]
; GFX10-NEXT:    global_load_dwordx2 v[2:3], v4, s[2:3] offset:8
; GFX10-NEXT:    s_waitcnt vmcnt(0)
; GFX10-NEXT:    v_pk_lshlrev_b16 v1, v3, v1
; GFX10-NEXT:    v_pk_lshlrev_b16 v0, v2, v0
; GFX10-NEXT:    global_store_dwordx2 v4, v[0:1], s[0:1]
; GFX10-NEXT:    s_endpgm
  %tid = call i32 @llvm.amdgcn.workitem.id.x()
  %tid.ext = sext i32 %tid to i64
  %in.gep = getelementptr inbounds <4 x i16>, <4 x i16> addrspace(1)* %in, i64 %tid.ext
  %out.gep = getelementptr inbounds <4 x i16>, <4 x i16> addrspace(1)* %out, i64 %tid.ext
  %b_ptr = getelementptr <4 x i16>, <4 x i16> addrspace(1)* %in.gep, i32 1
  %a = load <4 x i16>, <4 x i16> addrspace(1)* %in.gep
  %b = load <4 x i16>, <4 x i16> addrspace(1)* %b_ptr
  %result = shl <4 x i16> %a, %b
  store <4 x i16> %result, <4 x i16> addrspace(1)* %out.gep
  ret void
}

define amdgpu_kernel void @shl_v_imm_v4i16(<4 x i16> addrspace(1)* %out, <4 x i16> addrspace(1)* %in) #0 {
; GFX9-LABEL: shl_v_imm_v4i16:
; GFX9:       ; %bb.0:
; GFX9-NEXT:    s_load_dwordx4 s[0:3], s[0:1], 0x24
; GFX9-NEXT:    v_lshlrev_b32_e32 v2, 3, v0
; GFX9-NEXT:    s_waitcnt lgkmcnt(0)
; GFX9-NEXT:    global_load_dwordx2 v[0:1], v2, s[2:3]
; GFX9-NEXT:    s_waitcnt vmcnt(0)
; GFX9-NEXT:    v_pk_lshlrev_b16 v1, 8, v1 op_sel_hi:[0,1]
; GFX9-NEXT:    v_pk_lshlrev_b16 v0, 8, v0 op_sel_hi:[0,1]
; GFX9-NEXT:    global_store_dwordx2 v2, v[0:1], s[0:1]
; GFX9-NEXT:    s_endpgm
;
; VI-LABEL: shl_v_imm_v4i16:
; VI:       ; %bb.0:
; VI-NEXT:    s_load_dwordx4 s[0:3], s[0:1], 0x24
; VI-NEXT:    v_lshlrev_b32_e32 v2, 3, v0
; VI-NEXT:    s_waitcnt lgkmcnt(0)
; VI-NEXT:    v_add_u32_e32 v0, vcc, s2, v2
; VI-NEXT:    v_mov_b32_e32 v1, s3
; VI-NEXT:    v_addc_u32_e32 v1, vcc, 0, v1, vcc
; VI-NEXT:    flat_load_dwordx2 v[0:1], v[0:1]
; VI-NEXT:    s_mov_b32 s2, 0xff000000
; VI-NEXT:    v_mov_b32_e32 v3, s1
; VI-NEXT:    v_add_u32_e32 v2, vcc, s0, v2
; VI-NEXT:    v_addc_u32_e32 v3, vcc, 0, v3, vcc
; VI-NEXT:    s_waitcnt vmcnt(0)
; VI-NEXT:    v_lshlrev_b32_e32 v4, 8, v1
; VI-NEXT:    v_lshlrev_b16_e32 v5, 8, v0
; VI-NEXT:    v_lshlrev_b32_e32 v0, 8, v0
; VI-NEXT:    v_and_b32_e32 v0, s2, v0
; VI-NEXT:    v_lshlrev_b16_e32 v1, 8, v1
; VI-NEXT:    v_and_b32_e32 v4, s2, v4
; VI-NEXT:    v_or_b32_e32 v1, v1, v4
; VI-NEXT:    v_or_b32_e32 v0, v5, v0
; VI-NEXT:    flat_store_dwordx2 v[2:3], v[0:1]
; VI-NEXT:    s_endpgm
;
; CI-LABEL: shl_v_imm_v4i16:
; CI:       ; %bb.0:
; CI-NEXT:    s_load_dwordx4 s[4:7], s[0:1], 0x9
; CI-NEXT:    s_mov_b32 s3, 0xf000
; CI-NEXT:    s_mov_b32 s2, 0
; CI-NEXT:    v_lshlrev_b32_e32 v0, 3, v0
; CI-NEXT:    v_mov_b32_e32 v1, 0
; CI-NEXT:    s_waitcnt lgkmcnt(0)
; CI-NEXT:    s_mov_b64 s[0:1], s[6:7]
; CI-NEXT:    buffer_load_dwordx2 v[2:3], v[0:1], s[0:3], 0 addr64
; CI-NEXT:    s_mov_b32 s0, 0xff00
; CI-NEXT:    s_mov_b64 s[6:7], s[2:3]
; CI-NEXT:    s_waitcnt vmcnt(0)
; CI-NEXT:    v_lshrrev_b32_e32 v4, 8, v3
; CI-NEXT:    v_lshlrev_b32_e32 v3, 8, v3
; CI-NEXT:    v_and_b32_e32 v4, s0, v4
; CI-NEXT:    v_lshlrev_b32_e32 v2, 8, v2
; CI-NEXT:    v_and_b32_e32 v3, s0, v3
; CI-NEXT:    v_lshlrev_b32_e32 v4, 16, v4
; CI-NEXT:    v_or_b32_e32 v3, v3, v4
; CI-NEXT:    v_and_b32_e32 v2, 0xff00ff00, v2
; CI-NEXT:    buffer_store_dwordx2 v[2:3], v[0:1], s[4:7], 0 addr64
; CI-NEXT:    s_endpgm
;
; GFX10-LABEL: shl_v_imm_v4i16:
; GFX10:       ; %bb.0:
; GFX10-NEXT:    s_load_dwordx4 s[0:3], s[0:1], 0x24
; GFX10-NEXT:    v_lshlrev_b32_e32 v2, 3, v0
; GFX10-NEXT:    s_waitcnt lgkmcnt(0)
; GFX10-NEXT:    global_load_dwordx2 v[0:1], v2, s[2:3]
; GFX10-NEXT:    s_waitcnt vmcnt(0)
; GFX10-NEXT:    v_pk_lshlrev_b16 v1, 8, v1 op_sel_hi:[0,1]
; GFX10-NEXT:    v_pk_lshlrev_b16 v0, 8, v0 op_sel_hi:[0,1]
; GFX10-NEXT:    global_store_dwordx2 v2, v[0:1], s[0:1]
; GFX10-NEXT:    s_endpgm
  %tid = call i32 @llvm.amdgcn.workitem.id.x()
  %tid.ext = sext i32 %tid to i64
  %in.gep = getelementptr inbounds <4 x i16>, <4 x i16> addrspace(1)* %in, i64 %tid.ext
  %out.gep = getelementptr inbounds <4 x i16>, <4 x i16> addrspace(1)* %out, i64 %tid.ext
  %vgpr = load <4 x i16>, <4 x i16> addrspace(1)* %in.gep
  %result = shl <4 x i16> %vgpr, <i16 8, i16 8, i16 8, i16 8>
  store <4 x i16> %result, <4 x i16> addrspace(1)* %out.gep
  ret void
}

declare i32 @llvm.amdgcn.workitem.id.x() #1

attributes #0 = { nounwind }
attributes #1 = { nounwind readnone }
