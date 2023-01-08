; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -instsimplify -S | FileCheck %s

define i1 @isnan_01() {
; CHECK-LABEL: @isnan_01(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    ret i1 true
;
entry:
  %0 = tail call i1 @llvm.isnan.f32(float 0x7FF8000000000000)
  ret i1 %0
}

define i1 @isnan_02() {
; CHECK-LABEL: @isnan_02(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    ret i1 false
;
entry:
  %0 = tail call i1 @llvm.isnan.f32(float 0x7FF0000000000000)
  ret i1 %0
}

define <4 x i1> @isnan_03() {
; CHECK-LABEL: @isnan_03(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    ret <4 x i1> <i1 true, i1 false, i1 false, i1 true>
;
entry:
  %0 = tail call <4 x i1> @llvm.isnan.v4f32(<4 x float><float 0x7FF8000000000000, float 0x7FF0000000000000, float 1.0, float 0xFFF8000000000000>)
  ret <4 x i1> %0
}

declare i1 @llvm.isnan.f32(float)
declare <4 x i1> @llvm.isnan.v4f32(<4 x float>)
