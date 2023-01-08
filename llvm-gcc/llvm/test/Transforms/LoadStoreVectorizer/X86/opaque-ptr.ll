; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -mtriple=x86_64-unknown-linux-gnu -load-store-vectorizer -S < %s | FileCheck %s

define void @test(ptr %ptr) {
; CHECK-LABEL: @test(
; CHECK-NEXT:    [[TMP1:%.*]] = bitcast ptr [[PTR:%.*]] to <2 x i32>*
; CHECK-NEXT:    [[TMP2:%.*]] = load <2 x i32>, <2 x i32>* [[TMP1]], align 4
; CHECK-NEXT:    [[L11:%.*]] = extractelement <2 x i32> [[TMP2]], i32 0
; CHECK-NEXT:    [[L22:%.*]] = extractelement <2 x i32> [[TMP2]], i32 1
; CHECK-NEXT:    [[TMP3:%.*]] = bitcast ptr [[PTR]] to <2 x i32>*
; CHECK-NEXT:    store <2 x i32> zeroinitializer, <2 x i32>* [[TMP3]], align 4
; CHECK-NEXT:    ret void
;
  %ptr2 = getelementptr i32, ptr %ptr, i64 1
  %l1 = load i32, ptr %ptr, align 4
  %l2 = load i32, ptr %ptr2, align 4
  store i32 0, ptr %ptr, align 4
  store i32 0, ptr %ptr2, align 4
  ret void
}

