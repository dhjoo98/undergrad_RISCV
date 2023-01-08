; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -S -iroutliner -ir-outlining-no-cost < %s | FileCheck %s

; This test tests that inputs that are replaced with the output of an outlined
; function is still recognized as the same value.

define void @outline_outputs1() #0 {
; CHECK-LABEL: @outline_outputs1(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[DOTLOC2:%.*]] = alloca i32, align 4
; CHECK-NEXT:    [[ADD2_LOC:%.*]] = alloca i32, align 4
; CHECK-NEXT:    [[DOTLOC:%.*]] = alloca i32, align 4
; CHECK-NEXT:    [[ADD_LOC:%.*]] = alloca i32, align 4
; CHECK-NEXT:    [[A:%.*]] = alloca i32, align 4
; CHECK-NEXT:    [[B:%.*]] = alloca i32, align 4
; CHECK-NEXT:    [[OUTPUT:%.*]] = alloca i32, align 4
; CHECK-NEXT:    [[RESULT:%.*]] = alloca i32, align 4
; CHECK-NEXT:    [[OUTPUT2:%.*]] = alloca i32, align 4
; CHECK-NEXT:    [[RESULT2:%.*]] = alloca i32, align 4
; CHECK-NEXT:    [[LT_CAST:%.*]] = bitcast i32* [[ADD_LOC]] to i8*
; CHECK-NEXT:    call void @llvm.lifetime.start.p0i8(i64 -1, i8* [[LT_CAST]])
; CHECK-NEXT:    [[LT_CAST1:%.*]] = bitcast i32* [[DOTLOC]] to i8*
; CHECK-NEXT:    call void @llvm.lifetime.start.p0i8(i64 -1, i8* [[LT_CAST1]])
; CHECK-NEXT:    call void @outlined_ir_func_0(i32 2, i32* [[A]], i32* [[B]], i32* [[OUTPUT]], i32* [[ADD_LOC]], i32* [[DOTLOC]])
; CHECK-NEXT:    [[ADD_RELOAD:%.*]] = load i32, i32* [[ADD_LOC]], align 4
; CHECK-NEXT:    [[DOTRELOAD:%.*]] = load i32, i32* [[DOTLOC]], align 4
; CHECK-NEXT:    call void @llvm.lifetime.end.p0i8(i64 -1, i8* [[LT_CAST]])
; CHECK-NEXT:    call void @llvm.lifetime.end.p0i8(i64 -1, i8* [[LT_CAST1]])
; CHECK-NEXT:    [[TMP0:%.*]] = load i32, i32* [[OUTPUT]], align 4
; CHECK-NEXT:    call void @outlined_ir_func_1(i32 [[DOTRELOAD]], i32 [[ADD_RELOAD]], i32* [[RESULT]])
; CHECK-NEXT:    br label [[NEXT:%.*]]
; CHECK:       next:
; CHECK-NEXT:    [[LT_CAST4:%.*]] = bitcast i32* [[ADD2_LOC]] to i8*
; CHECK-NEXT:    call void @llvm.lifetime.start.p0i8(i64 -1, i8* [[LT_CAST4]])
; CHECK-NEXT:    [[LT_CAST5:%.*]] = bitcast i32* [[DOTLOC2]] to i8*
; CHECK-NEXT:    call void @llvm.lifetime.start.p0i8(i64 -1, i8* [[LT_CAST5]])
; CHECK-NEXT:    call void @outlined_ir_func_0(i32 [[ADD_RELOAD]], i32* [[OUTPUT]], i32* [[RESULT]], i32* [[OUTPUT2]], i32* [[ADD2_LOC]], i32* [[DOTLOC2]])
; CHECK-NEXT:    [[ADD2_RELOAD:%.*]] = load i32, i32* [[ADD2_LOC]], align 4
; CHECK-NEXT:    [[DOTRELOAD3:%.*]] = load i32, i32* [[DOTLOC2]], align 4
; CHECK-NEXT:    call void @llvm.lifetime.end.p0i8(i64 -1, i8* [[LT_CAST4]])
; CHECK-NEXT:    call void @llvm.lifetime.end.p0i8(i64 -1, i8* [[LT_CAST5]])
; CHECK-NEXT:    call void @outlined_ir_func_1(i32 [[DOTRELOAD3]], i32 [[ADD2_RELOAD]], i32* [[RESULT2]])
; CHECK-NEXT:    ret void
;
entry:
  %a = alloca i32, align 4
  %b = alloca i32, align 4
  %output = alloca i32, align 4
  %result = alloca i32, align 4
  %output2 = alloca i32, align 4
  %result2 = alloca i32, align 4
  store i32 2, i32* %a, align 4
  store i32 3, i32* %b, align 4
  %0 = load i32, i32* %a, align 4
  %1 = load i32, i32* %b, align 4
  %add = add i32 %0, %1
  store i32 %add, i32* %output, align 4
  %2 = load i32, i32* %output, align 4
  %3 = load i32, i32* %output, align 4
  %mul = mul i32 %2, %add
  store i32 %mul, i32* %result, align 4
  br label %next
next:
  store i32 %add, i32* %output, align 4
  store i32 3, i32* %result, align 4
  %4 = load i32, i32* %output, align 4
  %5 = load i32, i32* %result, align 4
  %add2 = add i32 %4, %5
  store i32 %add2, i32* %output2, align 4
  %6 = load i32, i32* %output2, align 4
  %mul2 = mul i32 %6, %add2
  store i32 %mul2, i32* %result2, align 4
  ret void
}