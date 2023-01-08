; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv64 -mattr=+experimental-b -verify-machineinstrs < %s \
; RUN:   | FileCheck %s -check-prefix=RV64B
; RUN: llc -mtriple=riscv64 -mattr=+experimental-zbe -verify-machineinstrs < %s \
; RUN:   | FileCheck %s -check-prefix=RV64ZBE

declare i32 @llvm.riscv.bcompress.i32(i32 %a, i32 %b)

define signext i32 @bcompress32(i32 signext %a, i32 signext %b) nounwind {
; RV64B-LABEL: bcompress32:
; RV64B:       # %bb.0:
; RV64B-NEXT:    bcompressw a0, a0, a1
; RV64B-NEXT:    ret
;
; RV64ZBE-LABEL: bcompress32:
; RV64ZBE:       # %bb.0:
; RV64ZBE-NEXT:    bcompressw a0, a0, a1
; RV64ZBE-NEXT:    ret
  %tmp = call i32 @llvm.riscv.bcompress.i32(i32 %a, i32 %b)
  ret i32 %tmp
}

define signext i32 @bcompress32_demandedbits(i32 signext %a, i32 signext %b, i32 signext %c, i32 signext %d) nounwind {
; RV64B-LABEL: bcompress32_demandedbits:
; RV64B:       # %bb.0:
; RV64B-NEXT:    add a0, a0, a1
; RV64B-NEXT:    add a1, a2, a3
; RV64B-NEXT:    bcompressw a0, a0, a1
; RV64B-NEXT:    ret
;
; RV64ZBE-LABEL: bcompress32_demandedbits:
; RV64ZBE:       # %bb.0:
; RV64ZBE-NEXT:    add a0, a0, a1
; RV64ZBE-NEXT:    add a1, a2, a3
; RV64ZBE-NEXT:    bcompressw a0, a0, a1
; RV64ZBE-NEXT:    ret
  %e = add i32 %a, %b
  %f = add i32 %c, %d
  %tmp = call i32 @llvm.riscv.bcompress.i32(i32 %e, i32 %f)
  ret i32 %tmp
}

declare i32 @llvm.riscv.bdecompress.i32(i32 %a, i32 %b)

define signext i32 @bdecompress32(i32 signext %a, i32 signext %b) nounwind {
; RV64B-LABEL: bdecompress32:
; RV64B:       # %bb.0:
; RV64B-NEXT:    bdecompressw a0, a0, a1
; RV64B-NEXT:    ret
;
; RV64ZBE-LABEL: bdecompress32:
; RV64ZBE:       # %bb.0:
; RV64ZBE-NEXT:    bdecompressw a0, a0, a1
; RV64ZBE-NEXT:    ret
  %tmp = call i32 @llvm.riscv.bdecompress.i32(i32 %a, i32 %b)
  ret i32 %tmp
}

define signext i32 @bdecompress32_demandedbits(i32 signext %a, i32 signext %b, i32 signext %c, i32 signext %d) nounwind {
; RV64B-LABEL: bdecompress32_demandedbits:
; RV64B:       # %bb.0:
; RV64B-NEXT:    add a0, a0, a1
; RV64B-NEXT:    add a1, a2, a3
; RV64B-NEXT:    bdecompressw a0, a0, a1
; RV64B-NEXT:    ret
;
; RV64ZBE-LABEL: bdecompress32_demandedbits:
; RV64ZBE:       # %bb.0:
; RV64ZBE-NEXT:    add a0, a0, a1
; RV64ZBE-NEXT:    add a1, a2, a3
; RV64ZBE-NEXT:    bdecompressw a0, a0, a1
; RV64ZBE-NEXT:    ret
  %e = add i32 %a, %b
  %f = add i32 %c, %d
  %tmp = call i32 @llvm.riscv.bdecompress.i32(i32 %e, i32 %f)
  ret i32 %tmp
}

declare i64 @llvm.riscv.bcompress.i64(i64 %a, i64 %b)

define i64 @bcompress64(i64 %a, i64 %b) nounwind {
; RV64B-LABEL: bcompress64:
; RV64B:       # %bb.0:
; RV64B-NEXT:    bcompress a0, a0, a1
; RV64B-NEXT:    ret
;
; RV64ZBE-LABEL: bcompress64:
; RV64ZBE:       # %bb.0:
; RV64ZBE-NEXT:    bcompress a0, a0, a1
; RV64ZBE-NEXT:    ret
  %tmp = call i64 @llvm.riscv.bcompress.i64(i64 %a, i64 %b)
  ret i64 %tmp
}

declare i64 @llvm.riscv.bdecompress.i64(i64 %a, i64 %b)

define i64 @bdecompress64(i64 %a, i64 %b) nounwind {
; RV64B-LABEL: bdecompress64:
; RV64B:       # %bb.0:
; RV64B-NEXT:    bdecompress a0, a0, a1
; RV64B-NEXT:    ret
;
; RV64ZBE-LABEL: bdecompress64:
; RV64ZBE:       # %bb.0:
; RV64ZBE-NEXT:    bdecompress a0, a0, a1
; RV64ZBE-NEXT:    ret
  %tmp = call i64 @llvm.riscv.bdecompress.i64(i64 %a, i64 %b)
  ret i64 %tmp
}