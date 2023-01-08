; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -verify-machineinstrs < %s \
; RUN:   | FileCheck %s -check-prefix=RV32I
; RUN: llc -mtriple=riscv32 -mattr=+experimental-b -verify-machineinstrs < %s \
; RUN:   | FileCheck %s -check-prefix=RV32B
; RUN: llc -mtriple=riscv32 -mattr=+experimental-zbb -verify-machineinstrs < %s \
; RUN:   | FileCheck %s -check-prefix=RV32ZBB

declare i32 @llvm.ctlz.i32(i32, i1)

define i32 @ctlz_i32(i32 %a) nounwind {
; RV32I-LABEL: ctlz_i32:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi sp, sp, -16
; RV32I-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32I-NEXT:    beqz a0, .LBB0_2
; RV32I-NEXT:  # %bb.1: # %cond.false
; RV32I-NEXT:    srli a1, a0, 1
; RV32I-NEXT:    or a0, a0, a1
; RV32I-NEXT:    srli a1, a0, 2
; RV32I-NEXT:    or a0, a0, a1
; RV32I-NEXT:    srli a1, a0, 4
; RV32I-NEXT:    or a0, a0, a1
; RV32I-NEXT:    srli a1, a0, 8
; RV32I-NEXT:    or a0, a0, a1
; RV32I-NEXT:    srli a1, a0, 16
; RV32I-NEXT:    or a0, a0, a1
; RV32I-NEXT:    not a0, a0
; RV32I-NEXT:    srli a1, a0, 1
; RV32I-NEXT:    lui a2, 349525
; RV32I-NEXT:    addi a2, a2, 1365
; RV32I-NEXT:    and a1, a1, a2
; RV32I-NEXT:    sub a0, a0, a1
; RV32I-NEXT:    lui a1, 209715
; RV32I-NEXT:    addi a1, a1, 819
; RV32I-NEXT:    and a2, a0, a1
; RV32I-NEXT:    srli a0, a0, 2
; RV32I-NEXT:    and a0, a0, a1
; RV32I-NEXT:    add a0, a2, a0
; RV32I-NEXT:    srli a1, a0, 4
; RV32I-NEXT:    add a0, a0, a1
; RV32I-NEXT:    lui a1, 61681
; RV32I-NEXT:    addi a1, a1, -241
; RV32I-NEXT:    and a0, a0, a1
; RV32I-NEXT:    lui a1, 4112
; RV32I-NEXT:    addi a1, a1, 257
; RV32I-NEXT:    call __mulsi3@plt
; RV32I-NEXT:    srli a0, a0, 24
; RV32I-NEXT:    j .LBB0_3
; RV32I-NEXT:  .LBB0_2:
; RV32I-NEXT:    addi a0, zero, 32
; RV32I-NEXT:  .LBB0_3: # %cond.end
; RV32I-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32I-NEXT:    addi sp, sp, 16
; RV32I-NEXT:    ret
;
; RV32B-LABEL: ctlz_i32:
; RV32B:       # %bb.0:
; RV32B-NEXT:    clz a0, a0
; RV32B-NEXT:    ret
;
; RV32ZBB-LABEL: ctlz_i32:
; RV32ZBB:       # %bb.0:
; RV32ZBB-NEXT:    clz a0, a0
; RV32ZBB-NEXT:    ret
  %1 = call i32 @llvm.ctlz.i32(i32 %a, i1 false)
  ret i32 %1
}

declare i64 @llvm.ctlz.i64(i64, i1)

define i64 @ctlz_i64(i64 %a) nounwind {
; RV32I-LABEL: ctlz_i64:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi sp, sp, -32
; RV32I-NEXT:    sw ra, 28(sp) # 4-byte Folded Spill
; RV32I-NEXT:    sw s0, 24(sp) # 4-byte Folded Spill
; RV32I-NEXT:    sw s1, 20(sp) # 4-byte Folded Spill
; RV32I-NEXT:    sw s2, 16(sp) # 4-byte Folded Spill
; RV32I-NEXT:    sw s3, 12(sp) # 4-byte Folded Spill
; RV32I-NEXT:    sw s4, 8(sp) # 4-byte Folded Spill
; RV32I-NEXT:    sw s5, 4(sp) # 4-byte Folded Spill
; RV32I-NEXT:    sw s6, 0(sp) # 4-byte Folded Spill
; RV32I-NEXT:    mv s0, a1
; RV32I-NEXT:    mv s1, a0
; RV32I-NEXT:    srli a0, a1, 1
; RV32I-NEXT:    or a0, a1, a0
; RV32I-NEXT:    srli a1, a0, 2
; RV32I-NEXT:    or a0, a0, a1
; RV32I-NEXT:    srli a1, a0, 4
; RV32I-NEXT:    or a0, a0, a1
; RV32I-NEXT:    srli a1, a0, 8
; RV32I-NEXT:    or a0, a0, a1
; RV32I-NEXT:    srli a1, a0, 16
; RV32I-NEXT:    or a0, a0, a1
; RV32I-NEXT:    not a0, a0
; RV32I-NEXT:    srli a1, a0, 1
; RV32I-NEXT:    lui a2, 349525
; RV32I-NEXT:    addi s4, a2, 1365
; RV32I-NEXT:    and a1, a1, s4
; RV32I-NEXT:    sub a0, a0, a1
; RV32I-NEXT:    lui a1, 209715
; RV32I-NEXT:    addi s5, a1, 819
; RV32I-NEXT:    and a1, a0, s5
; RV32I-NEXT:    srli a0, a0, 2
; RV32I-NEXT:    and a0, a0, s5
; RV32I-NEXT:    add a0, a1, a0
; RV32I-NEXT:    srli a1, a0, 4
; RV32I-NEXT:    add a0, a0, a1
; RV32I-NEXT:    lui a1, 61681
; RV32I-NEXT:    addi s6, a1, -241
; RV32I-NEXT:    and a0, a0, s6
; RV32I-NEXT:    lui a1, 4112
; RV32I-NEXT:    addi s3, a1, 257
; RV32I-NEXT:    mv a1, s3
; RV32I-NEXT:    call __mulsi3@plt
; RV32I-NEXT:    mv s2, a0
; RV32I-NEXT:    srli a0, s1, 1
; RV32I-NEXT:    or a0, s1, a0
; RV32I-NEXT:    srli a1, a0, 2
; RV32I-NEXT:    or a0, a0, a1
; RV32I-NEXT:    srli a1, a0, 4
; RV32I-NEXT:    or a0, a0, a1
; RV32I-NEXT:    srli a1, a0, 8
; RV32I-NEXT:    or a0, a0, a1
; RV32I-NEXT:    srli a1, a0, 16
; RV32I-NEXT:    or a0, a0, a1
; RV32I-NEXT:    not a0, a0
; RV32I-NEXT:    srli a1, a0, 1
; RV32I-NEXT:    and a1, a1, s4
; RV32I-NEXT:    sub a0, a0, a1
; RV32I-NEXT:    and a1, a0, s5
; RV32I-NEXT:    srli a0, a0, 2
; RV32I-NEXT:    and a0, a0, s5
; RV32I-NEXT:    add a0, a1, a0
; RV32I-NEXT:    srli a1, a0, 4
; RV32I-NEXT:    add a0, a0, a1
; RV32I-NEXT:    and a0, a0, s6
; RV32I-NEXT:    mv a1, s3
; RV32I-NEXT:    call __mulsi3@plt
; RV32I-NEXT:    bnez s0, .LBB1_2
; RV32I-NEXT:  # %bb.1:
; RV32I-NEXT:    srli a0, a0, 24
; RV32I-NEXT:    addi a0, a0, 32
; RV32I-NEXT:    j .LBB1_3
; RV32I-NEXT:  .LBB1_2:
; RV32I-NEXT:    srli a0, s2, 24
; RV32I-NEXT:  .LBB1_3:
; RV32I-NEXT:    mv a1, zero
; RV32I-NEXT:    lw s6, 0(sp) # 4-byte Folded Reload
; RV32I-NEXT:    lw s5, 4(sp) # 4-byte Folded Reload
; RV32I-NEXT:    lw s4, 8(sp) # 4-byte Folded Reload
; RV32I-NEXT:    lw s3, 12(sp) # 4-byte Folded Reload
; RV32I-NEXT:    lw s2, 16(sp) # 4-byte Folded Reload
; RV32I-NEXT:    lw s1, 20(sp) # 4-byte Folded Reload
; RV32I-NEXT:    lw s0, 24(sp) # 4-byte Folded Reload
; RV32I-NEXT:    lw ra, 28(sp) # 4-byte Folded Reload
; RV32I-NEXT:    addi sp, sp, 32
; RV32I-NEXT:    ret
;
; RV32B-LABEL: ctlz_i64:
; RV32B:       # %bb.0:
; RV32B-NEXT:    clz a2, a1
; RV32B-NEXT:    clz a0, a0
; RV32B-NEXT:    addi a0, a0, 32
; RV32B-NEXT:    cmov a0, a1, a2, a0
; RV32B-NEXT:    mv a1, zero
; RV32B-NEXT:    ret
;
; RV32ZBB-LABEL: ctlz_i64:
; RV32ZBB:       # %bb.0:
; RV32ZBB-NEXT:    bnez a1, .LBB1_2
; RV32ZBB-NEXT:  # %bb.1:
; RV32ZBB-NEXT:    clz a0, a0
; RV32ZBB-NEXT:    addi a0, a0, 32
; RV32ZBB-NEXT:    mv a1, zero
; RV32ZBB-NEXT:    ret
; RV32ZBB-NEXT:  .LBB1_2:
; RV32ZBB-NEXT:    clz a0, a1
; RV32ZBB-NEXT:    mv a1, zero
; RV32ZBB-NEXT:    ret
  %1 = call i64 @llvm.ctlz.i64(i64 %a, i1 false)
  ret i64 %1
}

declare i32 @llvm.cttz.i32(i32, i1)

define i32 @cttz_i32(i32 %a) nounwind {
; RV32I-LABEL: cttz_i32:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi sp, sp, -16
; RV32I-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32I-NEXT:    beqz a0, .LBB2_2
; RV32I-NEXT:  # %bb.1: # %cond.false
; RV32I-NEXT:    addi a1, a0, -1
; RV32I-NEXT:    not a0, a0
; RV32I-NEXT:    and a0, a0, a1
; RV32I-NEXT:    srli a1, a0, 1
; RV32I-NEXT:    lui a2, 349525
; RV32I-NEXT:    addi a2, a2, 1365
; RV32I-NEXT:    and a1, a1, a2
; RV32I-NEXT:    sub a0, a0, a1
; RV32I-NEXT:    lui a1, 209715
; RV32I-NEXT:    addi a1, a1, 819
; RV32I-NEXT:    and a2, a0, a1
; RV32I-NEXT:    srli a0, a0, 2
; RV32I-NEXT:    and a0, a0, a1
; RV32I-NEXT:    add a0, a2, a0
; RV32I-NEXT:    srli a1, a0, 4
; RV32I-NEXT:    add a0, a0, a1
; RV32I-NEXT:    lui a1, 61681
; RV32I-NEXT:    addi a1, a1, -241
; RV32I-NEXT:    and a0, a0, a1
; RV32I-NEXT:    lui a1, 4112
; RV32I-NEXT:    addi a1, a1, 257
; RV32I-NEXT:    call __mulsi3@plt
; RV32I-NEXT:    srli a0, a0, 24
; RV32I-NEXT:    j .LBB2_3
; RV32I-NEXT:  .LBB2_2:
; RV32I-NEXT:    addi a0, zero, 32
; RV32I-NEXT:  .LBB2_3: # %cond.end
; RV32I-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32I-NEXT:    addi sp, sp, 16
; RV32I-NEXT:    ret
;
; RV32B-LABEL: cttz_i32:
; RV32B:       # %bb.0:
; RV32B-NEXT:    ctz a0, a0
; RV32B-NEXT:    ret
;
; RV32ZBB-LABEL: cttz_i32:
; RV32ZBB:       # %bb.0:
; RV32ZBB-NEXT:    ctz a0, a0
; RV32ZBB-NEXT:    ret
  %1 = call i32 @llvm.cttz.i32(i32 %a, i1 false)
  ret i32 %1
}

declare i64 @llvm.cttz.i64(i64, i1)

define i64 @cttz_i64(i64 %a) nounwind {
; RV32I-LABEL: cttz_i64:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi sp, sp, -32
; RV32I-NEXT:    sw ra, 28(sp) # 4-byte Folded Spill
; RV32I-NEXT:    sw s0, 24(sp) # 4-byte Folded Spill
; RV32I-NEXT:    sw s1, 20(sp) # 4-byte Folded Spill
; RV32I-NEXT:    sw s2, 16(sp) # 4-byte Folded Spill
; RV32I-NEXT:    sw s3, 12(sp) # 4-byte Folded Spill
; RV32I-NEXT:    sw s4, 8(sp) # 4-byte Folded Spill
; RV32I-NEXT:    sw s5, 4(sp) # 4-byte Folded Spill
; RV32I-NEXT:    sw s6, 0(sp) # 4-byte Folded Spill
; RV32I-NEXT:    mv s1, a1
; RV32I-NEXT:    mv s0, a0
; RV32I-NEXT:    addi a0, a0, -1
; RV32I-NEXT:    not a1, s0
; RV32I-NEXT:    and a0, a1, a0
; RV32I-NEXT:    srli a1, a0, 1
; RV32I-NEXT:    lui a2, 349525
; RV32I-NEXT:    addi s4, a2, 1365
; RV32I-NEXT:    and a1, a1, s4
; RV32I-NEXT:    sub a0, a0, a1
; RV32I-NEXT:    lui a1, 209715
; RV32I-NEXT:    addi s5, a1, 819
; RV32I-NEXT:    and a1, a0, s5
; RV32I-NEXT:    srli a0, a0, 2
; RV32I-NEXT:    and a0, a0, s5
; RV32I-NEXT:    add a0, a1, a0
; RV32I-NEXT:    srli a1, a0, 4
; RV32I-NEXT:    add a0, a0, a1
; RV32I-NEXT:    lui a1, 61681
; RV32I-NEXT:    addi s6, a1, -241
; RV32I-NEXT:    and a0, a0, s6
; RV32I-NEXT:    lui a1, 4112
; RV32I-NEXT:    addi s3, a1, 257
; RV32I-NEXT:    mv a1, s3
; RV32I-NEXT:    call __mulsi3@plt
; RV32I-NEXT:    mv s2, a0
; RV32I-NEXT:    addi a0, s1, -1
; RV32I-NEXT:    not a1, s1
; RV32I-NEXT:    and a0, a1, a0
; RV32I-NEXT:    srli a1, a0, 1
; RV32I-NEXT:    and a1, a1, s4
; RV32I-NEXT:    sub a0, a0, a1
; RV32I-NEXT:    and a1, a0, s5
; RV32I-NEXT:    srli a0, a0, 2
; RV32I-NEXT:    and a0, a0, s5
; RV32I-NEXT:    add a0, a1, a0
; RV32I-NEXT:    srli a1, a0, 4
; RV32I-NEXT:    add a0, a0, a1
; RV32I-NEXT:    and a0, a0, s6
; RV32I-NEXT:    mv a1, s3
; RV32I-NEXT:    call __mulsi3@plt
; RV32I-NEXT:    bnez s0, .LBB3_2
; RV32I-NEXT:  # %bb.1:
; RV32I-NEXT:    srli a0, a0, 24
; RV32I-NEXT:    addi a0, a0, 32
; RV32I-NEXT:    j .LBB3_3
; RV32I-NEXT:  .LBB3_2:
; RV32I-NEXT:    srli a0, s2, 24
; RV32I-NEXT:  .LBB3_3:
; RV32I-NEXT:    mv a1, zero
; RV32I-NEXT:    lw s6, 0(sp) # 4-byte Folded Reload
; RV32I-NEXT:    lw s5, 4(sp) # 4-byte Folded Reload
; RV32I-NEXT:    lw s4, 8(sp) # 4-byte Folded Reload
; RV32I-NEXT:    lw s3, 12(sp) # 4-byte Folded Reload
; RV32I-NEXT:    lw s2, 16(sp) # 4-byte Folded Reload
; RV32I-NEXT:    lw s1, 20(sp) # 4-byte Folded Reload
; RV32I-NEXT:    lw s0, 24(sp) # 4-byte Folded Reload
; RV32I-NEXT:    lw ra, 28(sp) # 4-byte Folded Reload
; RV32I-NEXT:    addi sp, sp, 32
; RV32I-NEXT:    ret
;
; RV32B-LABEL: cttz_i64:
; RV32B:       # %bb.0:
; RV32B-NEXT:    ctz a2, a0
; RV32B-NEXT:    ctz a1, a1
; RV32B-NEXT:    addi a1, a1, 32
; RV32B-NEXT:    cmov a0, a0, a2, a1
; RV32B-NEXT:    mv a1, zero
; RV32B-NEXT:    ret
;
; RV32ZBB-LABEL: cttz_i64:
; RV32ZBB:       # %bb.0:
; RV32ZBB-NEXT:    bnez a0, .LBB3_2
; RV32ZBB-NEXT:  # %bb.1:
; RV32ZBB-NEXT:    ctz a0, a1
; RV32ZBB-NEXT:    addi a0, a0, 32
; RV32ZBB-NEXT:    mv a1, zero
; RV32ZBB-NEXT:    ret
; RV32ZBB-NEXT:  .LBB3_2:
; RV32ZBB-NEXT:    ctz a0, a0
; RV32ZBB-NEXT:    mv a1, zero
; RV32ZBB-NEXT:    ret
  %1 = call i64 @llvm.cttz.i64(i64 %a, i1 false)
  ret i64 %1
}

declare i32 @llvm.ctpop.i32(i32)

define i32 @ctpop_i32(i32 %a) nounwind {
; RV32I-LABEL: ctpop_i32:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi sp, sp, -16
; RV32I-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32I-NEXT:    srli a1, a0, 1
; RV32I-NEXT:    lui a2, 349525
; RV32I-NEXT:    addi a2, a2, 1365
; RV32I-NEXT:    and a1, a1, a2
; RV32I-NEXT:    sub a0, a0, a1
; RV32I-NEXT:    lui a1, 209715
; RV32I-NEXT:    addi a1, a1, 819
; RV32I-NEXT:    and a2, a0, a1
; RV32I-NEXT:    srli a0, a0, 2
; RV32I-NEXT:    and a0, a0, a1
; RV32I-NEXT:    add a0, a2, a0
; RV32I-NEXT:    srli a1, a0, 4
; RV32I-NEXT:    add a0, a0, a1
; RV32I-NEXT:    lui a1, 61681
; RV32I-NEXT:    addi a1, a1, -241
; RV32I-NEXT:    and a0, a0, a1
; RV32I-NEXT:    lui a1, 4112
; RV32I-NEXT:    addi a1, a1, 257
; RV32I-NEXT:    call __mulsi3@plt
; RV32I-NEXT:    srli a0, a0, 24
; RV32I-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32I-NEXT:    addi sp, sp, 16
; RV32I-NEXT:    ret
;
; RV32B-LABEL: ctpop_i32:
; RV32B:       # %bb.0:
; RV32B-NEXT:    cpop a0, a0
; RV32B-NEXT:    ret
;
; RV32ZBB-LABEL: ctpop_i32:
; RV32ZBB:       # %bb.0:
; RV32ZBB-NEXT:    cpop a0, a0
; RV32ZBB-NEXT:    ret
  %1 = call i32 @llvm.ctpop.i32(i32 %a)
  ret i32 %1
}

declare i64 @llvm.ctpop.i64(i64)

define i64 @ctpop_i64(i64 %a) nounwind {
; RV32I-LABEL: ctpop_i64:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi sp, sp, -32
; RV32I-NEXT:    sw ra, 28(sp) # 4-byte Folded Spill
; RV32I-NEXT:    sw s0, 24(sp) # 4-byte Folded Spill
; RV32I-NEXT:    sw s1, 20(sp) # 4-byte Folded Spill
; RV32I-NEXT:    sw s2, 16(sp) # 4-byte Folded Spill
; RV32I-NEXT:    sw s3, 12(sp) # 4-byte Folded Spill
; RV32I-NEXT:    sw s4, 8(sp) # 4-byte Folded Spill
; RV32I-NEXT:    sw s5, 4(sp) # 4-byte Folded Spill
; RV32I-NEXT:    mv s0, a0
; RV32I-NEXT:    srli a0, a1, 1
; RV32I-NEXT:    lui a2, 349525
; RV32I-NEXT:    addi s2, a2, 1365
; RV32I-NEXT:    and a0, a0, s2
; RV32I-NEXT:    sub a0, a1, a0
; RV32I-NEXT:    lui a1, 209715
; RV32I-NEXT:    addi s1, a1, 819
; RV32I-NEXT:    and a1, a0, s1
; RV32I-NEXT:    srli a0, a0, 2
; RV32I-NEXT:    and a0, a0, s1
; RV32I-NEXT:    add a0, a1, a0
; RV32I-NEXT:    srli a1, a0, 4
; RV32I-NEXT:    add a0, a0, a1
; RV32I-NEXT:    lui a1, 61681
; RV32I-NEXT:    addi s4, a1, -241
; RV32I-NEXT:    and a0, a0, s4
; RV32I-NEXT:    lui a1, 4112
; RV32I-NEXT:    addi s3, a1, 257
; RV32I-NEXT:    mv a1, s3
; RV32I-NEXT:    call __mulsi3@plt
; RV32I-NEXT:    srli s5, a0, 24
; RV32I-NEXT:    srli a0, s0, 1
; RV32I-NEXT:    and a0, a0, s2
; RV32I-NEXT:    sub a0, s0, a0
; RV32I-NEXT:    and a1, a0, s1
; RV32I-NEXT:    srli a0, a0, 2
; RV32I-NEXT:    and a0, a0, s1
; RV32I-NEXT:    add a0, a1, a0
; RV32I-NEXT:    srli a1, a0, 4
; RV32I-NEXT:    add a0, a0, a1
; RV32I-NEXT:    and a0, a0, s4
; RV32I-NEXT:    mv a1, s3
; RV32I-NEXT:    call __mulsi3@plt
; RV32I-NEXT:    srli a0, a0, 24
; RV32I-NEXT:    add a0, a0, s5
; RV32I-NEXT:    mv a1, zero
; RV32I-NEXT:    lw s5, 4(sp) # 4-byte Folded Reload
; RV32I-NEXT:    lw s4, 8(sp) # 4-byte Folded Reload
; RV32I-NEXT:    lw s3, 12(sp) # 4-byte Folded Reload
; RV32I-NEXT:    lw s2, 16(sp) # 4-byte Folded Reload
; RV32I-NEXT:    lw s1, 20(sp) # 4-byte Folded Reload
; RV32I-NEXT:    lw s0, 24(sp) # 4-byte Folded Reload
; RV32I-NEXT:    lw ra, 28(sp) # 4-byte Folded Reload
; RV32I-NEXT:    addi sp, sp, 32
; RV32I-NEXT:    ret
;
; RV32B-LABEL: ctpop_i64:
; RV32B:       # %bb.0:
; RV32B-NEXT:    cpop a1, a1
; RV32B-NEXT:    cpop a0, a0
; RV32B-NEXT:    add a0, a0, a1
; RV32B-NEXT:    mv a1, zero
; RV32B-NEXT:    ret
;
; RV32ZBB-LABEL: ctpop_i64:
; RV32ZBB:       # %bb.0:
; RV32ZBB-NEXT:    cpop a1, a1
; RV32ZBB-NEXT:    cpop a0, a0
; RV32ZBB-NEXT:    add a0, a0, a1
; RV32ZBB-NEXT:    mv a1, zero
; RV32ZBB-NEXT:    ret
  %1 = call i64 @llvm.ctpop.i64(i64 %a)
  ret i64 %1
}

define i32 @sextb_i32(i32 %a) nounwind {
; RV32I-LABEL: sextb_i32:
; RV32I:       # %bb.0:
; RV32I-NEXT:    slli a0, a0, 24
; RV32I-NEXT:    srai a0, a0, 24
; RV32I-NEXT:    ret
;
; RV32B-LABEL: sextb_i32:
; RV32B:       # %bb.0:
; RV32B-NEXT:    sext.b a0, a0
; RV32B-NEXT:    ret
;
; RV32ZBB-LABEL: sextb_i32:
; RV32ZBB:       # %bb.0:
; RV32ZBB-NEXT:    sext.b a0, a0
; RV32ZBB-NEXT:    ret
  %shl = shl i32 %a, 24
  %shr = ashr exact i32 %shl, 24
  ret i32 %shr
}

define i64 @sextb_i64(i64 %a) nounwind {
; RV32I-LABEL: sextb_i64:
; RV32I:       # %bb.0:
; RV32I-NEXT:    slli a1, a0, 24
; RV32I-NEXT:    srai a0, a1, 24
; RV32I-NEXT:    srai a1, a1, 31
; RV32I-NEXT:    ret
;
; RV32B-LABEL: sextb_i64:
; RV32B:       # %bb.0:
; RV32B-NEXT:    sext.b a0, a0
; RV32B-NEXT:    srai a1, a0, 31
; RV32B-NEXT:    ret
;
; RV32ZBB-LABEL: sextb_i64:
; RV32ZBB:       # %bb.0:
; RV32ZBB-NEXT:    sext.b a0, a0
; RV32ZBB-NEXT:    srai a1, a0, 31
; RV32ZBB-NEXT:    ret
  %shl = shl i64 %a, 56
  %shr = ashr exact i64 %shl, 56
  ret i64 %shr
}

define i32 @sexth_i32(i32 %a) nounwind {
; RV32I-LABEL: sexth_i32:
; RV32I:       # %bb.0:
; RV32I-NEXT:    slli a0, a0, 16
; RV32I-NEXT:    srai a0, a0, 16
; RV32I-NEXT:    ret
;
; RV32B-LABEL: sexth_i32:
; RV32B:       # %bb.0:
; RV32B-NEXT:    sext.h a0, a0
; RV32B-NEXT:    ret
;
; RV32ZBB-LABEL: sexth_i32:
; RV32ZBB:       # %bb.0:
; RV32ZBB-NEXT:    sext.h a0, a0
; RV32ZBB-NEXT:    ret
  %shl = shl i32 %a, 16
  %shr = ashr exact i32 %shl, 16
  ret i32 %shr
}

define i64 @sexth_i64(i64 %a) nounwind {
; RV32I-LABEL: sexth_i64:
; RV32I:       # %bb.0:
; RV32I-NEXT:    slli a1, a0, 16
; RV32I-NEXT:    srai a0, a1, 16
; RV32I-NEXT:    srai a1, a1, 31
; RV32I-NEXT:    ret
;
; RV32B-LABEL: sexth_i64:
; RV32B:       # %bb.0:
; RV32B-NEXT:    sext.h a0, a0
; RV32B-NEXT:    srai a1, a0, 31
; RV32B-NEXT:    ret
;
; RV32ZBB-LABEL: sexth_i64:
; RV32ZBB:       # %bb.0:
; RV32ZBB-NEXT:    sext.h a0, a0
; RV32ZBB-NEXT:    srai a1, a0, 31
; RV32ZBB-NEXT:    ret
  %shl = shl i64 %a, 48
  %shr = ashr exact i64 %shl, 48
  ret i64 %shr
}

define i32 @min_i32(i32 %a, i32 %b) nounwind {
; RV32I-LABEL: min_i32:
; RV32I:       # %bb.0:
; RV32I-NEXT:    blt a0, a1, .LBB10_2
; RV32I-NEXT:  # %bb.1:
; RV32I-NEXT:    mv a0, a1
; RV32I-NEXT:  .LBB10_2:
; RV32I-NEXT:    ret
;
; RV32B-LABEL: min_i32:
; RV32B:       # %bb.0:
; RV32B-NEXT:    min a0, a0, a1
; RV32B-NEXT:    ret
;
; RV32ZBB-LABEL: min_i32:
; RV32ZBB:       # %bb.0:
; RV32ZBB-NEXT:    min a0, a0, a1
; RV32ZBB-NEXT:    ret
  %cmp = icmp slt i32 %a, %b
  %cond = select i1 %cmp, i32 %a, i32 %b
  ret i32 %cond
}

; As we are not matching directly i64 code patterns on RV32 some i64 patterns
; don't have yet any matching bit manipulation instructions on RV32.
; This test is presented here in case future expansions of the experimental-b
; extension introduce instructions suitable for this pattern.

define i64 @min_i64(i64 %a, i64 %b) nounwind {
; RV32I-LABEL: min_i64:
; RV32I:       # %bb.0:
; RV32I-NEXT:    beq a1, a3, .LBB11_2
; RV32I-NEXT:  # %bb.1:
; RV32I-NEXT:    slt a4, a1, a3
; RV32I-NEXT:    beqz a4, .LBB11_3
; RV32I-NEXT:    j .LBB11_4
; RV32I-NEXT:  .LBB11_2:
; RV32I-NEXT:    sltu a4, a0, a2
; RV32I-NEXT:    bnez a4, .LBB11_4
; RV32I-NEXT:  .LBB11_3:
; RV32I-NEXT:    mv a0, a2
; RV32I-NEXT:    mv a1, a3
; RV32I-NEXT:  .LBB11_4:
; RV32I-NEXT:    ret
;
; RV32B-LABEL: min_i64:
; RV32B:       # %bb.0:
; RV32B-NEXT:    slt a4, a1, a3
; RV32B-NEXT:    cmov a4, a4, a0, a2
; RV32B-NEXT:    minu a0, a0, a2
; RV32B-NEXT:    xor a2, a1, a3
; RV32B-NEXT:    cmov a0, a2, a4, a0
; RV32B-NEXT:    min a1, a1, a3
; RV32B-NEXT:    ret
;
; RV32ZBB-LABEL: min_i64:
; RV32ZBB:       # %bb.0:
; RV32ZBB-NEXT:    mv a4, a0
; RV32ZBB-NEXT:    bge a1, a3, .LBB11_3
; RV32ZBB-NEXT:  # %bb.1:
; RV32ZBB-NEXT:    beq a1, a3, .LBB11_4
; RV32ZBB-NEXT:  .LBB11_2:
; RV32ZBB-NEXT:    min a1, a1, a3
; RV32ZBB-NEXT:    ret
; RV32ZBB-NEXT:  .LBB11_3:
; RV32ZBB-NEXT:    mv a0, a2
; RV32ZBB-NEXT:    bne a1, a3, .LBB11_2
; RV32ZBB-NEXT:  .LBB11_4:
; RV32ZBB-NEXT:    minu a0, a4, a2
; RV32ZBB-NEXT:    min a1, a1, a3
; RV32ZBB-NEXT:    ret
  %cmp = icmp slt i64 %a, %b
  %cond = select i1 %cmp, i64 %a, i64 %b
  ret i64 %cond
}

define i32 @max_i32(i32 %a, i32 %b) nounwind {
; RV32I-LABEL: max_i32:
; RV32I:       # %bb.0:
; RV32I-NEXT:    blt a1, a0, .LBB12_2
; RV32I-NEXT:  # %bb.1:
; RV32I-NEXT:    mv a0, a1
; RV32I-NEXT:  .LBB12_2:
; RV32I-NEXT:    ret
;
; RV32B-LABEL: max_i32:
; RV32B:       # %bb.0:
; RV32B-NEXT:    max a0, a0, a1
; RV32B-NEXT:    ret
;
; RV32ZBB-LABEL: max_i32:
; RV32ZBB:       # %bb.0:
; RV32ZBB-NEXT:    max a0, a0, a1
; RV32ZBB-NEXT:    ret
  %cmp = icmp sgt i32 %a, %b
  %cond = select i1 %cmp, i32 %a, i32 %b
  ret i32 %cond
}

; As we are not matching directly i64 code patterns on RV32 some i64 patterns
; don't have yet any matching bit manipulation instructions on RV32.
; This test is presented here in case future expansions of the experimental-b
; extension introduce instructions suitable for this pattern.

define i64 @max_i64(i64 %a, i64 %b) nounwind {
; RV32I-LABEL: max_i64:
; RV32I:       # %bb.0:
; RV32I-NEXT:    beq a1, a3, .LBB13_2
; RV32I-NEXT:  # %bb.1:
; RV32I-NEXT:    slt a4, a3, a1
; RV32I-NEXT:    beqz a4, .LBB13_3
; RV32I-NEXT:    j .LBB13_4
; RV32I-NEXT:  .LBB13_2:
; RV32I-NEXT:    sltu a4, a2, a0
; RV32I-NEXT:    bnez a4, .LBB13_4
; RV32I-NEXT:  .LBB13_3:
; RV32I-NEXT:    mv a0, a2
; RV32I-NEXT:    mv a1, a3
; RV32I-NEXT:  .LBB13_4:
; RV32I-NEXT:    ret
;
; RV32B-LABEL: max_i64:
; RV32B:       # %bb.0:
; RV32B-NEXT:    slt a4, a3, a1
; RV32B-NEXT:    cmov a4, a4, a0, a2
; RV32B-NEXT:    maxu a0, a0, a2
; RV32B-NEXT:    xor a2, a1, a3
; RV32B-NEXT:    cmov a0, a2, a4, a0
; RV32B-NEXT:    max a1, a1, a3
; RV32B-NEXT:    ret
;
; RV32ZBB-LABEL: max_i64:
; RV32ZBB:       # %bb.0:
; RV32ZBB-NEXT:    mv a4, a0
; RV32ZBB-NEXT:    bge a3, a1, .LBB13_3
; RV32ZBB-NEXT:  # %bb.1:
; RV32ZBB-NEXT:    beq a1, a3, .LBB13_4
; RV32ZBB-NEXT:  .LBB13_2:
; RV32ZBB-NEXT:    max a1, a1, a3
; RV32ZBB-NEXT:    ret
; RV32ZBB-NEXT:  .LBB13_3:
; RV32ZBB-NEXT:    mv a0, a2
; RV32ZBB-NEXT:    bne a1, a3, .LBB13_2
; RV32ZBB-NEXT:  .LBB13_4:
; RV32ZBB-NEXT:    maxu a0, a4, a2
; RV32ZBB-NEXT:    max a1, a1, a3
; RV32ZBB-NEXT:    ret
  %cmp = icmp sgt i64 %a, %b
  %cond = select i1 %cmp, i64 %a, i64 %b
  ret i64 %cond
}

define i32 @minu_i32(i32 %a, i32 %b) nounwind {
; RV32I-LABEL: minu_i32:
; RV32I:       # %bb.0:
; RV32I-NEXT:    bltu a0, a1, .LBB14_2
; RV32I-NEXT:  # %bb.1:
; RV32I-NEXT:    mv a0, a1
; RV32I-NEXT:  .LBB14_2:
; RV32I-NEXT:    ret
;
; RV32B-LABEL: minu_i32:
; RV32B:       # %bb.0:
; RV32B-NEXT:    minu a0, a0, a1
; RV32B-NEXT:    ret
;
; RV32ZBB-LABEL: minu_i32:
; RV32ZBB:       # %bb.0:
; RV32ZBB-NEXT:    minu a0, a0, a1
; RV32ZBB-NEXT:    ret
  %cmp = icmp ult i32 %a, %b
  %cond = select i1 %cmp, i32 %a, i32 %b
  ret i32 %cond
}

; As we are not matching directly i64 code patterns on RV32 some i64 patterns
; don't have yet any matching bit manipulation instructions on RV32.
; This test is presented here in case future expansions of the experimental-b
; extension introduce instructions suitable for this pattern.

define i64 @minu_i64(i64 %a, i64 %b) nounwind {
; RV32I-LABEL: minu_i64:
; RV32I:       # %bb.0:
; RV32I-NEXT:    beq a1, a3, .LBB15_2
; RV32I-NEXT:  # %bb.1:
; RV32I-NEXT:    sltu a4, a1, a3
; RV32I-NEXT:    beqz a4, .LBB15_3
; RV32I-NEXT:    j .LBB15_4
; RV32I-NEXT:  .LBB15_2:
; RV32I-NEXT:    sltu a4, a0, a2
; RV32I-NEXT:    bnez a4, .LBB15_4
; RV32I-NEXT:  .LBB15_3:
; RV32I-NEXT:    mv a0, a2
; RV32I-NEXT:    mv a1, a3
; RV32I-NEXT:  .LBB15_4:
; RV32I-NEXT:    ret
;
; RV32B-LABEL: minu_i64:
; RV32B:       # %bb.0:
; RV32B-NEXT:    sltu a4, a1, a3
; RV32B-NEXT:    cmov a4, a4, a0, a2
; RV32B-NEXT:    minu a0, a0, a2
; RV32B-NEXT:    xor a2, a1, a3
; RV32B-NEXT:    cmov a0, a2, a4, a0
; RV32B-NEXT:    minu a1, a1, a3
; RV32B-NEXT:    ret
;
; RV32ZBB-LABEL: minu_i64:
; RV32ZBB:       # %bb.0:
; RV32ZBB-NEXT:    mv a4, a0
; RV32ZBB-NEXT:    bgeu a1, a3, .LBB15_3
; RV32ZBB-NEXT:  # %bb.1:
; RV32ZBB-NEXT:    beq a1, a3, .LBB15_4
; RV32ZBB-NEXT:  .LBB15_2:
; RV32ZBB-NEXT:    minu a1, a1, a3
; RV32ZBB-NEXT:    ret
; RV32ZBB-NEXT:  .LBB15_3:
; RV32ZBB-NEXT:    mv a0, a2
; RV32ZBB-NEXT:    bne a1, a3, .LBB15_2
; RV32ZBB-NEXT:  .LBB15_4:
; RV32ZBB-NEXT:    minu a0, a4, a2
; RV32ZBB-NEXT:    minu a1, a1, a3
; RV32ZBB-NEXT:    ret
  %cmp = icmp ult i64 %a, %b
  %cond = select i1 %cmp, i64 %a, i64 %b
  ret i64 %cond
}

define i32 @maxu_i32(i32 %a, i32 %b) nounwind {
; RV32I-LABEL: maxu_i32:
; RV32I:       # %bb.0:
; RV32I-NEXT:    bltu a1, a0, .LBB16_2
; RV32I-NEXT:  # %bb.1:
; RV32I-NEXT:    mv a0, a1
; RV32I-NEXT:  .LBB16_2:
; RV32I-NEXT:    ret
;
; RV32B-LABEL: maxu_i32:
; RV32B:       # %bb.0:
; RV32B-NEXT:    maxu a0, a0, a1
; RV32B-NEXT:    ret
;
; RV32ZBB-LABEL: maxu_i32:
; RV32ZBB:       # %bb.0:
; RV32ZBB-NEXT:    maxu a0, a0, a1
; RV32ZBB-NEXT:    ret
  %cmp = icmp ugt i32 %a, %b
  %cond = select i1 %cmp, i32 %a, i32 %b
  ret i32 %cond
}

; As we are not matching directly i64 code patterns on RV32 some i64 patterns
; don't have yet any matching bit manipulation instructions on RV32.
; This test is presented here in case future expansions of the experimental-b
; extension introduce instructions suitable for this pattern.

define i64 @maxu_i64(i64 %a, i64 %b) nounwind {
; RV32I-LABEL: maxu_i64:
; RV32I:       # %bb.0:
; RV32I-NEXT:    beq a1, a3, .LBB17_2
; RV32I-NEXT:  # %bb.1:
; RV32I-NEXT:    sltu a4, a3, a1
; RV32I-NEXT:    beqz a4, .LBB17_3
; RV32I-NEXT:    j .LBB17_4
; RV32I-NEXT:  .LBB17_2:
; RV32I-NEXT:    sltu a4, a2, a0
; RV32I-NEXT:    bnez a4, .LBB17_4
; RV32I-NEXT:  .LBB17_3:
; RV32I-NEXT:    mv a0, a2
; RV32I-NEXT:    mv a1, a3
; RV32I-NEXT:  .LBB17_4:
; RV32I-NEXT:    ret
;
; RV32B-LABEL: maxu_i64:
; RV32B:       # %bb.0:
; RV32B-NEXT:    sltu a4, a3, a1
; RV32B-NEXT:    cmov a4, a4, a0, a2
; RV32B-NEXT:    maxu a0, a0, a2
; RV32B-NEXT:    xor a2, a1, a3
; RV32B-NEXT:    cmov a0, a2, a4, a0
; RV32B-NEXT:    maxu a1, a1, a3
; RV32B-NEXT:    ret
;
; RV32ZBB-LABEL: maxu_i64:
; RV32ZBB:       # %bb.0:
; RV32ZBB-NEXT:    mv a4, a0
; RV32ZBB-NEXT:    bgeu a3, a1, .LBB17_3
; RV32ZBB-NEXT:  # %bb.1:
; RV32ZBB-NEXT:    beq a1, a3, .LBB17_4
; RV32ZBB-NEXT:  .LBB17_2:
; RV32ZBB-NEXT:    maxu a1, a1, a3
; RV32ZBB-NEXT:    ret
; RV32ZBB-NEXT:  .LBB17_3:
; RV32ZBB-NEXT:    mv a0, a2
; RV32ZBB-NEXT:    bne a1, a3, .LBB17_2
; RV32ZBB-NEXT:  .LBB17_4:
; RV32ZBB-NEXT:    maxu a0, a4, a2
; RV32ZBB-NEXT:    maxu a1, a1, a3
; RV32ZBB-NEXT:    ret
  %cmp = icmp ugt i64 %a, %b
  %cond = select i1 %cmp, i64 %a, i64 %b
  ret i64 %cond
}

declare i32 @llvm.abs.i32(i32, i1 immarg)

define i32 @abs_i32(i32 %x) {
; RV32I-LABEL: abs_i32:
; RV32I:       # %bb.0:
; RV32I-NEXT:    srai a1, a0, 31
; RV32I-NEXT:    add a0, a0, a1
; RV32I-NEXT:    xor a0, a0, a1
; RV32I-NEXT:    ret
;
; RV32B-LABEL: abs_i32:
; RV32B:       # %bb.0:
; RV32B-NEXT:    neg a1, a0
; RV32B-NEXT:    max a0, a0, a1
; RV32B-NEXT:    ret
;
; RV32ZBB-LABEL: abs_i32:
; RV32ZBB:       # %bb.0:
; RV32ZBB-NEXT:    neg a1, a0
; RV32ZBB-NEXT:    max a0, a0, a1
; RV32ZBB-NEXT:    ret
  %abs = tail call i32 @llvm.abs.i32(i32 %x, i1 true)
  ret i32 %abs
}

declare i64 @llvm.abs.i64(i64, i1 immarg)

define i64 @abs_i64(i64 %x) {
; RV32I-LABEL: abs_i64:
; RV32I:       # %bb.0:
; RV32I-NEXT:    bgez a1, .LBB19_2
; RV32I-NEXT:  # %bb.1:
; RV32I-NEXT:    snez a2, a0
; RV32I-NEXT:    neg a0, a0
; RV32I-NEXT:    add a1, a1, a2
; RV32I-NEXT:    neg a1, a1
; RV32I-NEXT:  .LBB19_2:
; RV32I-NEXT:    ret
;
; RV32B-LABEL: abs_i64:
; RV32B:       # %bb.0:
; RV32B-NEXT:    neg a2, a0
; RV32B-NEXT:    slti a3, a1, 0
; RV32B-NEXT:    cmov a2, a3, a2, a0
; RV32B-NEXT:    snez a0, a0
; RV32B-NEXT:    add a0, a1, a0
; RV32B-NEXT:    neg a0, a0
; RV32B-NEXT:    cmov a1, a3, a0, a1
; RV32B-NEXT:    mv a0, a2
; RV32B-NEXT:    ret
;
; RV32ZBB-LABEL: abs_i64:
; RV32ZBB:       # %bb.0:
; RV32ZBB-NEXT:    bgez a1, .LBB19_2
; RV32ZBB-NEXT:  # %bb.1:
; RV32ZBB-NEXT:    snez a2, a0
; RV32ZBB-NEXT:    neg a0, a0
; RV32ZBB-NEXT:    add a1, a1, a2
; RV32ZBB-NEXT:    neg a1, a1
; RV32ZBB-NEXT:  .LBB19_2:
; RV32ZBB-NEXT:    ret
  %abs = tail call i64 @llvm.abs.i64(i64 %x, i1 true)
  ret i64 %abs
}

define i32 @zexth_i32(i32 %a) nounwind {
; RV32I-LABEL: zexth_i32:
; RV32I:       # %bb.0:
; RV32I-NEXT:    lui a1, 16
; RV32I-NEXT:    addi a1, a1, -1
; RV32I-NEXT:    and a0, a0, a1
; RV32I-NEXT:    ret
;
; RV32B-LABEL: zexth_i32:
; RV32B:       # %bb.0:
; RV32B-NEXT:    zext.h a0, a0
; RV32B-NEXT:    ret
;
; RV32ZBB-LABEL: zexth_i32:
; RV32ZBB:       # %bb.0:
; RV32ZBB-NEXT:    zext.h a0, a0
; RV32ZBB-NEXT:    ret
  %and = and i32 %a, 65535
  ret i32 %and
}

define i64 @zexth_i64(i64 %a) nounwind {
; RV32I-LABEL: zexth_i64:
; RV32I:       # %bb.0:
; RV32I-NEXT:    lui a1, 16
; RV32I-NEXT:    addi a1, a1, -1
; RV32I-NEXT:    and a0, a0, a1
; RV32I-NEXT:    mv a1, zero
; RV32I-NEXT:    ret
;
; RV32B-LABEL: zexth_i64:
; RV32B:       # %bb.0:
; RV32B-NEXT:    zext.h a0, a0
; RV32B-NEXT:    mv a1, zero
; RV32B-NEXT:    ret
;
; RV32ZBB-LABEL: zexth_i64:
; RV32ZBB:       # %bb.0:
; RV32ZBB-NEXT:    zext.h a0, a0
; RV32ZBB-NEXT:    mv a1, zero
; RV32ZBB-NEXT:    ret
  %and = and i64 %a, 65535
  ret i64 %and
}

declare i32 @llvm.bswap.i32(i32)

define i32 @bswap_i32(i32 %a) nounwind {
; RV32I-LABEL: bswap_i32:
; RV32I:       # %bb.0:
; RV32I-NEXT:    srli a1, a0, 8
; RV32I-NEXT:    lui a2, 16
; RV32I-NEXT:    addi a2, a2, -256
; RV32I-NEXT:    and a1, a1, a2
; RV32I-NEXT:    srli a2, a0, 24
; RV32I-NEXT:    or a1, a1, a2
; RV32I-NEXT:    slli a2, a0, 8
; RV32I-NEXT:    lui a3, 4080
; RV32I-NEXT:    and a2, a2, a3
; RV32I-NEXT:    slli a0, a0, 24
; RV32I-NEXT:    or a0, a0, a2
; RV32I-NEXT:    or a0, a0, a1
; RV32I-NEXT:    ret
;
; RV32B-LABEL: bswap_i32:
; RV32B:       # %bb.0:
; RV32B-NEXT:    rev8 a0, a0
; RV32B-NEXT:    ret
;
; RV32ZBB-LABEL: bswap_i32:
; RV32ZBB:       # %bb.0:
; RV32ZBB-NEXT:    rev8 a0, a0
; RV32ZBB-NEXT:    ret
  %1 = tail call i32 @llvm.bswap.i32(i32 %a)
  ret i32 %1
}

declare i64 @llvm.bswap.i64(i64)

define i64 @bswap_i64(i64 %a) {
; RV32I-LABEL: bswap_i64:
; RV32I:       # %bb.0:
; RV32I-NEXT:    srli a2, a1, 8
; RV32I-NEXT:    lui a3, 16
; RV32I-NEXT:    addi a3, a3, -256
; RV32I-NEXT:    and a2, a2, a3
; RV32I-NEXT:    srli a4, a1, 24
; RV32I-NEXT:    or a2, a2, a4
; RV32I-NEXT:    slli a4, a1, 8
; RV32I-NEXT:    lui a5, 4080
; RV32I-NEXT:    and a4, a4, a5
; RV32I-NEXT:    slli a1, a1, 24
; RV32I-NEXT:    or a1, a1, a4
; RV32I-NEXT:    or a2, a1, a2
; RV32I-NEXT:    srli a1, a0, 8
; RV32I-NEXT:    and a1, a1, a3
; RV32I-NEXT:    srli a3, a0, 24
; RV32I-NEXT:    or a1, a1, a3
; RV32I-NEXT:    slli a3, a0, 8
; RV32I-NEXT:    and a3, a3, a5
; RV32I-NEXT:    slli a0, a0, 24
; RV32I-NEXT:    or a0, a0, a3
; RV32I-NEXT:    or a1, a0, a1
; RV32I-NEXT:    mv a0, a2
; RV32I-NEXT:    ret
;
; RV32B-LABEL: bswap_i64:
; RV32B:       # %bb.0:
; RV32B-NEXT:    rev8 a2, a1
; RV32B-NEXT:    rev8 a1, a0
; RV32B-NEXT:    mv a0, a2
; RV32B-NEXT:    ret
;
; RV32ZBB-LABEL: bswap_i64:
; RV32ZBB:       # %bb.0:
; RV32ZBB-NEXT:    rev8 a2, a1
; RV32ZBB-NEXT:    rev8 a1, a0
; RV32ZBB-NEXT:    mv a0, a2
; RV32ZBB-NEXT:    ret
  %1 = call i64 @llvm.bswap.i64(i64 %a)
  ret i64 %1
}