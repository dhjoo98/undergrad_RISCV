; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -mattr=+reserve-x18 -verify-machineinstrs < %s \
; RUN:   | FileCheck %s --check-prefix=RV32
; RUN: llc -mtriple=riscv64 -mattr=+reserve-x18 -verify-machineinstrs < %s \
; RUN:   | FileCheck %s --check-prefix=RV64

define void @f1() shadowcallstack {
; RV32-LABEL: f1:
; RV32:       # %bb.0:
; RV32-NEXT:    ret
;
; RV64-LABEL: f1:
; RV64:       # %bb.0:
; RV64-NEXT:    ret
  ret void
}

declare void @foo()

define void @f2() shadowcallstack {
; RV32-LABEL: f2:
; RV32:       # %bb.0:
; RV32-NEXT:    tail foo@plt
;
; RV64-LABEL: f2:
; RV64:       # %bb.0:
; RV64-NEXT:    tail foo@plt
  tail call void @foo()
  ret void
}

declare i32 @bar()

define i32 @f3() shadowcallstack {
; RV32-LABEL: f3:
; RV32:       # %bb.0:
; RV32-NEXT:    sw ra, 0(s2)
; RV32-NEXT:    addi s2, s2, 4
; RV32-NEXT:    addi sp, sp, -16
; RV32-NEXT:    .cfi_def_cfa_offset 16
; RV32-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32-NEXT:    .cfi_offset ra, -4
; RV32-NEXT:    call bar@plt
; RV32-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32-NEXT:    addi sp, sp, 16
; RV32-NEXT:    lw ra, -4(s2)
; RV32-NEXT:    addi s2, s2, -4
; RV32-NEXT:    ret
;
; RV64-LABEL: f3:
; RV64:       # %bb.0:
; RV64-NEXT:    sd ra, 0(s2)
; RV64-NEXT:    addi s2, s2, 8
; RV64-NEXT:    addi sp, sp, -16
; RV64-NEXT:    .cfi_def_cfa_offset 16
; RV64-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64-NEXT:    .cfi_offset ra, -8
; RV64-NEXT:    call bar@plt
; RV64-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64-NEXT:    addi sp, sp, 16
; RV64-NEXT:    ld ra, -8(s2)
; RV64-NEXT:    addi s2, s2, -8
; RV64-NEXT:    ret
  %res = call i32 @bar()
  %res1 = add i32 %res, 1
  ret i32 %res
}

define i32 @f4() shadowcallstack {
; RV32-LABEL: f4:
; RV32:       # %bb.0:
; RV32-NEXT:    sw ra, 0(s2)
; RV32-NEXT:    addi s2, s2, 4
; RV32-NEXT:    addi sp, sp, -16
; RV32-NEXT:    .cfi_def_cfa_offset 16
; RV32-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32-NEXT:    sw s0, 8(sp) # 4-byte Folded Spill
; RV32-NEXT:    sw s1, 4(sp) # 4-byte Folded Spill
; RV32-NEXT:    sw s3, 0(sp) # 4-byte Folded Spill
; RV32-NEXT:    .cfi_offset ra, -4
; RV32-NEXT:    .cfi_offset s0, -8
; RV32-NEXT:    .cfi_offset s1, -12
; RV32-NEXT:    .cfi_offset s3, -16
; RV32-NEXT:    call bar@plt
; RV32-NEXT:    mv s3, a0
; RV32-NEXT:    call bar@plt
; RV32-NEXT:    mv s1, a0
; RV32-NEXT:    call bar@plt
; RV32-NEXT:    mv s0, a0
; RV32-NEXT:    call bar@plt
; RV32-NEXT:    add a1, s3, s1
; RV32-NEXT:    add a0, s0, a0
; RV32-NEXT:    add a0, a1, a0
; RV32-NEXT:    lw s3, 0(sp) # 4-byte Folded Reload
; RV32-NEXT:    lw s1, 4(sp) # 4-byte Folded Reload
; RV32-NEXT:    lw s0, 8(sp) # 4-byte Folded Reload
; RV32-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32-NEXT:    addi sp, sp, 16
; RV32-NEXT:    lw ra, -4(s2)
; RV32-NEXT:    addi s2, s2, -4
; RV32-NEXT:    ret
;
; RV64-LABEL: f4:
; RV64:       # %bb.0:
; RV64-NEXT:    sd ra, 0(s2)
; RV64-NEXT:    addi s2, s2, 8
; RV64-NEXT:    addi sp, sp, -32
; RV64-NEXT:    .cfi_def_cfa_offset 32
; RV64-NEXT:    sd ra, 24(sp) # 8-byte Folded Spill
; RV64-NEXT:    sd s0, 16(sp) # 8-byte Folded Spill
; RV64-NEXT:    sd s1, 8(sp) # 8-byte Folded Spill
; RV64-NEXT:    sd s3, 0(sp) # 8-byte Folded Spill
; RV64-NEXT:    .cfi_offset ra, -8
; RV64-NEXT:    .cfi_offset s0, -16
; RV64-NEXT:    .cfi_offset s1, -24
; RV64-NEXT:    .cfi_offset s3, -32
; RV64-NEXT:    call bar@plt
; RV64-NEXT:    mv s3, a0
; RV64-NEXT:    call bar@plt
; RV64-NEXT:    mv s1, a0
; RV64-NEXT:    call bar@plt
; RV64-NEXT:    mv s0, a0
; RV64-NEXT:    call bar@plt
; RV64-NEXT:    addw a1, s3, s1
; RV64-NEXT:    addw a0, s0, a0
; RV64-NEXT:    addw a0, a1, a0
; RV64-NEXT:    ld s3, 0(sp) # 8-byte Folded Reload
; RV64-NEXT:    ld s1, 8(sp) # 8-byte Folded Reload
; RV64-NEXT:    ld s0, 16(sp) # 8-byte Folded Reload
; RV64-NEXT:    ld ra, 24(sp) # 8-byte Folded Reload
; RV64-NEXT:    addi sp, sp, 32
; RV64-NEXT:    ld ra, -8(s2)
; RV64-NEXT:    addi s2, s2, -8
; RV64-NEXT:    ret
  %res1 = call i32 @bar()
  %res2 = call i32 @bar()
  %res3 = call i32 @bar()
  %res4 = call i32 @bar()
  %res12 = add i32 %res1, %res2
  %res34 = add i32 %res3, %res4
  %res1234 = add i32 %res12, %res34
  ret i32 %res1234
}

define i32 @f5() shadowcallstack nounwind {
; RV32-LABEL: f5:
; RV32:       # %bb.0:
; RV32-NEXT:    sw ra, 0(s2)
; RV32-NEXT:    addi s2, s2, 4
; RV32-NEXT:    addi sp, sp, -16
; RV32-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32-NEXT:    call bar@plt
; RV32-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32-NEXT:    addi sp, sp, 16
; RV32-NEXT:    lw ra, -4(s2)
; RV32-NEXT:    addi s2, s2, -4
; RV32-NEXT:    ret
;
; RV64-LABEL: f5:
; RV64:       # %bb.0:
; RV64-NEXT:    sd ra, 0(s2)
; RV64-NEXT:    addi s2, s2, 8
; RV64-NEXT:    addi sp, sp, -16
; RV64-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64-NEXT:    call bar@plt
; RV64-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64-NEXT:    addi sp, sp, 16
; RV64-NEXT:    ld ra, -8(s2)
; RV64-NEXT:    addi s2, s2, -8
; RV64-NEXT:    ret
  %res = call i32 @bar()
  %res1 = add i32 %res, 1
  ret i32 %res
}
