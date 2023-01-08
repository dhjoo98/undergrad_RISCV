; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -instcombine -S | FileCheck %s

declare void @use_f32(float)
declare void @use_v4f32(<4 x float>)

define <4 x float> @bitcast_inselt(i32 %x, <4 x i32> %v) {
; CHECK-LABEL: @bitcast_inselt(
; CHECK-NEXT:    [[TMP1:%.*]] = insertelement <4 x i32> [[V:%.*]], i32 [[X:%.*]], i32 0
; CHECK-NEXT:    [[R:%.*]] = bitcast <4 x i32> [[TMP1]] to <4 x float>
; CHECK-NEXT:    ret <4 x float> [[R]]
;
  %xf = bitcast i32 %x to float
  %vf = bitcast <4 x i32> %v to <4 x float>
  %r = insertelement <4 x float> %vf, float %xf, i32 0
  ret <4 x float> %r
}

define <4 x float> @bitcast_inselt_use1(i32 %x, <4 x i32> %v) {
; CHECK-LABEL: @bitcast_inselt_use1(
; CHECK-NEXT:    [[XF:%.*]] = bitcast i32 [[X:%.*]] to float
; CHECK-NEXT:    call void @use_f32(float [[XF]])
; CHECK-NEXT:    [[TMP1:%.*]] = insertelement <4 x i32> [[V:%.*]], i32 [[X]], i32 1
; CHECK-NEXT:    [[R:%.*]] = bitcast <4 x i32> [[TMP1]] to <4 x float>
; CHECK-NEXT:    ret <4 x float> [[R]]
;
  %xf = bitcast i32 %x to float
  call void @use_f32(float %xf)
  %vf = bitcast <4 x i32> %v to <4 x float>
  %r = insertelement <4 x float> %vf, float %xf, i32 1
  ret <4 x float> %r
}

define <4 x float> @bitcast_inselt_use2(i32 %x, <4 x i32> %v, i32 %index) {
; CHECK-LABEL: @bitcast_inselt_use2(
; CHECK-NEXT:    [[VF:%.*]] = bitcast <4 x i32> [[V:%.*]] to <4 x float>
; CHECK-NEXT:    call void @use_v4f32(<4 x float> [[VF]])
; CHECK-NEXT:    [[TMP1:%.*]] = insertelement <4 x i32> [[V]], i32 [[X:%.*]], i32 [[INDEX:%.*]]
; CHECK-NEXT:    [[R:%.*]] = bitcast <4 x i32> [[TMP1]] to <4 x float>
; CHECK-NEXT:    ret <4 x float> [[R]]
;
  %xf = bitcast i32 %x to float
  %vf = bitcast <4 x i32> %v to <4 x float>
  call void @use_v4f32(<4 x float> %vf)
  %r = insertelement <4 x float> %vf, float %xf, i32 %index
  ret <4 x float> %r
}

; Negative test - 2 extra uses would require an extra instruction.

define <4 x float> @bitcast_inselt_use3(i32 %x, <4 x i32> %v) {
; CHECK-LABEL: @bitcast_inselt_use3(
; CHECK-NEXT:    [[XF:%.*]] = bitcast i32 [[X:%.*]] to float
; CHECK-NEXT:    call void @use_f32(float [[XF]])
; CHECK-NEXT:    [[VF:%.*]] = bitcast <4 x i32> [[V:%.*]] to <4 x float>
; CHECK-NEXT:    call void @use_v4f32(<4 x float> [[VF]])
; CHECK-NEXT:    [[R:%.*]] = insertelement <4 x float> [[VF]], float [[XF]], i32 0
; CHECK-NEXT:    ret <4 x float> [[R]]
;
  %xf = bitcast i32 %x to float
  call void @use_f32(float %xf)
  %vf = bitcast <4 x i32> %v to <4 x float>
  call void @use_v4f32(<4 x float> %vf)
  %r = insertelement <4 x float> %vf, float %xf, i32 0
  ret <4 x float> %r
}

; Negative test - wrong source type for vector.

define <2 x float> @bitcast_inselt_wrong_bitcast1(i32 %x, i64 %notv) {
; CHECK-LABEL: @bitcast_inselt_wrong_bitcast1(
; CHECK-NEXT:    [[XF:%.*]] = bitcast i32 [[X:%.*]] to float
; CHECK-NEXT:    [[VF:%.*]] = bitcast i64 [[NOTV:%.*]] to <2 x float>
; CHECK-NEXT:    [[R:%.*]] = insertelement <2 x float> [[VF]], float [[XF]], i32 0
; CHECK-NEXT:    ret <2 x float> [[R]]
;
  %xf = bitcast i32 %x to float
  %vf = bitcast i64 %notv to <2 x float>
  %r = insertelement <2 x float> %vf, float %xf, i32 0
  ret <2 x float> %r
}

; Negative test - wrong source type for scalar.

define <2 x float> @bitcast_inselt_wrong_bitcast2(<2 x i16> %notscalar, <2 x i32> %v) {
; CHECK-LABEL: @bitcast_inselt_wrong_bitcast2(
; CHECK-NEXT:    [[XF:%.*]] = bitcast <2 x i16> [[NOTSCALAR:%.*]] to float
; CHECK-NEXT:    [[VF:%.*]] = bitcast <2 x i32> [[V:%.*]] to <2 x float>
; CHECK-NEXT:    [[R:%.*]] = insertelement <2 x float> [[VF]], float [[XF]], i32 0
; CHECK-NEXT:    ret <2 x float> [[R]]
;
  %xf = bitcast <2 x i16> %notscalar to float
  %vf = bitcast <2 x i32> %v to <2 x float>
  %r = insertelement <2 x float> %vf, float %xf, i32 0
  ret <2 x float> %r
}
