; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -S -instcombine < %s | FileCheck %s

declare float @llvm.fabs.f32(float)
declare float @llvm.copysign.f32(float, float)
declare float @llvm.maxnum.f32(float, float)
declare <3 x double> @llvm.copysign.v3f64(<3 x double>, <3 x double>)

define float @positive_sign_arg(float %x) {
; CHECK-LABEL: @positive_sign_arg(
; CHECK-NEXT:    [[TMP1:%.*]] = call arcp float @llvm.fabs.f32(float [[X:%.*]])
; CHECK-NEXT:    ret float [[TMP1]]
;
  %r = call arcp float @llvm.copysign.f32(float %x, float 0.0)
  ret float %r
}

define <3 x double> @positive_sign_arg_vec_splat(<3 x double> %x) {
; CHECK-LABEL: @positive_sign_arg_vec_splat(
; CHECK-NEXT:    [[TMP1:%.*]] = call ninf <3 x double> @llvm.fabs.v3f64(<3 x double> [[X:%.*]])
; CHECK-NEXT:    ret <3 x double> [[TMP1]]
;
  %r = call ninf <3 x double> @llvm.copysign.v3f64(<3 x double> %x, <3 x double> <double 42.0, double 42.0, double 42.0>)
  ret <3 x double> %r
}

define float @negative_sign_arg(float %x) {
; CHECK-LABEL: @negative_sign_arg(
; CHECK-NEXT:    [[TMP1:%.*]] = call nnan float @llvm.fabs.f32(float [[X:%.*]])
; CHECK-NEXT:    [[TMP2:%.*]] = fneg nnan float [[TMP1]]
; CHECK-NEXT:    ret float [[TMP2]]
;
  %r = call nnan float @llvm.copysign.f32(float %x, float -0.0)
  ret float %r
}

define <3 x double> @negative_sign_arg_vec_splat(<3 x double> %x) {
; CHECK-LABEL: @negative_sign_arg_vec_splat(
; CHECK-NEXT:    [[TMP1:%.*]] = call fast <3 x double> @llvm.fabs.v3f64(<3 x double> [[X:%.*]])
; CHECK-NEXT:    [[TMP2:%.*]] = fneg fast <3 x double> [[TMP1]]
; CHECK-NEXT:    ret <3 x double> [[TMP2]]
;
  %r = call fast <3 x double> @llvm.copysign.v3f64(<3 x double> %x, <3 x double> <double -42.0, double -42.0, double -42.0>)
  ret <3 x double> %r
}

define float @known_positive_sign_arg(float %x, float %y) {
; CHECK-LABEL: @known_positive_sign_arg(
; CHECK-NEXT:    [[TMP1:%.*]] = call ninf float @llvm.fabs.f32(float [[X:%.*]])
; CHECK-NEXT:    ret float [[TMP1]]
;
  %fabs = call float @llvm.fabs.f32(float %y)
  %r = call ninf float @llvm.copysign.f32(float %x, float %fabs)
  ret float %r
}

define <3 x double> @known_positive_sign_arg_vec(<3 x double> %x, <3 x i32> %y) {
; CHECK-LABEL: @known_positive_sign_arg_vec(
; CHECK-NEXT:    [[TMP1:%.*]] = call arcp <3 x double> @llvm.fabs.v3f64(<3 x double> [[X:%.*]])
; CHECK-NEXT:    ret <3 x double> [[TMP1]]
;
  %yf = uitofp <3 x i32> %y to <3 x double>
  %r = call arcp <3 x double> @llvm.copysign.v3f64(<3 x double> %x, <3 x double> %yf)
  ret <3 x double> %r
}

; maxnum(-0.0, 0.0) can return -0.0.

define float @not_known_positive_sign_arg(float %x, float %y) {
; CHECK-LABEL: @not_known_positive_sign_arg(
; CHECK-NEXT:    [[MAX:%.*]] = call float @llvm.maxnum.f32(float [[X:%.*]], float 0.000000e+00)
; CHECK-NEXT:    [[R:%.*]] = call ninf float @llvm.copysign.f32(float [[Y:%.*]], float [[MAX]])
; CHECK-NEXT:    ret float [[R]]
;
  %max = call float @llvm.maxnum.f32(float %x, float 0.0)
  %r = call ninf float @llvm.copysign.f32(float %y, float %max)
  ret float %r
}

; The magnitude operand of the 1st copysign is irrelevant.
; copysign(x, copysign(y, z)) --> copysign(x, z)

define float @copysign_sign_arg(float %x, float %y, float %z) {
; CHECK-LABEL: @copysign_sign_arg(
; CHECK-NEXT:    [[R:%.*]] = call ninf float @llvm.copysign.f32(float [[X:%.*]], float [[Z:%.*]])
; CHECK-NEXT:    ret float [[R]]
;
  %s = call reassoc float @llvm.copysign.f32(float %y, float %z)
  %r = call ninf float @llvm.copysign.f32(float %x, float %s)
  ret float %r
}

define float @fneg_mag(float %x, float %y) {
; CHECK-LABEL: @fneg_mag(
; CHECK-NEXT:    [[R:%.*]] = call float @llvm.copysign.f32(float [[X:%.*]], float [[Y:%.*]])
; CHECK-NEXT:    ret float [[R]]
;
  %n = fneg float %x
  %r = call float @llvm.copysign.f32(float %n, float %y)
  ret float %r
}

define float @fabs_mag(float %x, float %y) {
; CHECK-LABEL: @fabs_mag(
; CHECK-NEXT:    [[R:%.*]] = call float @llvm.copysign.f32(float [[X:%.*]], float [[Y:%.*]])
; CHECK-NEXT:    ret float [[R]]
;
  %a = call float @llvm.fabs.f32(float %x)
  %r = call float @llvm.copysign.f32(float %a, float %y)
  ret float %r
}
