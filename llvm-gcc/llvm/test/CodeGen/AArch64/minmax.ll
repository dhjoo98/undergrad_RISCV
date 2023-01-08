; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=aarch64-linux-gnu | FileCheck %s

define <4 x i32> @t1(<4 x i32> %a, <4 x i32> %b) {
; CHECK-LABEL: t1:
; CHECK:       // %bb.0:
; CHECK-NEXT:    smax v0.4s, v0.4s, v1.4s
; CHECK-NEXT:    ret
  %t1 = icmp sgt <4 x i32> %a, %b
  %t2 = select <4 x i1> %t1, <4 x i32> %a, <4 x i32> %b
  ret <4 x i32> %t2
}

define <4 x i32> @t2(<4 x i32> %a, <4 x i32> %b) {
; CHECK-LABEL: t2:
; CHECK:       // %bb.0:
; CHECK-NEXT:    smin v0.4s, v0.4s, v1.4s
; CHECK-NEXT:    ret
  %t1 = icmp slt <4 x i32> %a, %b
  %t2 = select <4 x i1> %t1, <4 x i32> %a, <4 x i32> %b
  ret <4 x i32> %t2
}

define <4 x i32> @t3(<4 x i32> %a, <4 x i32> %b) {
; CHECK-LABEL: t3:
; CHECK:       // %bb.0:
; CHECK-NEXT:    umax v0.4s, v0.4s, v1.4s
; CHECK-NEXT:    ret
  %t1 = icmp ugt <4 x i32> %a, %b
  %t2 = select <4 x i1> %t1, <4 x i32> %a, <4 x i32> %b
  ret <4 x i32> %t2
}

define <8 x i8> @t4(<8 x i8> %a, <8 x i8> %b) {
; CHECK-LABEL: t4:
; CHECK:       // %bb.0:
; CHECK-NEXT:    umin v0.8b, v0.8b, v1.8b
; CHECK-NEXT:    ret
  %t1 = icmp ult <8 x i8> %a, %b
  %t2 = select <8 x i1> %t1, <8 x i8> %a, <8 x i8> %b
  ret <8 x i8> %t2
}

define <4 x i16> @t5(<4 x i16> %a, <4 x i16> %b) {
; CHECK-LABEL: t5:
; CHECK:       // %bb.0:
; CHECK-NEXT:    smin v0.4h, v1.4h, v0.4h
; CHECK-NEXT:    ret
  %t1 = icmp sgt <4 x i16> %b, %a
  %t2 = select <4 x i1> %t1, <4 x i16> %a, <4 x i16> %b
  ret <4 x i16> %t2
}

define <2 x i32> @t6(<2 x i32> %a, <2 x i32> %b) {
; CHECK-LABEL: t6:
; CHECK:       // %bb.0:
; CHECK-NEXT:    smax v0.2s, v1.2s, v0.2s
; CHECK-NEXT:    ret
  %t1 = icmp slt <2 x i32> %b, %a
  %t2 = select <2 x i1> %t1, <2 x i32> %a, <2 x i32> %b
  ret <2 x i32> %t2
}

define <16 x i8> @t7(<16 x i8> %a, <16 x i8> %b) {
; CHECK-LABEL: t7:
; CHECK:       // %bb.0:
; CHECK-NEXT:    umin v0.16b, v1.16b, v0.16b
; CHECK-NEXT:    ret
  %t1 = icmp ugt <16 x i8> %b, %a
  %t2 = select <16 x i1> %t1, <16 x i8> %a, <16 x i8> %b
  ret <16 x i8> %t2
}

define <8 x i16> @t8(<8 x i16> %a, <8 x i16> %b) {
; CHECK-LABEL: t8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    umax v0.8h, v1.8h, v0.8h
; CHECK-NEXT:    ret
  %t1 = icmp ult <8 x i16> %b, %a
  %t2 = select <8 x i1> %t1, <8 x i16> %a, <8 x i16> %b
  ret <8 x i16> %t2
}

define <4 x i32> @t9(<4 x i32> %a, <4 x i32> %b, <4 x i32> %c) {
; CHECK-LABEL: t9:
; CHECK:       // %bb.0:
; CHECK-NEXT:    umin v0.4s, v1.4s, v0.4s
; CHECK-NEXT:    smax v0.4s, v0.4s, v2.4s
; CHECK-NEXT:    ret
  %t1 = icmp ugt <4 x i32> %b, %a
  %t2 = select <4 x i1> %t1, <4 x i32> %a, <4 x i32> %b
  %t3 = icmp sge <4 x i32> %t2, %c
  %t4 = select <4 x i1> %t3, <4 x i32> %t2, <4 x i32> %c
  ret <4 x i32> %t4
}

define <8 x i32> @t10(<8 x i32> %a, <8 x i32> %b) {
; CHECK-LABEL: t10:
; CHECK:       // %bb.0:
; CHECK-NEXT:    smax v0.4s, v0.4s, v2.4s
; CHECK-NEXT:    smax v1.4s, v1.4s, v3.4s
; CHECK-NEXT:    ret
  %t1 = icmp sgt <8 x i32> %a, %b
  %t2 = select <8 x i1> %t1, <8 x i32> %a, <8 x i32> %b
  ret <8 x i32> %t2
}

define <16 x i32> @t11(<16 x i32> %a, <16 x i32> %b) {
; CHECK-LABEL: t11:
; CHECK:       // %bb.0:
; CHECK-NEXT:    smin v0.4s, v0.4s, v4.4s
; CHECK-NEXT:    smin v1.4s, v1.4s, v5.4s
; CHECK-NEXT:    smin v2.4s, v2.4s, v6.4s
; CHECK-NEXT:    smin v3.4s, v3.4s, v7.4s
; CHECK-NEXT:    ret
  %t1 = icmp sle <16 x i32> %a, %b
  %t2 = select <16 x i1> %t1, <16 x i32> %a, <16 x i32> %b
  ret <16 x i32> %t2
}

; The icmp is used by two instructions, so don't produce a umin node.
define <16 x i8> @t12(<16 x i8> %a, <16 x i8> %b) {
; CHECK-LABEL: t12:
; CHECK:       // %bb.0:
; CHECK-NEXT:    cmhi v2.16b, v1.16b, v0.16b
; CHECK-NEXT:    movi v3.16b, #1
; CHECK-NEXT:    bif v0.16b, v1.16b, v2.16b
; CHECK-NEXT:    and v1.16b, v2.16b, v3.16b
; CHECK-NEXT:    add v0.16b, v1.16b, v0.16b
; CHECK-NEXT:    ret
  %t1 = icmp ugt <16 x i8> %b, %a
  %t2 = select <16 x i1> %t1, <16 x i8> %a, <16 x i8> %b
  %t3 = zext <16 x i1> %t1 to <16 x i8>
  %t4 = add <16 x i8> %t3, %t2
  ret <16 x i8> %t4
}

define <1 x i64> @t13(<1 x i64> %a, <1 x i64> %b) {
; CHECK-LABEL: t13:
; CHECK:       // %bb.0:
; CHECK-NEXT:    cmhi d2, d1, d0
; CHECK-NEXT:    bif v0.8b, v1.8b, v2.8b
; CHECK-NEXT:    ret
  %t1 = icmp ult <1 x i64> %a, %b
  %t2 = select <1 x i1> %t1, <1 x i64> %a, <1 x i64> %b
  ret <1 x i64> %t2
}

define <2 x i64> @t14(<2 x i64> %a, <2 x i64> %b) {
; CHECK-LABEL: t14:
; CHECK:       // %bb.0:
; CHECK-NEXT:    cmhi v2.2d, v0.2d, v1.2d
; CHECK-NEXT:    bif v0.16b, v1.16b, v2.16b
; CHECK-NEXT:    ret
  %t1 = icmp ugt <2 x i64> %a, %b
  %t2 = select <2 x i1> %t1, <2 x i64> %a, <2 x i64> %b
  ret <2 x i64> %t2
}

define <4 x i64> @t15(<4 x i64> %a, <4 x i64> %b) {
; CHECK-LABEL: t15:
; CHECK:       // %bb.0:
; CHECK-NEXT:    cmhi v4.2d, v2.2d, v0.2d
; CHECK-NEXT:    cmhi v5.2d, v3.2d, v1.2d
; CHECK-NEXT:    bif v0.16b, v2.16b, v4.16b
; CHECK-NEXT:    bif v1.16b, v3.16b, v5.16b
; CHECK-NEXT:    ret
  %t1 = icmp ule <4 x i64> %a, %b
  %t2 = select <4 x i1> %t1, <4 x i64> %a, <4 x i64> %b
  ret <4 x i64> %t2
}
