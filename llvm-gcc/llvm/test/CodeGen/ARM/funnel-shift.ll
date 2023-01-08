; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=arm-eabi -mattr=+v6t2 | FileCheck %s --check-prefixes=CHECK,SCALAR
; RUN: llc < %s -mtriple=arm-eabi -mattr=+v6t2 -mattr=+neon | FileCheck %s --check-prefixes=CHECK,NEON

declare i8 @llvm.fshl.i8(i8, i8, i8)
declare i16 @llvm.fshl.i16(i16, i16, i16)
declare i32 @llvm.fshl.i32(i32, i32, i32)
declare i64 @llvm.fshl.i64(i64, i64, i64)
declare <4 x i32> @llvm.fshl.v4i32(<4 x i32>, <4 x i32>, <4 x i32>)

declare i8 @llvm.fshr.i8(i8, i8, i8)
declare i16 @llvm.fshr.i16(i16, i16, i16)
declare i32 @llvm.fshr.i32(i32, i32, i32)
declare i64 @llvm.fshr.i64(i64, i64, i64)
declare <4 x i32> @llvm.fshr.v4i32(<4 x i32>, <4 x i32>, <4 x i32>)

; General case - all operands can be variables.

define i16 @fshl_i16(i16 %x, i16 %y, i16 %z) {
; CHECK-LABEL: fshl_i16:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    pkhbt r0, r1, r0, lsl #16
; CHECK-NEXT:    and r1, r2, #15
; CHECK-NEXT:    lsl r0, r0, r1
; CHECK-NEXT:    lsr r0, r0, #16
; CHECK-NEXT:    bx lr
  %f = call i16 @llvm.fshl.i16(i16 %x, i16 %y, i16 %z)
  ret i16 %f
}

define i32 @fshl_i32(i32 %x, i32 %y, i32 %z) {
; CHECK-LABEL: fshl_i32:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    mov r3, #31
; CHECK-NEXT:    lsr r1, r1, #1
; CHECK-NEXT:    bic r3, r3, r2
; CHECK-NEXT:    and r2, r2, #31
; CHECK-NEXT:    lsl r0, r0, r2
; CHECK-NEXT:    orr r0, r0, r1, lsr r3
; CHECK-NEXT:    bx lr
  %f = call i32 @llvm.fshl.i32(i32 %x, i32 %y, i32 %z)
  ret i32 %f
}

; Verify that weird types are minimally supported.
declare i37 @llvm.fshl.i37(i37, i37, i37)
define i37 @fshl_i37(i37 %x, i37 %y, i37 %z) {
; CHECK-LABEL: fshl_i37:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    .save {r4, r5, r6, r7, r8, lr}
; CHECK-NEXT:    push {r4, r5, r6, r7, r8, lr}
; CHECK-NEXT:    mov r8, r1
; CHECK-NEXT:    mov r4, r0
; CHECK-NEXT:    ldr r0, [sp, #24]
; CHECK-NEXT:    mov r6, r3
; CHECK-NEXT:    ldr r1, [sp, #28]
; CHECK-NEXT:    mov r7, r2
; CHECK-NEXT:    mov r2, #37
; CHECK-NEXT:    mov r3, #0
; CHECK-NEXT:    bl __aeabi_uldivmod
; CHECK-NEXT:    mov r0, #63
; CHECK-NEXT:    bic r1, r0, r2
; CHECK-NEXT:    lsl r0, r6, #27
; CHECK-NEXT:    lsl r3, r7, #27
; CHECK-NEXT:    orr r0, r0, r7, lsr #5
; CHECK-NEXT:    and r2, r2, #63
; CHECK-NEXT:    lsrs r7, r0, #1
; CHECK-NEXT:    rrx r0, r3
; CHECK-NEXT:    rsb r3, r1, #32
; CHECK-NEXT:    lsr r0, r0, r1
; CHECK-NEXT:    lsl r6, r4, r2
; CHECK-NEXT:    orr r0, r0, r7, lsl r3
; CHECK-NEXT:    subs r3, r1, #32
; CHECK-NEXT:    lsr r1, r7, r1
; CHECK-NEXT:    lsrpl r0, r7, r3
; CHECK-NEXT:    subs r5, r2, #32
; CHECK-NEXT:    movwpl r6, #0
; CHECK-NEXT:    orr r0, r6, r0
; CHECK-NEXT:    rsb r6, r2, #32
; CHECK-NEXT:    cmp r5, #0
; CHECK-NEXT:    lsr r6, r4, r6
; CHECK-NEXT:    orr r2, r6, r8, lsl r2
; CHECK-NEXT:    lslpl r2, r4, r5
; CHECK-NEXT:    cmp r3, #0
; CHECK-NEXT:    movwpl r1, #0
; CHECK-NEXT:    orr r1, r2, r1
; CHECK-NEXT:    pop {r4, r5, r6, r7, r8, pc}
  %f = call i37 @llvm.fshl.i37(i37 %x, i37 %y, i37 %z)
  ret i37 %f
}

; extract(concat(0b1110000, 0b1111111) << 2) = 0b1000011

declare i7 @llvm.fshl.i7(i7, i7, i7)
define i7 @fshl_i7_const_fold() {
; CHECK-LABEL: fshl_i7_const_fold:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    mov r0, #67
; CHECK-NEXT:    bx lr
  %f = call i7 @llvm.fshl.i7(i7 112, i7 127, i7 2)
  ret i7 %f
}

define i8 @fshl_i8_const_fold_overshift_1() {
; CHECK-LABEL: fshl_i8_const_fold_overshift_1:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    mov r0, #128
; CHECK-NEXT:    bx lr
  %f = call i8 @llvm.fshl.i8(i8 255, i8 0, i8 15)
  ret i8 %f
}

define i8 @fshl_i8_const_fold_overshift_2() {
; CHECK-LABEL: fshl_i8_const_fold_overshift_2:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    mov r0, #120
; CHECK-NEXT:    bx lr
  %f = call i8 @llvm.fshl.i8(i8 15, i8 15, i8 11)
  ret i8 %f
}

define i8 @fshl_i8_const_fold_overshift_3() {
; CHECK-LABEL: fshl_i8_const_fold_overshift_3:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    mov r0, #0
; CHECK-NEXT:    bx lr
  %f = call i8 @llvm.fshl.i8(i8 0, i8 225, i8 8)
  ret i8 %f
}

; With constant shift amount, this is 'extr'.

define i32 @fshl_i32_const_shift(i32 %x, i32 %y) {
; CHECK-LABEL: fshl_i32_const_shift:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    lsl r0, r0, #9
; CHECK-NEXT:    orr r0, r0, r1, lsr #23
; CHECK-NEXT:    bx lr
  %f = call i32 @llvm.fshl.i32(i32 %x, i32 %y, i32 9)
  ret i32 %f
}

; Check modulo math on shift amount.

define i32 @fshl_i32_const_overshift(i32 %x, i32 %y) {
; CHECK-LABEL: fshl_i32_const_overshift:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    lsl r0, r0, #9
; CHECK-NEXT:    orr r0, r0, r1, lsr #23
; CHECK-NEXT:    bx lr
  %f = call i32 @llvm.fshl.i32(i32 %x, i32 %y, i32 41)
  ret i32 %f
}

; 64-bit should also work.

define i64 @fshl_i64_const_overshift(i64 %x, i64 %y) {
; CHECK-LABEL: fshl_i64_const_overshift:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    lsr r1, r2, #23
; CHECK-NEXT:    orr r2, r1, r3, lsl #9
; CHECK-NEXT:    lsl r0, r0, #9
; CHECK-NEXT:    orr r1, r0, r3, lsr #23
; CHECK-NEXT:    mov r0, r2
; CHECK-NEXT:    bx lr
  %f = call i64 @llvm.fshl.i64(i64 %x, i64 %y, i64 105)
  ret i64 %f
}

; This should work without any node-specific logic.

define i8 @fshl_i8_const_fold() {
; CHECK-LABEL: fshl_i8_const_fold:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    mov r0, #128
; CHECK-NEXT:    bx lr
  %f = call i8 @llvm.fshl.i8(i8 255, i8 0, i8 7)
  ret i8 %f
}

; Repeat everything for funnel shift right.

; General case - all operands can be variables.

define i16 @fshr_i16(i16 %x, i16 %y, i16 %z) {
; CHECK-LABEL: fshr_i16:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    pkhbt r0, r1, r0, lsl #16
; CHECK-NEXT:    and r1, r2, #15
; CHECK-NEXT:    lsr r0, r0, r1
; CHECK-NEXT:    bx lr
  %f = call i16 @llvm.fshr.i16(i16 %x, i16 %y, i16 %z)
  ret i16 %f
}

define i32 @fshr_i32(i32 %x, i32 %y, i32 %z) {
; CHECK-LABEL: fshr_i32:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    mov r3, #31
; CHECK-NEXT:    lsl r0, r0, #1
; CHECK-NEXT:    bic r3, r3, r2
; CHECK-NEXT:    and r2, r2, #31
; CHECK-NEXT:    lsl r0, r0, r3
; CHECK-NEXT:    orr r0, r0, r1, lsr r2
; CHECK-NEXT:    bx lr
  %f = call i32 @llvm.fshr.i32(i32 %x, i32 %y, i32 %z)
  ret i32 %f
}

; Verify that weird types are minimally supported.
declare i37 @llvm.fshr.i37(i37, i37, i37)
define i37 @fshr_i37(i37 %x, i37 %y, i37 %z) {
; CHECK-LABEL: fshr_i37:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    .save {r4, r5, r6, r7, r8, r9, r11, lr}
; CHECK-NEXT:    push {r4, r5, r6, r7, r8, r9, r11, lr}
; CHECK-NEXT:    mov r8, r1
; CHECK-NEXT:    mov r9, r0
; CHECK-NEXT:    ldr r0, [sp, #32]
; CHECK-NEXT:    mov r6, r3
; CHECK-NEXT:    ldr r1, [sp, #36]
; CHECK-NEXT:    mov r7, r2
; CHECK-NEXT:    mov r2, #37
; CHECK-NEXT:    mov r3, #0
; CHECK-NEXT:    bl __aeabi_uldivmod
; CHECK-NEXT:    add r0, r2, #27
; CHECK-NEXT:    lsl r2, r7, #27
; CHECK-NEXT:    and r12, r0, #63
; CHECK-NEXT:    lsl r6, r6, #27
; CHECK-NEXT:    orr r7, r6, r7, lsr #5
; CHECK-NEXT:    rsb r3, r12, #32
; CHECK-NEXT:    lsr r2, r2, r12
; CHECK-NEXT:    mov r6, #63
; CHECK-NEXT:    orr r2, r2, r7, lsl r3
; CHECK-NEXT:    subs r3, r12, #32
; CHECK-NEXT:    bic r6, r6, r0
; CHECK-NEXT:    lsl r5, r9, #1
; CHECK-NEXT:    lsrpl r2, r7, r3
; CHECK-NEXT:    subs r1, r6, #32
; CHECK-NEXT:    lsl r0, r5, r6
; CHECK-NEXT:    lsl r4, r8, #1
; CHECK-NEXT:    movwpl r0, #0
; CHECK-NEXT:    orr r4, r4, r9, lsr #31
; CHECK-NEXT:    orr r0, r0, r2
; CHECK-NEXT:    rsb r2, r6, #32
; CHECK-NEXT:    cmp r1, #0
; CHECK-NEXT:    lsr r2, r5, r2
; CHECK-NEXT:    orr r2, r2, r4, lsl r6
; CHECK-NEXT:    lslpl r2, r5, r1
; CHECK-NEXT:    lsr r1, r7, r12
; CHECK-NEXT:    cmp r3, #0
; CHECK-NEXT:    movwpl r1, #0
; CHECK-NEXT:    orr r1, r2, r1
; CHECK-NEXT:    pop {r4, r5, r6, r7, r8, r9, r11, pc}
  %f = call i37 @llvm.fshr.i37(i37 %x, i37 %y, i37 %z)
  ret i37 %f
}

; extract(concat(0b1110000, 0b1111111) >> 2) = 0b0011111

declare i7 @llvm.fshr.i7(i7, i7, i7)
define i7 @fshr_i7_const_fold() {
; CHECK-LABEL: fshr_i7_const_fold:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    mov r0, #31
; CHECK-NEXT:    bx lr
  %f = call i7 @llvm.fshr.i7(i7 112, i7 127, i7 2)
  ret i7 %f
}

define i8 @fshr_i8_const_fold_overshift_1() {
; CHECK-LABEL: fshr_i8_const_fold_overshift_1:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    mov r0, #254
; CHECK-NEXT:    bx lr
  %f = call i8 @llvm.fshr.i8(i8 255, i8 0, i8 15)
  ret i8 %f
}

define i8 @fshr_i8_const_fold_overshift_2() {
; CHECK-LABEL: fshr_i8_const_fold_overshift_2:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    mov r0, #225
; CHECK-NEXT:    bx lr
  %f = call i8 @llvm.fshr.i8(i8 15, i8 15, i8 11)
  ret i8 %f
}

define i8 @fshr_i8_const_fold_overshift_3() {
; CHECK-LABEL: fshr_i8_const_fold_overshift_3:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    mov r0, #255
; CHECK-NEXT:    bx lr
  %f = call i8 @llvm.fshr.i8(i8 0, i8 255, i8 8)
  ret i8 %f
}

; With constant shift amount, this is 'extr'.

define i32 @fshr_i32_const_shift(i32 %x, i32 %y) {
; CHECK-LABEL: fshr_i32_const_shift:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    lsl r0, r0, #23
; CHECK-NEXT:    orr r0, r0, r1, lsr #9
; CHECK-NEXT:    bx lr
  %f = call i32 @llvm.fshr.i32(i32 %x, i32 %y, i32 9)
  ret i32 %f
}

; Check modulo math on shift amount. 41-32=9.

define i32 @fshr_i32_const_overshift(i32 %x, i32 %y) {
; CHECK-LABEL: fshr_i32_const_overshift:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    lsl r0, r0, #23
; CHECK-NEXT:    orr r0, r0, r1, lsr #9
; CHECK-NEXT:    bx lr
  %f = call i32 @llvm.fshr.i32(i32 %x, i32 %y, i32 41)
  ret i32 %f
}

; 64-bit should also work. 105-64 = 41.

define i64 @fshr_i64_const_overshift(i64 %x, i64 %y) {
; CHECK-LABEL: fshr_i64_const_overshift:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    lsl r2, r0, #23
; CHECK-NEXT:    lsl r1, r1, #23
; CHECK-NEXT:    orr r2, r2, r3, lsr #9
; CHECK-NEXT:    orr r1, r1, r0, lsr #9
; CHECK-NEXT:    mov r0, r2
; CHECK-NEXT:    bx lr
  %f = call i64 @llvm.fshr.i64(i64 %x, i64 %y, i64 105)
  ret i64 %f
}

; This should work without any node-specific logic.

define i8 @fshr_i8_const_fold() {
; CHECK-LABEL: fshr_i8_const_fold:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    mov r0, #254
; CHECK-NEXT:    bx lr
  %f = call i8 @llvm.fshr.i8(i8 255, i8 0, i8 7)
  ret i8 %f
}

define i32 @fshl_i32_shift_by_bitwidth(i32 %x, i32 %y) {
; CHECK-LABEL: fshl_i32_shift_by_bitwidth:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    bx lr
  %f = call i32 @llvm.fshl.i32(i32 %x, i32 %y, i32 32)
  ret i32 %f
}

define i32 @fshr_i32_shift_by_bitwidth(i32 %x, i32 %y) {
; CHECK-LABEL: fshr_i32_shift_by_bitwidth:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    mov r0, r1
; CHECK-NEXT:    bx lr
  %f = call i32 @llvm.fshr.i32(i32 %x, i32 %y, i32 32)
  ret i32 %f
}

define <4 x i32> @fshl_v4i32_shift_by_bitwidth(<4 x i32> %x, <4 x i32> %y) {
; CHECK-LABEL: fshl_v4i32_shift_by_bitwidth:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    bx lr
  %f = call <4 x i32> @llvm.fshl.v4i32(<4 x i32> %x, <4 x i32> %y, <4 x i32> <i32 32, i32 32, i32 32, i32 32>)
  ret <4 x i32> %f
}

define <4 x i32> @fshr_v4i32_shift_by_bitwidth(<4 x i32> %x, <4 x i32> %y) {
; SCALAR-LABEL: fshr_v4i32_shift_by_bitwidth:
; SCALAR:       @ %bb.0:
; SCALAR-NEXT:    ldm sp, {r0, r1, r2, r3}
; SCALAR-NEXT:    bx lr
;
; NEON-LABEL: fshr_v4i32_shift_by_bitwidth:
; NEON:       @ %bb.0:
; NEON-NEXT:    mov r0, sp
; NEON-NEXT:    vld1.64 {d16, d17}, [r0]
; NEON-NEXT:    vmov r0, r1, d16
; NEON-NEXT:    vmov r2, r3, d17
; NEON-NEXT:    bx lr
  %f = call <4 x i32> @llvm.fshr.v4i32(<4 x i32> %x, <4 x i32> %y, <4 x i32> <i32 32, i32 32, i32 32, i32 32>)
  ret <4 x i32> %f
}

