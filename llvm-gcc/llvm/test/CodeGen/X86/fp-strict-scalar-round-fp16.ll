; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=i686-unknown-unknown -mattr=+avx512fp16 -O3 | FileCheck %s --check-prefixes=X86
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+avx512fp16 -O3 | FileCheck %s --check-prefixes=X64

declare half @llvm.experimental.constrained.ceil.f16(half, metadata)
declare half @llvm.experimental.constrained.floor.f16(half, metadata)
declare half @llvm.experimental.constrained.trunc.f16(half, metadata)
declare half @llvm.experimental.constrained.rint.f16(half, metadata, metadata)
declare half @llvm.experimental.constrained.nearbyint.f16(half, metadata, metadata)

define half @fceil32(half %f) #0 {
; X86-LABEL: fceil32:
; X86:       # %bb.0:
; X86-NEXT:    vrndscalesh $10, {{[0-9]+}}(%esp), %xmm0, %xmm0
; X86-NEXT:    retl
;
; X64-LABEL: fceil32:
; X64:       # %bb.0:
; X64-NEXT:    vrndscalesh $10, %xmm0, %xmm0, %xmm0
; X64-NEXT:    retq
  %res = call half @llvm.experimental.constrained.ceil.f16(
                        half %f, metadata !"fpexcept.strict") #0
  ret half %res
}

define half @ffloor32(half %f) #0 {
; X86-LABEL: ffloor32:
; X86:       # %bb.0:
; X86-NEXT:    vrndscalesh $9, {{[0-9]+}}(%esp), %xmm0, %xmm0
; X86-NEXT:    retl
;
; X64-LABEL: ffloor32:
; X64:       # %bb.0:
; X64-NEXT:    vrndscalesh $9, %xmm0, %xmm0, %xmm0
; X64-NEXT:    retq
  %res = call half @llvm.experimental.constrained.floor.f16(
                        half %f, metadata !"fpexcept.strict") #0
  ret half %res
}

define half @ftrunc32(half %f) #0 {
; X86-LABEL: ftrunc32:
; X86:       # %bb.0:
; X86-NEXT:    vrndscalesh $11, {{[0-9]+}}(%esp), %xmm0, %xmm0
; X86-NEXT:    retl
;
; X64-LABEL: ftrunc32:
; X64:       # %bb.0:
; X64-NEXT:    vrndscalesh $11, %xmm0, %xmm0, %xmm0
; X64-NEXT:    retq
  %res = call half @llvm.experimental.constrained.trunc.f16(
                        half %f, metadata !"fpexcept.strict") #0
  ret half %res
}

define half @frint32(half %f) #0 {
; X86-LABEL: frint32:
; X86:       # %bb.0:
; X86-NEXT:    vrndscalesh $4, {{[0-9]+}}(%esp), %xmm0, %xmm0
; X86-NEXT:    retl
;
; X64-LABEL: frint32:
; X64:       # %bb.0:
; X64-NEXT:    vrndscalesh $4, %xmm0, %xmm0, %xmm0
; X64-NEXT:    retq
  %res = call half @llvm.experimental.constrained.rint.f16(
                        half %f,
                        metadata !"round.dynamic", metadata !"fpexcept.strict") #0
  ret half %res
}

define half @fnearbyint32(half %f) #0 {
; X86-LABEL: fnearbyint32:
; X86:       # %bb.0:
; X86-NEXT:    vrndscalesh $12, {{[0-9]+}}(%esp), %xmm0, %xmm0
; X86-NEXT:    retl
;
; X64-LABEL: fnearbyint32:
; X64:       # %bb.0:
; X64-NEXT:    vrndscalesh $12, %xmm0, %xmm0, %xmm0
; X64-NEXT:    retq
  %res = call half @llvm.experimental.constrained.nearbyint.f16(
                        half %f,
                        metadata !"round.dynamic", metadata !"fpexcept.strict") #0
  ret half %res
}

attributes #0 = { strictfp }
