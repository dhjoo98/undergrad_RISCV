; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=x86_64-apple-darwin -mcpu=skylake | FileCheck %s

@global = external global i32, align 4

define void @foo(<8 x i32>* %x, <8 x i1> %y) {
; CHECK-LABEL: foo:
; CHECK:       ## %bb.0:
; CHECK-NEXT:    vpcmpeqd %ymm1, %ymm1, %ymm1
; CHECK-NEXT:    vpxor %xmm2, %xmm2, %xmm2
; CHECK-NEXT:    movq _global@GOTPCREL(%rip), %rax
; CHECK-NEXT:    vpgatherdd %ymm1, (%rax,%ymm2), %ymm3
; CHECK-NEXT:    vpmovzxwd {{.*#+}} ymm0 = xmm0[0],zero,xmm0[1],zero,xmm0[2],zero,xmm0[3],zero,xmm0[4],zero,xmm0[5],zero,xmm0[6],zero,xmm0[7],zero
; CHECK-NEXT:    vpslld $31, %ymm0, %ymm0
; CHECK-NEXT:    vpmaskmovd %ymm3, %ymm0, (%rdi)
; CHECK-NEXT:    ud2
  %tmp = call <8 x i32> @llvm.masked.gather.v8i32.v8p0i32(<8 x i32*> <i32* @global, i32* @global, i32* @global, i32* @global, i32* @global, i32* @global, i32* @global, i32* @global>, i32 4, <8 x i1> <i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true>, <8 x i32> undef)
  call void @llvm.masked.store.v8i32.p0v8i32(<8 x i32> %tmp, <8 x i32>* %x, i32 4, <8 x i1> %y)
  unreachable
}

declare <8 x i32> @llvm.masked.gather.v8i32.v8p0i32(<8 x i32*>, i32, <8 x i1>, <8 x i32>)
declare void @llvm.masked.store.v8i32.p0v8i32(<8 x i32>, <8 x i32>*, i32, <8 x i1>)