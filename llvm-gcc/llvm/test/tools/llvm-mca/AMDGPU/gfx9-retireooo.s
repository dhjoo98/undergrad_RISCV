# NOTE: Assertions have been autogenerated by utils/update_mca_test_checks.py
# RUN: llvm-mca -mtriple=amdgcn -mcpu=gfx900 --timeline --iterations=1 --timeline-max-cycles=0 < %s | FileCheck %s

s_load_dwordx2 s[2:3], s[0:1], 0x24
s_load_dwordx2 s[0:1], s[0:1], 0x2c
s_waitcnt lgkmcnt(0)
v_mov_b32_e32 v0, s2
v_mov_b32_e32 v1, s3
flat_load_dword v2, v[0:1]
flat_load_dword v3, v[0:1] offset:8
flat_load_dword v4, v[0:1] offset:16
flat_load_dword v5, v[0:1] offset:24
v_mov_b32_e32 v0, s0
v_mov_b32_e32 v1, s1
v_mov_b32_e32 v6, s6
v_mov_b32_e32 v7, s7
v_mov_b32_e32 v8, s8
v_mov_b32_e32 v9, s9
v_mov_b32_e32 v10, s10
v_mov_b32_e32 v11, s11
v_mov_b32_e32 v12, s12
v_mov_b32_e32 v13, s13
v_mov_b32_e32 v14, s14
v_mov_b32_e32 v15, s15
v_mov_b32_e32 v16, s16
v_mov_b32_e32 v17, s17
v_mov_b32_e32 v18, s18
v_mov_b32_e32 v19, s19
v_mov_b32_e32 v20, s20
v_mov_b32_e32 v21, s21
v_mov_b32_e32 v22, s22
v_mov_b32_e32 v23, s23
v_mov_b32_e32 v24, s24
v_mov_b32_e32 v25, s25
v_mov_b32_e32 v26, s26
v_mov_b32_e32 v27, s27
v_mov_b32_e32 v28, s28
v_mov_b32_e32 v29, s29
s_waitcnt vmcnt(0) lgkmcnt(0)

# CHECK:      Iterations:        1
# CHECK-NEXT: Instructions:      36
# CHECK-NEXT: Total Cycles:      331
# CHECK-NEXT: Total uOps:        36

# CHECK:      Dispatch Width:    1
# CHECK-NEXT: uOps Per Cycle:    0.11
# CHECK-NEXT: IPC:               0.11
# CHECK-NEXT: Block RThroughput: 36.0

# CHECK:      Instruction Info:
# CHECK-NEXT: [1]: #uOps
# CHECK-NEXT: [2]: Latency
# CHECK-NEXT: [3]: RThroughput
# CHECK-NEXT: [4]: MayLoad
# CHECK-NEXT: [5]: MayStore
# CHECK-NEXT: [6]: HasSideEffects (U)

# CHECK:      [1]    [2]    [3]    [4]    [5]    [6]    Instructions:
# CHECK-NEXT:  1      5     1.00    *                   s_load_dwordx2 s[2:3], s[0:1], 0x24
# CHECK-NEXT:  1      5     1.00    *                   s_load_dwordx2 s[0:1], s[0:1], 0x2c
# CHECK-NEXT:  1      1     1.00                  U     s_waitcnt lgkmcnt(0)
# CHECK-NEXT:  1      1     1.00                  U     v_mov_b32_e32 v0, s2
# CHECK-NEXT:  1      1     1.00                  U     v_mov_b32_e32 v1, s3
# CHECK-NEXT:  1      80    1.00    *             U     flat_load_dword v2, v[0:1]
# CHECK-NEXT:  1      80    1.00    *             U     flat_load_dword v3, v[0:1] offset:8
# CHECK-NEXT:  1      80    1.00    *             U     flat_load_dword v4, v[0:1] offset:16
# CHECK-NEXT:  1      80    1.00    *             U     flat_load_dword v5, v[0:1] offset:24
# CHECK-NEXT:  1      1     1.00                  U     v_mov_b32_e32 v0, s0
# CHECK-NEXT:  1      1     1.00                  U     v_mov_b32_e32 v1, s1
# CHECK-NEXT:  1      1     1.00                  U     v_mov_b32_e32 v6, s6
# CHECK-NEXT:  1      1     1.00                  U     v_mov_b32_e32 v7, s7
# CHECK-NEXT:  1      1     1.00                  U     v_mov_b32_e32 v8, s8
# CHECK-NEXT:  1      1     1.00                  U     v_mov_b32_e32 v9, s9
# CHECK-NEXT:  1      1     1.00                  U     v_mov_b32_e32 v10, s10
# CHECK-NEXT:  1      1     1.00                  U     v_mov_b32_e32 v11, s11
# CHECK-NEXT:  1      1     1.00                  U     v_mov_b32_e32 v12, s12
# CHECK-NEXT:  1      1     1.00                  U     v_mov_b32_e32 v13, s13
# CHECK-NEXT:  1      1     1.00                  U     v_mov_b32_e32 v14, s14
# CHECK-NEXT:  1      1     1.00                  U     v_mov_b32_e32 v15, s15
# CHECK-NEXT:  1      1     1.00                  U     v_mov_b32_e32 v16, s16
# CHECK-NEXT:  1      1     1.00                  U     v_mov_b32_e32 v17, s17
# CHECK-NEXT:  1      1     1.00                  U     v_mov_b32_e32 v18, s18
# CHECK-NEXT:  1      1     1.00                  U     v_mov_b32_e32 v19, s19
# CHECK-NEXT:  1      1     1.00                  U     v_mov_b32_e32 v20, s20
# CHECK-NEXT:  1      1     1.00                  U     v_mov_b32_e32 v21, s21
# CHECK-NEXT:  1      1     1.00                  U     v_mov_b32_e32 v22, s22
# CHECK-NEXT:  1      1     1.00                  U     v_mov_b32_e32 v23, s23
# CHECK-NEXT:  1      1     1.00                  U     v_mov_b32_e32 v24, s24
# CHECK-NEXT:  1      1     1.00                  U     v_mov_b32_e32 v25, s25
# CHECK-NEXT:  1      1     1.00                  U     v_mov_b32_e32 v26, s26
# CHECK-NEXT:  1      1     1.00                  U     v_mov_b32_e32 v27, s27
# CHECK-NEXT:  1      1     1.00                  U     v_mov_b32_e32 v28, s28
# CHECK-NEXT:  1      1     1.00                  U     v_mov_b32_e32 v29, s29
# CHECK-NEXT:  1      1     1.00                  U     s_waitcnt vmcnt(0) lgkmcnt(0)

# CHECK:      Resources:
# CHECK-NEXT: [0]   - HWBranch
# CHECK-NEXT: [1]   - HWExport
# CHECK-NEXT: [2]   - HWLGKM
# CHECK-NEXT: [3]   - HWSALU
# CHECK-NEXT: [4]   - HWVALU
# CHECK-NEXT: [5]   - HWVMEM
# CHECK-NEXT: [6]   - HWXDL

# CHECK:      Resource pressure per iteration:
# CHECK-NEXT: [0]    [1]    [2]    [3]    [4]    [5]    [6]
# CHECK-NEXT:  -      -     2.00   2.00   28.00  4.00    -

# CHECK:      Resource pressure by instruction:
# CHECK-NEXT: [0]    [1]    [2]    [3]    [4]    [5]    [6]    Instructions:
# CHECK-NEXT:  -      -     1.00    -      -      -      -     s_load_dwordx2 s[2:3], s[0:1], 0x24
# CHECK-NEXT:  -      -     1.00    -      -      -      -     s_load_dwordx2 s[0:1], s[0:1], 0x2c
# CHECK-NEXT:  -      -      -     1.00    -      -      -     s_waitcnt lgkmcnt(0)
# CHECK-NEXT:  -      -      -      -     1.00    -      -     v_mov_b32_e32 v0, s2
# CHECK-NEXT:  -      -      -      -     1.00    -      -     v_mov_b32_e32 v1, s3
# CHECK-NEXT:  -      -      -      -      -     1.00    -     flat_load_dword v2, v[0:1]
# CHECK-NEXT:  -      -      -      -      -     1.00    -     flat_load_dword v3, v[0:1] offset:8
# CHECK-NEXT:  -      -      -      -      -     1.00    -     flat_load_dword v4, v[0:1] offset:16
# CHECK-NEXT:  -      -      -      -      -     1.00    -     flat_load_dword v5, v[0:1] offset:24
# CHECK-NEXT:  -      -      -      -     1.00    -      -     v_mov_b32_e32 v0, s0
# CHECK-NEXT:  -      -      -      -     1.00    -      -     v_mov_b32_e32 v1, s1
# CHECK-NEXT:  -      -      -      -     1.00    -      -     v_mov_b32_e32 v6, s6
# CHECK-NEXT:  -      -      -      -     1.00    -      -     v_mov_b32_e32 v7, s7
# CHECK-NEXT:  -      -      -      -     1.00    -      -     v_mov_b32_e32 v8, s8
# CHECK-NEXT:  -      -      -      -     1.00    -      -     v_mov_b32_e32 v9, s9
# CHECK-NEXT:  -      -      -      -     1.00    -      -     v_mov_b32_e32 v10, s10
# CHECK-NEXT:  -      -      -      -     1.00    -      -     v_mov_b32_e32 v11, s11
# CHECK-NEXT:  -      -      -      -     1.00    -      -     v_mov_b32_e32 v12, s12
# CHECK-NEXT:  -      -      -      -     1.00    -      -     v_mov_b32_e32 v13, s13
# CHECK-NEXT:  -      -      -      -     1.00    -      -     v_mov_b32_e32 v14, s14
# CHECK-NEXT:  -      -      -      -     1.00    -      -     v_mov_b32_e32 v15, s15
# CHECK-NEXT:  -      -      -      -     1.00    -      -     v_mov_b32_e32 v16, s16
# CHECK-NEXT:  -      -      -      -     1.00    -      -     v_mov_b32_e32 v17, s17
# CHECK-NEXT:  -      -      -      -     1.00    -      -     v_mov_b32_e32 v18, s18
# CHECK-NEXT:  -      -      -      -     1.00    -      -     v_mov_b32_e32 v19, s19
# CHECK-NEXT:  -      -      -      -     1.00    -      -     v_mov_b32_e32 v20, s20
# CHECK-NEXT:  -      -      -      -     1.00    -      -     v_mov_b32_e32 v21, s21
# CHECK-NEXT:  -      -      -      -     1.00    -      -     v_mov_b32_e32 v22, s22
# CHECK-NEXT:  -      -      -      -     1.00    -      -     v_mov_b32_e32 v23, s23
# CHECK-NEXT:  -      -      -      -     1.00    -      -     v_mov_b32_e32 v24, s24
# CHECK-NEXT:  -      -      -      -     1.00    -      -     v_mov_b32_e32 v25, s25
# CHECK-NEXT:  -      -      -      -     1.00    -      -     v_mov_b32_e32 v26, s26
# CHECK-NEXT:  -      -      -      -     1.00    -      -     v_mov_b32_e32 v27, s27
# CHECK-NEXT:  -      -      -      -     1.00    -      -     v_mov_b32_e32 v28, s28
# CHECK-NEXT:  -      -      -      -     1.00    -      -     v_mov_b32_e32 v29, s29
# CHECK-NEXT:  -      -      -     1.00    -      -      -     s_waitcnt vmcnt(0) lgkmcnt(0)

# CHECK:      Timeline view:
# CHECK-NEXT:                     0123456789          0123456789          0123456789          0123456789          0123456789          0123456789          0123456789          0123456789          0123456789          0123456789          0123456789          0123456789          0123456789          0123456789          0123456789          0123456789          0
# CHECK-NEXT: Index     0123456789          0123456789          0123456789          0123456789          0123456789          0123456789          0123456789          0123456789          0123456789          0123456789          0123456789          0123456789          0123456789          0123456789          0123456789          0123456789          0123456789

# CHECK:      [0,0]     DeeeeE    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .   s_load_dwordx2 s[2:3], s[0:1], 0x24
# CHECK-NEXT: [0,1]     .DeeeeE   .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .   s_load_dwordx2 s[0:1], s[0:1], 0x2c
# CHECK-NEXT: [0,2]     .    .DE  .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .   s_waitcnt lgkmcnt(0)
# CHECK-NEXT: [0,3]     .    . DE .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .   v_mov_b32_e32 v0, s2
# CHECK-NEXT: [0,4]     .    .  DE.    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .   v_mov_b32_e32 v1, s3
# CHECK-NEXT: [0,5]     .    .   DeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeE.    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .   flat_load_dword v2, v[0:1]
# CHECK-NEXT: [0,6]     .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .   DeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeE.    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .   flat_load_dword v3, v[0:1] offset:8
# CHECK-NEXT: [0,7]     .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .   DeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeE.    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .   flat_load_dword v4, v[0:1] offset:16
# CHECK-NEXT: [0,8]     .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .   DeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeE.   flat_load_dword v5, v[0:1] offset:24
# CHECK-NEXT: [0,9]     .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    DE   .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .   v_mov_b32_e32 v0, s0
# CHECK-NEXT: [0,10]    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .DE  .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .   v_mov_b32_e32 v1, s1
# CHECK-NEXT: [0,11]    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    . DE .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .   v_mov_b32_e32 v6, s6
# CHECK-NEXT: [0,12]    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .  DE.    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .   v_mov_b32_e32 v7, s7
# CHECK-NEXT: [0,13]    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .   DE    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .   v_mov_b32_e32 v8, s8
# CHECK-NEXT: [0,14]    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    DE   .    .    .    .    .    .    .    .    .    .    .    .    .    .    .   v_mov_b32_e32 v9, s9
# CHECK-NEXT: [0,15]    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .DE  .    .    .    .    .    .    .    .    .    .    .    .    .    .    .   v_mov_b32_e32 v10, s10
# CHECK-NEXT: [0,16]    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    . DE .    .    .    .    .    .    .    .    .    .    .    .    .    .    .   v_mov_b32_e32 v11, s11
# CHECK-NEXT: [0,17]    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .  DE.    .    .    .    .    .    .    .    .    .    .    .    .    .    .   v_mov_b32_e32 v12, s12
# CHECK-NEXT: [0,18]    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .   DE    .    .    .    .    .    .    .    .    .    .    .    .    .    .   v_mov_b32_e32 v13, s13
# CHECK-NEXT: [0,19]    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    DE   .    .    .    .    .    .    .    .    .    .    .    .    .    .   v_mov_b32_e32 v14, s14
# CHECK-NEXT: [0,20]    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .DE  .    .    .    .    .    .    .    .    .    .    .    .    .    .   v_mov_b32_e32 v15, s15
# CHECK-NEXT: [0,21]    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    . DE .    .    .    .    .    .    .    .    .    .    .    .    .    .   v_mov_b32_e32 v16, s16
# CHECK-NEXT: [0,22]    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .  DE.    .    .    .    .    .    .    .    .    .    .    .    .    .   v_mov_b32_e32 v17, s17
# CHECK-NEXT: [0,23]    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .   DE    .    .    .    .    .    .    .    .    .    .    .    .    .   v_mov_b32_e32 v18, s18
# CHECK-NEXT: [0,24]    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    DE   .    .    .    .    .    .    .    .    .    .    .    .    .   v_mov_b32_e32 v19, s19
# CHECK-NEXT: [0,25]    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .DE  .    .    .    .    .    .    .    .    .    .    .    .    .   v_mov_b32_e32 v20, s20
# CHECK-NEXT: [0,26]    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    . DE .    .    .    .    .    .    .    .    .    .    .    .    .   v_mov_b32_e32 v21, s21
# CHECK-NEXT: [0,27]    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .  DE.    .    .    .    .    .    .    .    .    .    .    .    .   v_mov_b32_e32 v22, s22
# CHECK-NEXT: [0,28]    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .   DE    .    .    .    .    .    .    .    .    .    .    .    .   v_mov_b32_e32 v23, s23
# CHECK-NEXT: [0,29]    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    DE   .    .    .    .    .    .    .    .    .    .    .    .   v_mov_b32_e32 v24, s24
# CHECK-NEXT: [0,30]    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .DE  .    .    .    .    .    .    .    .    .    .    .    .   v_mov_b32_e32 v25, s25
# CHECK-NEXT: [0,31]    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    . DE .    .    .    .    .    .    .    .    .    .    .    .   v_mov_b32_e32 v26, s26
# CHECK-NEXT: [0,32]    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .  DE.    .    .    .    .    .    .    .    .    .    .    .   v_mov_b32_e32 v27, s27
# CHECK-NEXT: [0,33]    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .   DE    .    .    .    .    .    .    .    .    .    .    .   v_mov_b32_e32 v28, s28
# CHECK-NEXT: [0,34]    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    DE   .    .    .    .    .    .    .    .    .    .    .   v_mov_b32_e32 v29, s29
# CHECK-NEXT: [0,35]    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .   DE   s_waitcnt vmcnt(0) lgkmcnt(0)

# CHECK:      Average Wait times (based on the timeline view):
# CHECK-NEXT: [0]: Executions
# CHECK-NEXT: [1]: Average time spent waiting in a scheduler's queue
# CHECK-NEXT: [2]: Average time spent waiting in a scheduler's queue while ready
# CHECK-NEXT: [3]: Average time elapsed from WB until retire stage

# CHECK:            [0]    [1]    [2]    [3]
# CHECK-NEXT: 0.     1     0.0    0.0    0.0       s_load_dwordx2 s[2:3], s[0:1], 0x24
# CHECK-NEXT: 1.     1     0.0    0.0    0.0       s_load_dwordx2 s[0:1], s[0:1], 0x2c
# CHECK-NEXT: 2.     1     0.0    0.0    0.0       s_waitcnt lgkmcnt(0)
# CHECK-NEXT: 3.     1     0.0    0.0    0.0       v_mov_b32_e32 v0, s2
# CHECK-NEXT: 4.     1     0.0    0.0    0.0       v_mov_b32_e32 v1, s3
# CHECK-NEXT: 5.     1     0.0    0.0    0.0       flat_load_dword v2, v[0:1]
# CHECK-NEXT: 6.     1     0.0    0.0    0.0       flat_load_dword v3, v[0:1] offset:8
# CHECK-NEXT: 7.     1     0.0    0.0    0.0       flat_load_dword v4, v[0:1] offset:16
# CHECK-NEXT: 8.     1     0.0    0.0    0.0       flat_load_dword v5, v[0:1] offset:24
# CHECK-NEXT: 9.     1     0.0    0.0    0.0       v_mov_b32_e32 v0, s0
# CHECK-NEXT: 10.    1     0.0    0.0    0.0       v_mov_b32_e32 v1, s1
# CHECK-NEXT: 11.    1     0.0    0.0    0.0       v_mov_b32_e32 v6, s6
# CHECK-NEXT: 12.    1     0.0    0.0    0.0       v_mov_b32_e32 v7, s7
# CHECK-NEXT: 13.    1     0.0    0.0    0.0       v_mov_b32_e32 v8, s8
# CHECK-NEXT: 14.    1     0.0    0.0    0.0       v_mov_b32_e32 v9, s9
# CHECK-NEXT: 15.    1     0.0    0.0    0.0       v_mov_b32_e32 v10, s10
# CHECK-NEXT: 16.    1     0.0    0.0    0.0       v_mov_b32_e32 v11, s11
# CHECK-NEXT: 17.    1     0.0    0.0    0.0       v_mov_b32_e32 v12, s12
# CHECK-NEXT: 18.    1     0.0    0.0    0.0       v_mov_b32_e32 v13, s13
# CHECK-NEXT: 19.    1     0.0    0.0    0.0       v_mov_b32_e32 v14, s14
# CHECK-NEXT: 20.    1     0.0    0.0    0.0       v_mov_b32_e32 v15, s15
# CHECK-NEXT: 21.    1     0.0    0.0    0.0       v_mov_b32_e32 v16, s16
# CHECK-NEXT: 22.    1     0.0    0.0    0.0       v_mov_b32_e32 v17, s17
# CHECK-NEXT: 23.    1     0.0    0.0    0.0       v_mov_b32_e32 v18, s18
# CHECK-NEXT: 24.    1     0.0    0.0    0.0       v_mov_b32_e32 v19, s19
# CHECK-NEXT: 25.    1     0.0    0.0    0.0       v_mov_b32_e32 v20, s20
# CHECK-NEXT: 26.    1     0.0    0.0    0.0       v_mov_b32_e32 v21, s21
# CHECK-NEXT: 27.    1     0.0    0.0    0.0       v_mov_b32_e32 v22, s22
# CHECK-NEXT: 28.    1     0.0    0.0    0.0       v_mov_b32_e32 v23, s23
# CHECK-NEXT: 29.    1     0.0    0.0    0.0       v_mov_b32_e32 v24, s24
# CHECK-NEXT: 30.    1     0.0    0.0    0.0       v_mov_b32_e32 v25, s25
# CHECK-NEXT: 31.    1     0.0    0.0    0.0       v_mov_b32_e32 v26, s26
# CHECK-NEXT: 32.    1     0.0    0.0    0.0       v_mov_b32_e32 v27, s27
# CHECK-NEXT: 33.    1     0.0    0.0    0.0       v_mov_b32_e32 v28, s28
# CHECK-NEXT: 34.    1     0.0    0.0    0.0       v_mov_b32_e32 v29, s29
# CHECK-NEXT: 35.    1     0.0    0.0    0.0       s_waitcnt vmcnt(0) lgkmcnt(0)
# CHECK-NEXT:        1     0.0    0.0    0.0       <total>
