; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=aarch64-unknown-linux-gnu | FileCheck %s

; Test cases of bitcasts where one type needs to be widened and one needs to be promoted.

define <2 x i16> @bitcast_v2i16_v2f16(<2 x half> %x) {
; CHECK-LABEL: bitcast_v2i16_v2f16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $d0 killed $d0 def $q0
; CHECK-NEXT:    umov w8, v0.h[0]
; CHECK-NEXT:    fmov s1, w8
; CHECK-NEXT:    umov w8, v0.h[1]
; CHECK-NEXT:    mov v1.s[1], w8
; CHECK-NEXT:    fmov d0, d1
; CHECK-NEXT:    ret
  %y = bitcast <2 x half> %x to <2 x i16>
  ret <2 x i16> %y
}

define <2 x half> @bitcast_v2f16_v2i16(<2 x i16> %x) {
; CHECK-LABEL: bitcast_v2f16_v2i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    uzp1 v0.4h, v0.4h, v0.4h
; CHECK-NEXT:    ret
  %y = bitcast <2 x i16> %x to <2 x half>
  ret <2 x half> %y
}
