; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -basic-aa -enable-load-pre -enable-pre -gvn -S < %s | FileCheck %s

declare void @side_effect_0() nofree

declare void @side_effect_1(i32 %x) nofree

declare void @no_side_effect() readonly

; TODO: We can PRE the load into the cold path, removing it from the hot path.
define i32 @test_01(i32* %p) {
; CHECK-LABEL: @test_01(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    [[IV:%.*]] = phi i32 [ 0, [[ENTRY:%.*]] ], [ [[IV_NEXT:%.*]], [[BACKEDGE:%.*]] ]
; CHECK-NEXT:    [[X:%.*]] = load i32, i32* [[P:%.*]], align 4
; CHECK-NEXT:    [[COND:%.*]] = icmp ult i32 [[X]], 100
; CHECK-NEXT:    br i1 [[COND]], label [[HOT_PATH:%.*]], label [[COLD_PATH:%.*]]
; CHECK:       hot_path:
; CHECK-NEXT:    br label [[BACKEDGE]]
; CHECK:       cold_path:
; CHECK-NEXT:    call void @side_effect_0() #[[ATTR0:[0-9]+]]
; CHECK-NEXT:    br label [[BACKEDGE]]
; CHECK:       backedge:
; CHECK-NEXT:    [[IV_NEXT]] = add i32 [[IV]], [[X]]
; CHECK-NEXT:    [[LOOP_COND:%.*]] = icmp ult i32 [[IV_NEXT]], 1000
; CHECK-NEXT:    br i1 [[LOOP_COND]], label [[LOOP]], label [[EXIT:%.*]]
; CHECK:       exit:
; CHECK-NEXT:    ret i32 [[X]]
;
entry:
  br label %loop

loop:
  %iv = phi i32 [ 0, %entry], [%iv.next, %backedge]
  %x = load i32, i32* %p
  %cond = icmp ult i32 %x, 100
  br i1 %cond, label %hot_path, label %cold_path

hot_path:
  br label %backedge

cold_path:
  call void @side_effect_0() nofree
  br label %backedge

backedge:
  %iv.next = add i32 %iv, %x
  %loop.cond = icmp ult i32 %iv.next, 1000
  br i1 %loop.cond, label %loop, label %exit

exit:
  ret i32 %x
}

; TODO: We can PRE the load into the cold path, removing it from the hot path.
define i32 @test_02(i32* %p) {
; CHECK-LABEL: @test_02(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    [[IV:%.*]] = phi i32 [ 0, [[ENTRY:%.*]] ], [ [[IV_NEXT:%.*]], [[BACKEDGE:%.*]] ]
; CHECK-NEXT:    [[X:%.*]] = load i32, i32* [[P:%.*]], align 4
; CHECK-NEXT:    [[COND:%.*]] = icmp ult i32 [[X]], 100
; CHECK-NEXT:    br i1 [[COND]], label [[HOT_PATH:%.*]], label [[COLD_PATH:%.*]]
; CHECK:       hot_path:
; CHECK-NEXT:    br label [[BACKEDGE]]
; CHECK:       cold_path:
; CHECK-NEXT:    call void @side_effect_1(i32 [[X]]) #[[ATTR0]]
; CHECK-NEXT:    br label [[BACKEDGE]]
; CHECK:       backedge:
; CHECK-NEXT:    [[IV_NEXT]] = add i32 [[IV]], [[X]]
; CHECK-NEXT:    [[LOOP_COND:%.*]] = icmp ult i32 [[IV_NEXT]], 1000
; CHECK-NEXT:    br i1 [[LOOP_COND]], label [[LOOP]], label [[EXIT:%.*]]
; CHECK:       exit:
; CHECK-NEXT:    ret i32 [[X]]
;
entry:
  br label %loop

loop:
  %iv = phi i32 [ 0, %entry], [%iv.next, %backedge]
  %x = load i32, i32* %p
  %cond = icmp ult i32 %x, 100
  br i1 %cond, label %hot_path, label %cold_path

hot_path:
  br label %backedge

cold_path:
  call void @side_effect_1(i32 %x) nofree
  br label %backedge

backedge:
  %iv.next = add i32 %iv, %x
  %loop.cond = icmp ult i32 %iv.next, 1000
  br i1 %loop.cond, label %loop, label %exit

exit:
  ret i32 %x
}

define i32 @test_03(i32* %p) {
; CHECK-LABEL: @test_03(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[X_PRE:%.*]] = load i32, i32* [[P:%.*]], align 4
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    [[IV:%.*]] = phi i32 [ 0, [[ENTRY:%.*]] ], [ [[IV_NEXT:%.*]], [[BACKEDGE:%.*]] ]
; CHECK-NEXT:    [[COND:%.*]] = icmp ult i32 [[X_PRE]], 100
; CHECK-NEXT:    br i1 [[COND]], label [[HOT_PATH:%.*]], label [[COLD_PATH:%.*]]
; CHECK:       hot_path:
; CHECK-NEXT:    br label [[BACKEDGE]]
; CHECK:       cold_path:
; CHECK-NEXT:    call void @no_side_effect()
; CHECK-NEXT:    br label [[BACKEDGE]]
; CHECK:       backedge:
; CHECK-NEXT:    [[IV_NEXT]] = add i32 [[IV]], [[X_PRE]]
; CHECK-NEXT:    [[LOOP_COND:%.*]] = icmp ult i32 [[IV_NEXT]], 1000
; CHECK-NEXT:    br i1 [[LOOP_COND]], label [[LOOP]], label [[EXIT:%.*]]
; CHECK:       exit:
; CHECK-NEXT:    ret i32 [[X_PRE]]
;
entry:
  br label %loop

loop:
  %iv = phi i32 [ 0, %entry], [%iv.next, %backedge]
  %x = load i32, i32* %p
  %cond = icmp ult i32 %x, 100
  br i1 %cond, label %hot_path, label %cold_path

hot_path:
  br label %backedge

cold_path:
  call void @no_side_effect()
  br label %backedge

backedge:
  %iv.next = add i32 %iv, %x
  %loop.cond = icmp ult i32 %iv.next, 1000
  br i1 %loop.cond, label %loop, label %exit

exit:
  ret i32 %x
}
