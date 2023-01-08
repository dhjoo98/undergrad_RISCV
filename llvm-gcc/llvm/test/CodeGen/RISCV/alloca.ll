; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -verify-machineinstrs < %s \
; RUN:   | FileCheck %s -check-prefix=RV32I

declare void @notdead(i8*)

; These tests must ensure the stack pointer is restored using the frame
; pointer

define void @simple_alloca(i32 %n) nounwind {
; RV32I-LABEL: simple_alloca:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi sp, sp, -16
; RV32I-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32I-NEXT:    sw s0, 8(sp) # 4-byte Folded Spill
; RV32I-NEXT:    addi s0, sp, 16
; RV32I-NEXT:    addi a0, a0, 15
; RV32I-NEXT:    andi a0, a0, -16
; RV32I-NEXT:    sub a0, sp, a0
; RV32I-NEXT:    mv sp, a0
; RV32I-NEXT:    call notdead@plt
; RV32I-NEXT:    addi sp, s0, -16
; RV32I-NEXT:    lw s0, 8(sp) # 4-byte Folded Reload
; RV32I-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32I-NEXT:    addi sp, sp, 16
; RV32I-NEXT:    ret
  %1 = alloca i8, i32 %n
  call void @notdead(i8* %1)
  ret void
}

declare i8* @llvm.stacksave()
declare void @llvm.stackrestore(i8*)

define void @scoped_alloca(i32 %n) nounwind {
; RV32I-LABEL: scoped_alloca:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi sp, sp, -16
; RV32I-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32I-NEXT:    sw s0, 8(sp) # 4-byte Folded Spill
; RV32I-NEXT:    sw s1, 4(sp) # 4-byte Folded Spill
; RV32I-NEXT:    addi s0, sp, 16
; RV32I-NEXT:    mv s1, sp
; RV32I-NEXT:    addi a0, a0, 15
; RV32I-NEXT:    andi a0, a0, -16
; RV32I-NEXT:    sub a0, sp, a0
; RV32I-NEXT:    mv sp, a0
; RV32I-NEXT:    call notdead@plt
; RV32I-NEXT:    mv sp, s1
; RV32I-NEXT:    addi sp, s0, -16
; RV32I-NEXT:    lw s1, 4(sp) # 4-byte Folded Reload
; RV32I-NEXT:    lw s0, 8(sp) # 4-byte Folded Reload
; RV32I-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32I-NEXT:    addi sp, sp, 16
; RV32I-NEXT:    ret
  %sp = call i8* @llvm.stacksave()
  %addr = alloca i8, i32 %n
  call void @notdead(i8* %addr)
  call void @llvm.stackrestore(i8* %sp)
  ret void
}

declare void @func(i8*, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32)

; Check that outgoing arguments passed on the stack do not corrupt a
; variable-sized stack object.
define void @alloca_callframe(i32 %n) nounwind {
; RV32I-LABEL: alloca_callframe:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi sp, sp, -16
; RV32I-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32I-NEXT:    sw s0, 8(sp) # 4-byte Folded Spill
; RV32I-NEXT:    addi s0, sp, 16
; RV32I-NEXT:    addi a0, a0, 15
; RV32I-NEXT:    andi a0, a0, -16
; RV32I-NEXT:    sub a0, sp, a0
; RV32I-NEXT:    mv sp, a0
; RV32I-NEXT:    addi sp, sp, -16
; RV32I-NEXT:    addi a1, zero, 12
; RV32I-NEXT:    sw a1, 12(sp)
; RV32I-NEXT:    addi a1, zero, 11
; RV32I-NEXT:    sw a1, 8(sp)
; RV32I-NEXT:    addi a1, zero, 10
; RV32I-NEXT:    sw a1, 4(sp)
; RV32I-NEXT:    addi t0, zero, 9
; RV32I-NEXT:    addi a1, zero, 2
; RV32I-NEXT:    addi a2, zero, 3
; RV32I-NEXT:    addi a3, zero, 4
; RV32I-NEXT:    addi a4, zero, 5
; RV32I-NEXT:    addi a5, zero, 6
; RV32I-NEXT:    addi a6, zero, 7
; RV32I-NEXT:    addi a7, zero, 8
; RV32I-NEXT:    sw t0, 0(sp)
; RV32I-NEXT:    call func@plt
; RV32I-NEXT:    addi sp, sp, 16
; RV32I-NEXT:    addi sp, s0, -16
; RV32I-NEXT:    lw s0, 8(sp) # 4-byte Folded Reload
; RV32I-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32I-NEXT:    addi sp, sp, 16
; RV32I-NEXT:    ret
  %1 = alloca i8, i32 %n
  call void @func(i8* %1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8,
                  i32 9, i32 10, i32 11, i32 12)
  ret void
}
